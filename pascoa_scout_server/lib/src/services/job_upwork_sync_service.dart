import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/job_automation_logging.dart';
import '../core/pascoa_result.dart';
import '../generated/protocol.dart';
import '../repository/get_upwork_jobs_repository.dart';

class JobUpworkSyncService {
  const JobUpworkSyncService({
    IGetUpworkJobsRepository? repository,
  }) : _repository = repository;

  final IGetUpworkJobsRepository? _repository;

  Future<PascoaResult<int>> syncLatestJobs(
    Session session, {
    required JobFilter filter,
    required int resultsPerPage,
  }) async {
    try {
      final repository = _repository;
      if (repository == null) {
        final apifyToken = Serverpod.instance.getPassword('apifyToken');
        if (apifyToken == null || apifyToken.isEmpty) {
          return Failure(
            PascoaException(
              message: 'Missing Apify token',
              description:
                  'Add apifyToken to pascoa_scout_server/config/passwords.yaml before running the automation loop.',
            ),
          );
        }

        return _syncWithRepository(
          session,
          repository: GetUpworkJobRepositoryApifyImpl(apifyToken: apifyToken),
          filter: filter,
          resultsPerPage: resultsPerPage,
        );
      }

      return _syncWithRepository(
        session,
        repository: repository,
        filter: filter,
        resultsPerPage: resultsPerPage,
      );
    } catch (error, stackTrace) {
      return Failure(
        PascoaException(
          message: 'Unable to synchronize Upwork jobs',
          description:
              'The automation loop could not fetch and persist the latest jobs from Apify.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
  }

  Future<PascoaResult<int>> _syncWithRepository(
    Session session, {
    required IGetUpworkJobsRepository repository,
    required JobFilter filter,
    required int resultsPerPage,
  }) async {
    final result = await repository.getJobs(
      filter: filter,
      pagination: Pagination(
        pageNumber: 1,
        pagesToScrape: 1,
        resultsPerPage: resultsPerPage,
        searchSortOrder: SearchSortOrder.newest,
      ),
    );

    return await result.fold(
      (jobs) async {
        var processedCount = 0;
        var insertedCount = 0;
        var refreshedCount = 0;
        logAutomation(
          session,
          'sync',
          'received ${jobs.length} job(s) from the Upwork provider',
        );

        for (final job in jobs) {
          final outcome = await _upsertJob(session, job);
          processedCount += 1;
          switch (outcome) {
            case _JobUpsertOutcome.inserted:
              insertedCount += 1;
            case _JobUpsertOutcome.updated:
              refreshedCount += 1;
          }
        }

        logAutomation(
          session,
          'sync',
          'synchronized $processedCount job(s) (new=$insertedCount, refreshed=$refreshedCount)',
        );

        return Success(processedCount);
      },
      Failure.new,
    );
  }

  Future<_JobUpsertOutcome> _upsertJob(
    Session session,
    JobInfo incomingJob,
  ) async {
    return session.db.transaction((transaction) async {
      final existingJob = await JobInfo.db.findFirstRow(
        session,
        where: (table) => table.upworkId.equals(incomingJob.upworkId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );

      if (existingJob == null) {
        await _insertNewJob(session, incomingJob, transaction);
        return _JobUpsertOutcome.inserted;
      }

      final existingAnalysisState = await JobAnalysisState.db.findFirstRow(
        session,
        where: (table) => table.jobInfoId.equals(existingJob.id),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );

      await _updateExistingJob(
        session,
        existingJob: existingJob,
        existingAnalysisState: existingAnalysisState,
        incomingJob: incomingJob,
        transaction: transaction,
      );

      return _JobUpsertOutcome.updated;
    });
  }

  Future<void> _insertNewJob(
    Session session,
    JobInfo incomingJob,
    Transaction transaction,
  ) async {
    final insertedJob = await JobInfo.db.insertRow(
      session,
      incomingJob.copyWith(
        questions: null,
        analysisState: null,
      ),
      transaction: transaction,
    );

    await JobAnalysisState.db.insertRow(
      session,
      JobAnalysisState(
        jobInfoId: insertedJob.id!,
        createdJobInfoAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );

    if ((incomingJob.questions?.isNotEmpty ?? false)) {
      await Question.db.insert(
        session,
        [
          for (final question in incomingJob.questions ?? const <Question>[])
            question.copyWith(jobInfoId: insertedJob.id),
        ],
        transaction: transaction,
      );
    }
  }

  Future<void> _updateExistingJob(
    Session session, {
    required JobInfo existingJob,
    required JobAnalysisState? existingAnalysisState,
    required JobInfo incomingJob,
    required Transaction transaction,
  }) async {
    final jobId = existingJob.id!;
    final updatedJob = existingJob.copyWith(
      upworkId: incomingJob.upworkId,
      subId: incomingJob.subId,
      title: incomingJob.title,
      description: incomingJob.description,
      url: incomingJob.url,
      relativeDate: incomingJob.relativeDate,
      relativeDateMinutes: incomingJob.relativeDateMinutes,
      absoluteDate: incomingJob.absoluteDate,
      absoluteDateTime: incomingJob.absoluteDateTime,
      budget: incomingJob.budget,
      fixedPriceAmount: incomingJob.fixedPriceAmount,
      hourlyMinRate: incomingJob.hourlyMinRate,
      hourlyMaxRate: incomingJob.hourlyMaxRate,
      jobType: incomingJob.jobType,
      experienceLevel: incomingJob.experienceLevel,
      clientLocation: incomingJob.clientLocation,
      paymentVerifiedStatus: incomingJob.paymentVerifiedStatus,
      allowedApplicantCountries: incomingJob.allowedApplicantCountries,
      clientName: incomingJob.clientName,
      clientNameConfidencePercent: incomingJob.clientNameConfidencePercent,
      clientAvgHourlyRate: incomingJob.clientAvgHourlyRate,
      clientRating: incomingJob.clientRating,
      clientHireRatePercent: incomingJob.clientHireRatePercent,
      clientTotalSpent: incomingJob.clientTotalSpent,
      tags: incomingJob.tags,
      hasHired: incomingJob.hasHired,
    );

    await JobInfo.db.updateRow(
      session,
      updatedJob,
      transaction: transaction,
    );

    final existingQuestions = await Question.db.find(
      session,
      where: (table) => table.jobInfoId.equals(jobId),
      orderBy: (table) => table.positionIndex,
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    final incomingQuestions = [
      ...?incomingJob.questions,
    ]..sort((left, right) => left.positionIndex.compareTo(right.positionIndex));

    if (_didQuestionsChange(
      existingQuestions: existingQuestions,
      incomingQuestions: incomingQuestions,
    )) {
      await _invalidateExistingProposal(
        session,
        existingAnalysisState: existingAnalysisState,
        transaction: transaction,
      );

      await _syncQuestions(
        session,
        jobInfoId: jobId,
        existingQuestions: existingQuestions,
        incomingQuestions: incomingQuestions,
        transaction: transaction,
      );
    }

    if (existingAnalysisState == null) {
      await JobAnalysisState.db.insertRow(
        session,
        JobAnalysisState(
          jobInfoId: jobId,
          createdJobInfoAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
    }
  }

  bool _didQuestionsChange({
    required List<Question> existingQuestions,
    required List<Question> incomingQuestions,
  }) {
    if (existingQuestions.length != incomingQuestions.length) {
      return true;
    }

    for (var index = 0; index < existingQuestions.length; index++) {
      final existingQuestion = existingQuestions[index];
      final incomingQuestion = incomingQuestions[index];
      if (existingQuestion.positionIndex != incomingQuestion.positionIndex ||
          existingQuestion.question != incomingQuestion.question) {
        return true;
      }
    }

    return false;
  }

  Future<void> _invalidateExistingProposal(
    Session session, {
    required JobAnalysisState? existingAnalysisState,
    required Transaction transaction,
  }) async {
    if (existingAnalysisState == null) {
      return;
    }

    final existingProposal = await JobProposal.db.findFirstRow(
      session,
      where: (table) =>
          table.jobAnalysisStateId.equals(existingAnalysisState.id),
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );

    if (existingProposal != null) {
      await JobProposalAnswerToQuestion.db.deleteWhere(
        session,
        where: (table) => table.jobProposalId.equals(existingProposal.id),
        transaction: transaction,
      );
      await JobProposalMilestone.db.deleteWhere(
        session,
        where: (table) => table.jobProposalId.equals(existingProposal.id),
        transaction: transaction,
      );
      await JobProposal.db.deleteRow(
        session,
        existingProposal,
        transaction: transaction,
      );
    }

    if (existingAnalysisState.createdJobAiResponsesAt != null) {
      await JobAnalysisState.db.updateRow(
        session,
        existingAnalysisState.copyWith(createdJobAiResponsesAt: null),
        columns: (table) => [table.createdJobAiResponsesAt],
        transaction: transaction,
      );
    }
  }

  Future<void> _syncQuestions(
    Session session, {
    required int jobInfoId,
    required List<Question> existingQuestions,
    required List<Question> incomingQuestions,
    required Transaction transaction,
  }) async {
    final existingQuestionsByPosition = {
      for (final question in existingQuestions)
        question.positionIndex: question,
    };
    final incomingPositions = incomingQuestions
        .map((question) => question.positionIndex)
        .toSet();

    final questionsToUpdate = <Question>[];
    final questionsToInsert = <Question>[];
    for (final incomingQuestion in incomingQuestions) {
      final existingQuestion =
          existingQuestionsByPosition[incomingQuestion.positionIndex];
      if (existingQuestion == null) {
        questionsToInsert.add(incomingQuestion.copyWith(jobInfoId: jobInfoId));
        continue;
      }

      if (existingQuestion.question != incomingQuestion.question) {
        questionsToUpdate.add(
          existingQuestion.copyWith(question: incomingQuestion.question),
        );
      }
    }

    final questionsToDelete = existingQuestions
        .where(
          (question) => !incomingPositions.contains(question.positionIndex),
        )
        .toList(growable: false);

    if (questionsToDelete.isNotEmpty) {
      await Question.db.delete(
        session,
        questionsToDelete,
        transaction: transaction,
      );
    }

    if (questionsToUpdate.isNotEmpty) {
      await Question.db.update(
        session,
        questionsToUpdate,
        columns: (table) => [table.question],
        transaction: transaction,
      );
    }

    if (questionsToInsert.isNotEmpty) {
      await Question.db.insert(
        session,
        questionsToInsert,
        transaction: transaction,
      );
    }
  }
}

enum _JobUpsertOutcome {
  inserted,
  updated,
}
