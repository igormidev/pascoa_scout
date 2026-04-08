import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/pascoa_result.dart';
import '../generated/protocol.dart';
import 'job_analysis_include.dart';

class JobAnalysisQueryService {
  const JobAnalysisQueryService();

  Future<PascoaResult<JobAnalysisPagination>> getPage(
    Session session,
    JobAnalysisListFilter filter,
  ) async {
    final validationError = _validateFilter(filter);
    if (validationError != null) {
      return Failure(validationError);
    }

    try {
      final referenceStamp =
          filter.referencePaginationHourStamp?.toUtc() ??
          DateTime.now().toUtc();
      final where = _buildWhere(filter, referenceStamp);
      final totalCount = await JobAnalysisState.db.count(
        session,
        where: (_) => where,
      );
      final sortedIds = await _loadSortedRowIds(
        session,
        where: where,
        orderBy: filter.orderBy,
      );
      final pageIds = _slicePageIds(
        ids: sortedIds,
        page: filter.page,
        pageSize: filter.pageSize,
      );
      final items = await _loadPageItems(
        session,
        pageIds: pageIds,
      );

      final totalPages = totalCount == 0
          ? 0
          : ((totalCount + filter.pageSize - 1) / filter.pageSize).floor();
      return Success(
        JobAnalysisPagination(
          items: items.map(_normalizeAnalysisState).toList(growable: false),
          paginationMetadata: PaginationMetadata(
            currentPage: filter.page,
            pageSize: filter.pageSize,
            totalCount: totalCount,
            totalPages: totalPages,
            hasNextPage: filter.page < totalPages,
            hasPreviousPage: filter.page > 1,
            referencePaginationHourStamp: referenceStamp,
          ),
        ),
      );
    } catch (error, stackTrace) {
      return Failure(
        PascoaException(
          message: 'Unable to load the job analysis page',
          description:
              'The server could not build the filtered and paginated job analysis response.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
  }

  Future<PascoaResult<JobAnalysisState>> getById(
    Session session, {
    required int jobAnalysisStateId,
  }) async {
    try {
      final row = await _loadAnalysisStateById(
        session,
        jobAnalysisStateId: jobAnalysisStateId,
      );
      if (row == null) {
        return Failure(
          PascoaException(
            message: 'Job analysis not found',
            description:
                'The requested job analysis card could not be found in the database.',
          ),
        );
      }

      return Success(_normalizeAnalysisState(row));
    } catch (error, stackTrace) {
      return Failure(
        PascoaException(
          message: 'Unable to refresh the job analysis card',
          description:
              'The server could not load the latest persisted state for the requested job card.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
  }

  Future<PascoaResult<JobAnalysisState>> markJobViewed(
    Session session, {
    required int jobAnalysisStateId,
  }) async {
    try {
      final row = await _loadAnalysisStateById(
        session,
        jobAnalysisStateId: jobAnalysisStateId,
      );
      if (row == null) {
        return Failure(
          PascoaException(
            message: 'Job analysis not found',
            description:
                'The requested job analysis card could not be found in the database.',
          ),
        );
      }

      final jobInfo = row.jobInfo;
      if (jobInfo == null) {
        return Failure(
          PascoaException(
            message: 'Job information not found',
            description:
                'The requested job analysis does not have a persisted job information row to update.',
          ),
        );
      }

      if (!row.didViewJob) {
        await JobAnalysisState.db.updateRow(
          session,
          row.copyWith(didViewJob: true),
        );
      }

      final updatedRow = await _loadAnalysisStateById(
        session,
        jobAnalysisStateId: jobAnalysisStateId,
      );
      if (updatedRow == null) {
        return Failure(
          PascoaException(
            message: 'Updated job analysis not found',
            description:
                'The job analysis was updated, but the server could not reload the persisted row afterwards.',
          ),
        );
      }

      return Success(_normalizeAnalysisState(updatedRow));
    } catch (error, stackTrace) {
      return Failure(
        PascoaException(
          message: 'Unable to mark the job as viewed',
          description:
              'The server could not persist the viewed state for the requested job card.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
  }

  PascoaException? _validateFilter(JobAnalysisListFilter filter) {
    if (filter.page < 1 || filter.pageSize < 1) {
      return PascoaException(
        message: 'Invalid pagination parameters',
        description:
            'Both page and pageSize must be positive integers when querying job analyses.',
      );
    }
    if (filter.minimumScorePercentage != null &&
        (filter.minimumScorePercentage! < 0 ||
            filter.minimumScorePercentage! > 100)) {
      return PascoaException(
        message: 'Invalid minimum score filter',
        description: 'The minimum score filter must stay between 0 and 100.',
      );
    }
    if (filter.maximumScorePercentage != null &&
        (filter.maximumScorePercentage! < 0 ||
            filter.maximumScorePercentage! > 100)) {
      return PascoaException(
        message: 'Invalid maximum score filter',
        description: 'The maximum score filter must stay between 0 and 100.',
      );
    }
    if (filter.minimumScorePercentage != null &&
        filter.maximumScorePercentage != null &&
        filter.minimumScorePercentage! > filter.maximumScorePercentage!) {
      return PascoaException(
        message: 'Invalid score window',
        description:
            'The minimum score filter cannot be greater than the maximum score filter.',
      );
    }
    return null;
  }

  Expression _buildWhere(
    JobAnalysisListFilter filter,
    DateTime referenceStamp,
  ) {
    Expression where = Constant.bool(true);

    where = where & (JobAnalysisState.t.createdJobInfoAt <= referenceStamp);
    where =
        where &
        (JobAnalysisState.t.createdJobScoringAt.equals(null) |
            (JobAnalysisState.t.createdJobScoringAt <= referenceStamp));
    where =
        where &
        (JobAnalysisState.t.createdJobAiResponsesAt.equals(null) |
            (JobAnalysisState.t.createdJobAiResponsesAt <= referenceStamp));

    final searchTerm = filter.searchTerm?.trim();
    if (searchTerm != null && searchTerm.isNotEmpty) {
      final pattern = '%$searchTerm%';
      where =
          where &
          (JobAnalysisState.t.jobInfo.title.ilike(pattern) |
              JobAnalysisState.t.jobInfo.description.ilike(pattern) |
              JobAnalysisState.t.jobInfo.clientName.ilike(pattern));
    }

    switch (filter.analysisFilter) {
      case JobAnalysisFilterMode.all:
        break;
      case JobAnalysisFilterMode.withoutScore:
        where = where & JobAnalysisState.t.score.id.equals(null);
      case JobAnalysisFilterMode.withScore:
        where = where & JobAnalysisState.t.score.id.notEquals(null);
      case JobAnalysisFilterMode.withoutProposal:
        where = where & JobAnalysisState.t.proposal.id.equals(null);
      case JobAnalysisFilterMode.withProposal:
        where = where & JobAnalysisState.t.proposal.id.notEquals(null);
      case JobAnalysisFilterMode.completed:
        where =
            where &
            JobAnalysisState.t.score.id.notEquals(null) &
            JobAnalysisState.t.proposal.id.notEquals(null);
    }

    if (filter.hasQuestions != null) {
      where =
          where &
          (filter.hasQuestions!
              ? JobAnalysisState.t.jobInfo.questions.any()
              : JobAnalysisState.t.jobInfo.questions.none());
    }

    if (filter.minimumScorePercentage != null) {
      where =
          where &
          (JobAnalysisState.t.score.scorePercentage >=
              filter.minimumScorePercentage!);
    }
    if (filter.maximumScorePercentage != null) {
      where =
          where &
          (JobAnalysisState.t.score.scorePercentage <=
              filter.maximumScorePercentage!);
    }

    if (filter.maxAgeJobInfoHours != null) {
      final minimumCreatedAt = referenceStamp.subtract(
        Duration(hours: filter.maxAgeJobInfoHours!),
      );
      where = where & (JobAnalysisState.t.createdJobInfoAt >= minimumCreatedAt);
    }
    if (filter.maxAgeScoringHours != null) {
      final minimumCreatedAt = referenceStamp.subtract(
        Duration(hours: filter.maxAgeScoringHours!),
      );
      where =
          where & (JobAnalysisState.t.createdJobScoringAt >= minimumCreatedAt);
    }
    if (filter.maxAgeAiResponsesHours != null) {
      final minimumCreatedAt = referenceStamp.subtract(
        Duration(hours: filter.maxAgeAiResponsesHours!),
      );
      where =
          where &
          (JobAnalysisState.t.createdJobAiResponsesAt >= minimumCreatedAt);
    }

    return where;
  }

  Future<List<int>> _loadSortedRowIds(
    Session session, {
    required Expression where,
    required JobAnalysisOrderBy orderBy,
  }) async {
    final rows = await JobAnalysisState.db.find(
      session,
      where: (_) => where,
      include: JobAnalysisState.include(
        jobInfo: JobInfo.include(),
        score: JobScore.include(),
      ),
    );

    rows.sort((left, right) => _compareRows(left, right, orderBy));
    return rows.map((row) => row.id!).toList(growable: false);
  }

  List<int> _slicePageIds({
    required List<int> ids,
    required int page,
    required int pageSize,
  }) {
    final start = (page - 1) * pageSize;
    if (start >= ids.length) {
      return const [];
    }

    final end = (start + pageSize).clamp(0, ids.length);
    return ids.sublist(start, end);
  }

  Future<List<JobAnalysisState>> _loadPageItems(
    Session session, {
    required List<int> pageIds,
  }) async {
    if (pageIds.isEmpty) {
      return const [];
    }

    final rows = await JobAnalysisState.db.find(
      session,
      where: (table) => table.id.inSet(pageIds.toSet()),
      include: buildJobAnalysisStateInclude(),
    );
    final rowsById = {
      for (final row in rows)
        if (row.id != null) row.id!: _normalizeAnalysisState(row),
    };

    return pageIds
        .map((id) => rowsById[id])
        .whereType<JobAnalysisState>()
        .toList(growable: false);
  }

  Future<JobAnalysisState?> _loadAnalysisStateById(
    Session session, {
    required int jobAnalysisStateId,
  }) {
    return JobAnalysisState.db.findById(
      session,
      jobAnalysisStateId,
      include: buildJobAnalysisStateInclude(),
    );
  }

  int _compareRows(
    JobAnalysisState left,
    JobAnalysisState right,
    JobAnalysisOrderBy orderBy,
  ) {
    final primary = switch (orderBy) {
      JobAnalysisOrderBy.highestScore => _compareNullable(
        left.score?.scorePercentage,
        right.score?.scorePercentage,
        descending: true,
      ),
      JobAnalysisOrderBy.highestHourlyRate => _compareNullable(
        left.jobInfo?.hourlyMaxRate,
        right.jobInfo?.hourlyMaxRate,
        descending: true,
      ),
      JobAnalysisOrderBy.lowestHourlyRate => _compareNullable(
        left.jobInfo?.hourlyMinRate,
        right.jobInfo?.hourlyMinRate,
        descending: false,
      ),
      JobAnalysisOrderBy.highestFixedPrice => _compareNullable(
        left.jobInfo?.fixedPriceAmount,
        right.jobInfo?.fixedPriceAmount,
        descending: true,
      ),
      JobAnalysisOrderBy.lowestFixedPrice => _compareNullable(
        left.jobInfo?.fixedPriceAmount,
        right.jobInfo?.fixedPriceAmount,
        descending: false,
      ),
      JobAnalysisOrderBy.newestRelativeDate => _compareNullable(
        left.jobInfo?.relativeDateMinutes,
        right.jobInfo?.relativeDateMinutes,
        descending: false,
      ),
      JobAnalysisOrderBy.newestAbsoluteDate => _compareNullable(
        left.jobInfo?.absoluteDateTime,
        right.jobInfo?.absoluteDateTime,
        descending: true,
      ),
      JobAnalysisOrderBy.mostRecentJobInfoCreatedAt => _compareNullable(
        left.createdJobInfoAt,
        right.createdJobInfoAt,
        descending: true,
      ),
      JobAnalysisOrderBy.mostRecentScoringCreatedAt => _compareNullable(
        left.createdJobScoringAt,
        right.createdJobScoringAt,
        descending: true,
      ),
      JobAnalysisOrderBy.mostRecentAiResponsesCreatedAt => _compareNullable(
        left.createdJobAiResponsesAt,
        right.createdJobAiResponsesAt,
        descending: true,
      ),
      JobAnalysisOrderBy.highestClientHireRate => _compareNullable(
        left.jobInfo?.clientHireRatePercent,
        right.jobInfo?.clientHireRatePercent,
        descending: true,
      ),
      JobAnalysisOrderBy.highestClientAverageHourlyRate => _compareNullable(
        left.jobInfo?.clientAvgHourlyRate,
        right.jobInfo?.clientAvgHourlyRate,
        descending: true,
      ),
      JobAnalysisOrderBy.highestClientNameConfidence => _compareNullable(
        left.jobInfo?.clientNameConfidencePercent,
        right.jobInfo?.clientNameConfidencePercent,
        descending: true,
      ),
      JobAnalysisOrderBy.highestClientRating => _compareNullable(
        left.jobInfo?.clientRating,
        right.jobInfo?.clientRating,
        descending: true,
      ),
      JobAnalysisOrderBy.highestClientTotalSpent => _compareNullable(
        left.jobInfo?.clientTotalSpent,
        right.jobInfo?.clientTotalSpent,
        descending: true,
      ),
    };
    if (primary != 0) {
      return primary;
    }

    final createdAtTieBreak = _compareNullable(
      left.createdJobInfoAt,
      right.createdJobInfoAt,
      descending: true,
    );
    if (createdAtTieBreak != 0) {
      return createdAtTieBreak;
    }

    return _compareNullable(left.id, right.id, descending: true);
  }

  int _compareNullable<T extends Comparable<dynamic>>(
    T? left,
    T? right, {
    required bool descending,
  }) {
    if (left == null && right == null) {
      return 0;
    }
    if (left == null) {
      return 1;
    }
    if (right == null) {
      return -1;
    }

    return descending ? right.compareTo(left) : left.compareTo(right);
  }

  JobAnalysisState _normalizeAnalysisState(JobAnalysisState row) {
    final sortedQuestions = [
      ...?row.jobInfo?.questions,
    ]..sort((left, right) => left.positionIndex.compareTo(right.positionIndex));
    final sortedAnswers = [...?row.proposal?.answers]
      ..sort(
        (left, right) => (left.relatedQuestion?.positionIndex ?? 0).compareTo(
          right.relatedQuestion?.positionIndex ?? 0,
        ),
      );
    final sortedMilestones = [
      ...?row.proposal?.milestones,
    ]..sort((left, right) => left.positionIndex.compareTo(right.positionIndex));

    return row.copyWith(
      jobInfo: row.jobInfo?.copyWith(questions: sortedQuestions),
      proposal: row.proposal?.copyWith(
        answers: sortedAnswers,
        milestones: sortedMilestones.isEmpty ? null : sortedMilestones,
      ),
    );
  }
}
