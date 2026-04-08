import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
import '../core/job_automation_logging.dart';
import '../core/pascoa_result.dart';
import '../generated/protocol.dart';

class JobAutomationService {
  const JobAutomationService();

  Future<PascoaResult<JobAutomationOverview>> getOverview(
    Session session,
  ) async {
    try {
      final settings = await _getOrCreateSettingsInternal(session);
      final runtime = await _getOrCreateRuntimeInternal(session);
      final overview = await _buildOverview(
        session,
        settings: settings,
        runtime: runtime,
      );
      return Success(overview);
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to load automation overview',
          description:
              'The server could not load the saved automation settings and runtime state.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<PascoaResult<JobAutomationSettings>> getOrCreateSettings(
    Session session,
  ) async {
    try {
      return Success(await _getOrCreateSettingsInternal(session));
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to load automation settings',
          description:
              'The server could not load or initialize the automation settings singleton.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<PascoaResult<JobAutomationRuntime>> getOrCreateRuntime(
    Session session,
  ) async {
    try {
      return Success(await _getOrCreateRuntimeInternal(session));
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to load automation runtime',
          description:
              'The server could not load or initialize the automation runtime singleton.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<PascoaResult<JobAutomationOverview>> updateSettings(
    Session session,
    JobAutomationSettingsUpdate update,
  ) async {
    final validationError = _validateSettingsUpdate(update);
    if (validationError != null) {
      return Failure(validationError);
    }

    try {
      final current = await _getOrCreateSettingsInternal(session);
      final updated = current.copyWith(
        jobFilter: update.jobFilter,
        scoreBatchSize: update.scoreBatchSize,
        proposalBatchSize: update.proposalBatchSize,
        upworkSyncResultsPerPage: update.upworkSyncResultsPerPage,
        proposalMinimumScorePercentage: update.proposalMinimumScorePercentage,
        loopDelayMinutes: update.loopDelayMinutes,
        aiModel: update.aiModel,
        aiThinkingEffort: update.aiThinkingEffort,
        updatedAt: DateTime.now().toUtc(),
      );
      final persisted = await JobAutomationSettings.db.updateRow(
        session,
        updated,
      );
      final runtime = await _getOrCreateRuntimeInternal(session);
      final overview = await _buildOverview(
        session,
        settings: persisted,
        runtime: runtime,
      );
      await _publishOverview(session, overview);
      return Success(overview);
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to save automation settings',
          description:
              'The server could not persist the job automation settings update.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<PascoaResult<JobAutomationOverview>> setJobFetchingPaused(
    Session session, {
    required bool isPaused,
  }) async {
    try {
      final current = await _getOrCreateSettingsInternal(session);
      final updated = current.copyWith(
        isJobFetchingPaused: isPaused,
        updatedAt: DateTime.now().toUtc(),
      );
      final persisted = await JobAutomationSettings.db.updateRow(
        session,
        updated,
      );
      final runtime = await _getOrCreateRuntimeInternal(session);
      final overview = await _buildOverview(
        session,
        settings: persisted,
        runtime: runtime,
      );
      return Success(overview);
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to update pause state',
          description:
              'The server could not update whether Upwork fetching is paused in the automation loop.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<PascoaResult<JobAutomationRuntime>> setCurrentStep(
    Session session,
    JobAutomationStep step,
  ) async {
    try {
      final runtime = await _getOrCreateRuntimeInternal(session);
      final updated = runtime.copyWith(
        currentStep: step,
        currentStepStartedAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      );
      final persisted = await JobAutomationRuntime.db.updateRow(
        session,
        updated,
      );
      final settings = await _getOrCreateSettingsInternal(session);
      final overview = await _buildOverview(
        session,
        settings: settings,
        runtime: persisted,
      );
      await _publishOverview(session, overview);
      return Success(persisted);
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to update automation step',
          description:
              'The server could not update the currently active automation loop step.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<PascoaResult<JobAutomationRuntime>> markJobSyncSuccess(
    Session session,
  ) {
    return _markSuccess(
      session,
      currentStep: JobAutomationStep.fetchingJobs,
      update: (runtime, now) => runtime.copyWith(
        currentStep: JobAutomationStep.fetchingJobs,
        currentStepStartedAt: runtime.currentStepStartedAt,
        updatedAt: now,
        lastSuccessfulJobSyncAt: now,
        lastErrorMessage: null,
        lastErrorAt: null,
      ),
    );
  }

  Future<PascoaResult<JobAutomationRuntime>> markScoringSuccess(
    Session session,
  ) {
    return _markSuccess(
      session,
      currentStep: JobAutomationStep.generatingScores,
      update: (runtime, now) => runtime.copyWith(
        currentStep: JobAutomationStep.generatingScores,
        currentStepStartedAt: runtime.currentStepStartedAt,
        updatedAt: now,
        lastSuccessfulScoringAt: now,
        lastErrorMessage: null,
        lastErrorAt: null,
      ),
    );
  }

  Future<PascoaResult<JobAutomationRuntime>> markProposalSuccess(
    Session session,
  ) {
    return _markSuccess(
      session,
      currentStep: JobAutomationStep.generatingProposals,
      update: (runtime, now) => runtime.copyWith(
        currentStep: JobAutomationStep.generatingProposals,
        currentStepStartedAt: runtime.currentStepStartedAt,
        updatedAt: now,
        lastSuccessfulProposalGenerationAt: now,
        lastErrorMessage: null,
        lastErrorAt: null,
      ),
    );
  }

  Future<PascoaResult<JobAutomationRuntime>> markError(
    Session session, {
    required String message,
  }) async {
    try {
      final runtime = await _getOrCreateRuntimeInternal(session);
      final now = DateTime.now().toUtc();
      final updated = runtime.copyWith(
        currentStep: JobAutomationStep.error,
        currentStepStartedAt: now,
        updatedAt: now,
        lastErrorMessage: message,
        lastErrorAt: now,
      );
      final persisted = await JobAutomationRuntime.db.updateRow(
        session,
        updated,
      );
      final settings = await _getOrCreateSettingsInternal(session);
      final overview = await _buildOverview(
        session,
        settings: settings,
        runtime: persisted,
      );
      await _publishOverview(session, overview);
      logAutomation(session, 'error', message);
      return Success(persisted);
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to record automation error',
          description:
              'The server could not persist the latest automation loop failure state.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<JobAutomationSettings> _getOrCreateSettingsInternal(
    Session session,
  ) async {
    final existing = await JobAutomationSettings.db.findFirstRow(
      session,
      where: (table) => table.singletonKey.equals(jobAutomationSingletonKey),
    );
    if (existing != null) {
      return existing;
    }

    return JobAutomationSettings.db.insertRow(
      session,
      JobAutomationSettings(
        singletonKey: jobAutomationSingletonKey,
        jobFilter: JobFilter(searchQueryTerm: ''),
        isJobFetchingPaused: true,
        scoreBatchSize: defaultScoreBatchSize,
        proposalBatchSize: defaultProposalBatchSize,
        upworkSyncResultsPerPage: defaultUpworkSyncResultsPerPage,
        proposalMinimumScorePercentage: defaultProposalMinimumScorePercentage,
        loopDelayMinutes: defaultLoopDelayMinutes,
        aiModel: JobAutomationAiModel.gpt54,
        aiThinkingEffort: JobAutomationAiThinkingEffort.xhigh,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<JobAutomationRuntime> _getOrCreateRuntimeInternal(
    Session session,
  ) async {
    final existing = await JobAutomationRuntime.db.findFirstRow(
      session,
      where: (table) => table.singletonKey.equals(jobAutomationSingletonKey),
    );
    if (existing != null) {
      return existing;
    }

    final now = DateTime.now().toUtc();
    return JobAutomationRuntime.db.insertRow(
      session,
      JobAutomationRuntime(
        singletonKey: jobAutomationSingletonKey,
        currentStep: JobAutomationStep.idle,
        currentStepStartedAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<PascoaResult<JobAutomationRuntime>> _markSuccess(
    Session session, {
    required JobAutomationStep currentStep,
    required JobAutomationRuntime Function(
      JobAutomationRuntime runtime,
      DateTime now,
    )
    update,
  }) async {
    try {
      final runtime = await _getOrCreateRuntimeInternal(session);
      final now = DateTime.now().toUtc();
      final persisted = await JobAutomationRuntime.db.updateRow(
        session,
        update(runtime, now),
      );
      final settings = await _getOrCreateSettingsInternal(session);
      final overview = await _buildOverview(
        session,
        settings: settings,
        runtime: persisted,
      );
      await _publishOverview(session, overview);
      return Success(persisted);
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to persist automation progress',
          description:
              'The server could not update the successful progress state for the automation loop.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  PascoaException? _validateSettingsUpdate(JobAutomationSettingsUpdate update) {
    if (update.jobFilter.searchQueryTerm.trim().isEmpty) {
      return PascoaException(
        message: 'Search query is required',
        description:
            'The saved server-side job filter must contain a non-empty search query term.',
      );
    }

    if (update.scoreBatchSize < 1 ||
        update.proposalBatchSize < 1 ||
        update.upworkSyncResultsPerPage < 1 ||
        update.loopDelayMinutes < 1) {
      return PascoaException(
        message: 'Invalid automation limits',
        description:
            'Batch sizes, Upwork sync results per page, and loop delay must all be at least 1.',
      );
    }

    if (update.proposalMinimumScorePercentage < 0 ||
        update.proposalMinimumScorePercentage > 100) {
      return PascoaException(
        message: 'Invalid proposal minimum score',
        description:
            'The minimum score required before proposal generation must stay between 0 and 100.',
      );
    }

    return null;
  }

  Future<void> _publishOverview(
    Session session,
    JobAutomationOverview overview,
  ) async {
    await session.messages.postMessage(
      jobAutomationOverviewChannel,
      overview,
    );
  }

  Future<PascoaResult<JobAutomationOverview>> publishCurrentOverview(
    Session session,
  ) async {
    try {
      final settings = await _getOrCreateSettingsInternal(session);
      final runtime = await _getOrCreateRuntimeInternal(session);
      final overview = await _buildOverview(
        session,
        settings: settings,
        runtime: runtime,
      );
      await _publishOverview(session, overview);
      return Success(overview);
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to publish automation overview',
          description:
              'The server could not publish the latest automation overview to subscribers.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<JobAutomationOverview> _buildOverview(
    Session session, {
    required JobAutomationSettings settings,
    required JobAutomationRuntime runtime,
  }) async {
    return JobAutomationOverview(
      settings: settings,
      runtime: runtime,
      isLoopActive: await _computeIsLoopActive(
        session,
        settings: settings,
        runtime: runtime,
      ),
    );
  }

  Future<bool> _computeIsLoopActive(
    Session session, {
    required JobAutomationSettings settings,
    required JobAutomationRuntime runtime,
  }) async {
    if (settings.isJobFetchingPaused) {
      return false;
    }

    if (_isRuntimeStepActive(runtime.currentStep)) {
      return true;
    }

    return _hasScheduledAutomationFutureCalls(session);
  }

  bool _isRuntimeStepActive(JobAutomationStep step) {
    return switch (step) {
      JobAutomationStep.fetchingJobs ||
      JobAutomationStep.generatingScores ||
      JobAutomationStep.generatingProposals => true,
      _ => false,
    };
  }

  Future<bool> _hasScheduledAutomationFutureCalls(Session session) async {
    final rows = await session.db.unsafeQuery(
      '''
      SELECT COUNT(*)::int
      FROM serverpod_future_call
      WHERE identifier IN (
        @syncIdentifier,
        @scoreIdentifier,
        @proposalIdentifier
      )
      ''',
      parameters: QueryParameters.named({
        'syncIdentifier': jobAutomationSyncFutureCallIdentifier,
        'scoreIdentifier': jobAutomationScoreFutureCallIdentifier,
        'proposalIdentifier': jobAutomationProposalFutureCallIdentifier,
      }),
    );

    if (rows.isEmpty) {
      return false;
    }

    return (rows.first[0] as int) > 0;
  }

  PascoaException _buildException({
    required String message,
    required String description,
    required Object error,
    required StackTrace stackTrace,
  }) {
    return PascoaException(
      message: message,
      description: description,
      error: error.toString(),
      stackTrace: stackTrace.toString(),
    );
  }
}
