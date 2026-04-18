import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
import '../core/job_automation_logging.dart';
import '../core/pascoa_result.dart';
import '../generated/protocol.dart';
import 'job_automation_loop_scheduler.dart';
import 'job_automation_service.dart';

class JobAutomationStartupService {
  const JobAutomationStartupService({
    JobAutomationService? automationService,
    JobAutomationLoopScheduler? scheduler,
  }) : _automationService = automationService ?? const JobAutomationService(),
       _scheduler = scheduler ?? const JobAutomationLoopScheduler();

  final JobAutomationService _automationService;
  final JobAutomationLoopScheduler _scheduler;

  Future<PascoaResult<Unit>> clearScheduledFutureCalls(Session session) async {
    try {
      await _scheduler.cancelAutomationFutureCalls(session);
      return const Success(unit);
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to clear automation future calls',
          description:
              'The server could not delete the scheduled automation future calls from the database.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<PascoaResult<JobAutomationOverview>> reconcileAfterStartup(
    Session session,
  ) async {
    try {
      logAutomationStart(
        session,
        AutomationLogScope.control,
        'startup reconciliation started',
      );
      await _scheduler.cancelAutomationFutureCalls(session);

      final settingsResult = await _automationService.getOrCreateSettings(
        session,
      );
      final settings = settingsResult.fold(
        (value) => value,
        (error) => throw error,
      );

      final targetStep = settings.isJobFetchingPaused
          ? JobAutomationStep.pausedWaiting
          : JobAutomationStep.idle;
      final stepResult = await _automationService.setCurrentStep(
        session,
        targetStep,
      );
      stepResult.fold((_) {}, (error) => throw error);

      if (settings.isJobFetchingPaused) {
        logAutomationDone(
          session,
          AutomationLogScope.control,
          'startup reconciliation finished | paused=true next=none',
        );
        final overviewResult = await _automationService.publishCurrentOverview(
          session,
        );
        return overviewResult.fold(
          (value) => Success(value),
          (error) => Failure(error),
        );
      }

      await _scheduler.reschedule(
        session,
        callName: jobAutomationSyncFutureCallName,
        identifier: jobAutomationSyncFutureCallIdentifier,
        delay: Duration.zero,
      );
      logAutomationDone(
        session,
        AutomationLogScope.control,
        'startup reconciliation finished | paused=false next=sync delay=0m',
      );

      final overviewResult = await _automationService.publishCurrentOverview(
        session,
      );
      return overviewResult.fold(
        (value) => Success(value),
        (error) => Failure(error),
      );
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to reconcile automation startup state',
          description:
              'The server could not clean the automation queue and restore the expected loop state during startup.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
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
