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

      final items = await JobAnalysisState.db.find(
        session,
        where: (_) => where,
        orderBy: _buildOrderBy(filter.orderBy),
        orderDescending: _isDescending(filter.orderBy),
        limit: filter.pageSize,
        offset: (filter.page - 1) * filter.pageSize,
        include: buildJobAnalysisStateInclude(),
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
      final row = await JobAnalysisState.db.findById(
        session,
        jobAnalysisStateId,
        include: buildJobAnalysisStateInclude(),
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

  OrderByBuilder<JobAnalysisStateTable> _buildOrderBy(
    JobAnalysisOrderBy orderBy,
  ) {
    return switch (orderBy) {
      JobAnalysisOrderBy.highestHourlyRate =>
        (table) => table.jobInfo.hourlyMaxRate,
      JobAnalysisOrderBy.lowestHourlyRate =>
        (table) => table.jobInfo.hourlyMinRate,
      JobAnalysisOrderBy.highestFixedPrice =>
        (table) => table.jobInfo.fixedPriceAmount,
      JobAnalysisOrderBy.lowestFixedPrice =>
        (table) => table.jobInfo.fixedPriceAmount,
      JobAnalysisOrderBy.newestRelativeDate =>
        (table) => table.jobInfo.relativeDateMinutes,
      JobAnalysisOrderBy.newestAbsoluteDate =>
        (table) => table.jobInfo.absoluteDateTime,
      JobAnalysisOrderBy.mostRecentJobInfoCreatedAt =>
        (table) => table.createdJobInfoAt,
      JobAnalysisOrderBy.mostRecentScoringCreatedAt =>
        (table) => table.createdJobScoringAt,
      JobAnalysisOrderBy.mostRecentAiResponsesCreatedAt =>
        (table) => table.createdJobAiResponsesAt,
      JobAnalysisOrderBy.highestClientHireRate =>
        (table) => table.jobInfo.clientHireRatePercent,
      JobAnalysisOrderBy.highestClientAverageHourlyRate =>
        (table) => table.jobInfo.clientAvgHourlyRate,
      JobAnalysisOrderBy.highestClientNameConfidence =>
        (table) => table.jobInfo.clientNameConfidencePercent,
      JobAnalysisOrderBy.highestClientRating =>
        (table) => table.jobInfo.clientRating,
      JobAnalysisOrderBy.highestClientTotalSpent =>
        (table) => table.jobInfo.clientTotalSpent,
    };
  }

  bool _isDescending(JobAnalysisOrderBy orderBy) {
    return switch (orderBy) {
      JobAnalysisOrderBy.highestHourlyRate ||
      JobAnalysisOrderBy.highestFixedPrice ||
      JobAnalysisOrderBy.newestAbsoluteDate ||
      JobAnalysisOrderBy.mostRecentJobInfoCreatedAt ||
      JobAnalysisOrderBy.mostRecentScoringCreatedAt ||
      JobAnalysisOrderBy.mostRecentAiResponsesCreatedAt ||
      JobAnalysisOrderBy.highestClientHireRate ||
      JobAnalysisOrderBy.highestClientAverageHourlyRate ||
      JobAnalysisOrderBy.highestClientNameConfidence ||
      JobAnalysisOrderBy.highestClientRating ||
      JobAnalysisOrderBy.highestClientTotalSpent => true,
      JobAnalysisOrderBy.lowestHourlyRate ||
      JobAnalysisOrderBy.lowestFixedPrice ||
      JobAnalysisOrderBy.newestRelativeDate => false,
    };
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

    return row.copyWith(
      jobInfo: row.jobInfo?.copyWith(questions: sortedQuestions),
      proposal: row.proposal?.copyWith(answers: sortedAnswers),
    );
  }
}
