import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
import '../generated/protocol.dart';
import '../services/job_automation_loop_scheduler.dart';
import '../services/job_automation_service.dart';

class JobAutomationEndpoint extends Endpoint {
  JobAutomationEndpoint({
    JobAutomationService? service,
    JobAutomationLoopScheduler? scheduler,
  }) : _service = service ?? const JobAutomationService(),
       _scheduler = scheduler ?? const JobAutomationLoopScheduler();

  final JobAutomationService _service;
  final JobAutomationLoopScheduler _scheduler;

  Future<JobAutomationOverview> getOverview(Session session) async {
    final result = await _service.getOverview(session);
    return result.fold((overview) => overview, (error) => throw error);
  }

  Stream<JobAutomationOverview> watchOverview(Session session) async* {
    final result = await _service.getOverview(session);
    final overview = result.fold((value) => value, (error) => throw error);
    yield overview;

    await for (final message
        in session.messages.createStream<JobAutomationOverview>(
          jobAutomationOverviewChannel,
        )) {
      yield message;
    }
  }

  Future<JobAutomationOverview> updateSettings(
    Session session, {
    required JobAutomationSettingsUpdate update,
  }) async {
    final result = await _service.updateSettings(session, update);
    return result.fold((overview) => overview, (error) => throw error);
  }

  Future<JobAutomationOverview> setJobFetchingPaused(
    Session session, {
    required bool isPaused,
  }) async {
    final result = await _service.setJobFetchingPaused(
      session,
      isPaused: isPaused,
    );

    final overview = result.fold((value) => value, (error) => throw error);
    if (isPaused) {
      await _scheduler.cancelAll(
        session,
        identifiers: const [
          jobAutomationSyncFutureCallIdentifier,
          jobAutomationScoreFutureCallIdentifier,
          jobAutomationProposalFutureCallIdentifier,
        ],
      );
      final runtimeResult = await _service.setCurrentStep(
        session,
        JobAutomationStep.pausedWaiting,
      );
      final runtime = runtimeResult.fold(
        (value) => value,
        (error) => throw error,
      );
      return JobAutomationOverview(
        settings: overview.settings,
        runtime: runtime,
      );
    }

    await _scheduler.reschedule(
      session,
      callName: jobAutomationSyncFutureCallName,
      identifier: jobAutomationSyncFutureCallIdentifier,
      delay: Duration.zero,
    );

    return overview;
  }
}
