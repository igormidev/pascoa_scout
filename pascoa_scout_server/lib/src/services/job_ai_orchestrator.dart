import 'package:executor/executor.dart';

class JobAiOrchestrator {
  const JobAiOrchestrator();

  Future<List<T>> runQueued<T>(
    Iterable<Future<T> Function()> tasks, {
    required int concurrency,
  }) async {
    final executor = Executor(concurrency: concurrency);
    try {
      final scheduled = [for (final task in tasks) executor.scheduleTask(task)];
      return Future.wait(scheduled);
    } finally {
      await executor.join(withWaiting: true);
      await executor.close();
    }
  }
}
