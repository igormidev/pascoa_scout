import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
import '../generated/protocol.dart';
import '../services/job_automation_loop_scheduler.dart';
import '../services/job_automation_service.dart';
import '../services/job_upwork_sync_service.dart';

class JobAutomationSyncFutureCall extends FutureCall {
  JobAutomationSyncFutureCall({
    JobAutomationService? automationService,
    JobAutomationLoopScheduler? scheduler,
    JobUpworkSyncService? syncService,
  }) : _automationService = automationService ?? const JobAutomationService(),
       _scheduler = scheduler ?? const JobAutomationLoopScheduler(),
       _syncService = syncService ?? const JobUpworkSyncService();

  final JobAutomationService _automationService;
  final JobAutomationLoopScheduler _scheduler;
  final JobUpworkSyncService _syncService;

  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    final settingsResult = await _automationService.getOrCreateSettings(
      session,
    );
    final settings = settingsResult.fold(
      (value) => value,
      (error) => throw error,
    );

    if (settings.jobFilter.searchQueryTerm.trim().isEmpty) {
      await _automationService.markError(
        session,
        message:
            'The automation loop cannot fetch Upwork jobs until a non-empty server-side filter has been saved.',
      );
      await _scheduler.reschedule(
        session,
        callName: jobAutomationScoreFutureCallName,
        identifier: jobAutomationScoreFutureCallIdentifier,
        delay: Duration(minutes: settings.loopDelayMinutes),
      );
      return;
    }

    if (settings.isJobFetchingPaused) {
      await _automationService.setCurrentStep(
        session,
        JobAutomationStep.pausedWaiting,
      );
      return;
    }

    await _automationService.setCurrentStep(
      session,
      JobAutomationStep.fetchingJobs,
    );
    final syncResult = await _syncService.syncLatestJobs(
      session,
      filter: settings.jobFilter,
      resultsPerPage: settings.upworkSyncResultsPerPage,
    );
    await syncResult.fold(
      (_) => _automationService.markJobSyncSuccess(session),
      (error) => _automationService.markError(session, message: error.message),
    );

    final latestSettingsResult = await _automationService.getOrCreateSettings(
      session,
    );
    final latestSettings = latestSettingsResult.fold(
      (value) => value,
      (error) => throw error,
    );
    if (latestSettings.isJobFetchingPaused) {
      await _automationService.setCurrentStep(
        session,
        JobAutomationStep.pausedWaiting,
      );
      return;
    }

    await _scheduler.reschedule(
      session,
      callName: jobAutomationScoreFutureCallName,
      identifier: jobAutomationScoreFutureCallIdentifier,
      delay: Duration(minutes: latestSettings.loopDelayMinutes),
    );
  }
}
