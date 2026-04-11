import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
import '../core/job_automation_logging.dart';
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
      logAutomationDone(
        session,
        AutomationLogScope.sync,
        'step fetch skipped | reason=empty server filter query',
      );
      await _automationService.markError(
        session,
        message:
            'The automation loop cannot fetch Upwork jobs until a non-empty server-side filter has been saved.',
      );
      await _scheduler.reschedule(
        session,
        callName: jobAutomationSyncFutureCallName,
        identifier: jobAutomationSyncFutureCallIdentifier,
        delay: Duration(minutes: settings.loopDelayMinutes),
      );
      logAutomationStart(
        session,
        AutomationLogScope.loop,
        'sync step queued | delay=${settings.loopDelayMinutes}m reason=empty-query',
      );
      return;
    }

    if (settings.isJobFetchingPaused) {
      logAutomationDone(
        session,
        AutomationLogScope.sync,
        'step fetch skipped | reason=paused',
      );
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
    logAutomationStart(
      session,
      AutomationLogScope.sync,
      'step fetch started | perPage=${settings.upworkSyncResultsPerPage} query="${summarizeAutomationQuery(settings.jobFilter.searchQueryTerm)}"',
    );
    final syncResult = await _syncService.syncLatestJobs(
      session,
      filter: settings.jobFilter,
      resultsPerPage: settings.upworkSyncResultsPerPage,
    );

    final processedCount = await syncResult.fold(
      (count) async {
        await _automationService.markJobSyncSuccess(session);
        return count;
      },
      (error) async {
        logAutomationFail(
          session,
          AutomationLogScope.sync,
          'step fetch failed | ${error.message}',
        );
        await _automationService.markError(session, message: error.message);
        return null;
      },
    );
    if (processedCount == null) {
      return;
    }

    final latestSettingsResult = await _automationService.getOrCreateSettings(
      session,
    );
    final latestSettings = latestSettingsResult.fold(
      (value) => value,
      (error) => throw error,
    );
    if (latestSettings.isJobFetchingPaused) {
      logAutomationDone(
        session,
        AutomationLogScope.sync,
        'step fetch finished | jobs=$processedCount next=none reason=paused',
      );
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
      delay: Duration.zero,
    );
    logAutomationDone(
      session,
      AutomationLogScope.sync,
      'step fetch finished | jobs=$processedCount next=score delay=0m',
    );
    logAutomationStart(
      session,
      AutomationLogScope.loop,
      'score step queued | delay=0m',
    );
  }
}
