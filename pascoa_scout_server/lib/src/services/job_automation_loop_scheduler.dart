import 'package:serverpod/serverpod.dart';

class JobAutomationLoopScheduler {
  const JobAutomationLoopScheduler();

  Future<void> reschedule(
    Session session, {
    required String callName,
    required String identifier,
    required Duration delay,
  }) async {
    await cancel(session, identifier: identifier);

    // ignore: deprecated_member_use
    await session.serverpod.futureCallWithDelay(
      callName,
      null,
      delay,
      identifier: identifier,
    );
  }

  Future<void> cancel(
    Session session, {
    required String identifier,
  }) async {
    await session.db.unsafeExecute(
      'DELETE FROM serverpod_future_call WHERE identifier = @identifier',
      parameters: QueryParameters.named({'identifier': identifier}),
    );
  }
}
