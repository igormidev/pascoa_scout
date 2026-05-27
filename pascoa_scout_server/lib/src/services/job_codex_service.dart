import 'dart:async';
import 'dart:convert';

import 'package:codex_cli_interface/codex_cli_interface.dart';
import 'package:result_dart/result_dart.dart';

import '../core/job_automation_constants.dart';
import '../core/pascoa_result.dart';
import '../generated/protocol.dart';

class JobCodexService {
  const JobCodexService();

  Future<PascoaResult<Map<String, dynamic>>> runStructuredJson({
    required String workingDirectory,
    required String prompt,
    required Map<String, Object?> schema,
    required JobAutomationAiModel aiModel,
    required JobAutomationAiThinkingEffort aiThinkingEffort,
    bool enableWebSearch = false,
    Duration? timeout,
  }) async {
    try {
      final codex = Codex();
      final thread = codex.startThread(
        ThreadOptions(
          model: _mapModel(aiModel),
          sandboxMode: SandboxMode.readOnly,
          skipGitRepoCheck: true,
          modelReasoningEffort: _mapReasoningEffort(aiThinkingEffort),
          approvalPolicy: ApprovalMode.never,
          webSearchMode: enableWebSearch
              ? WebSearchMode.live
              : WebSearchMode.disabled,
          networkAccessEnabled: enableWebSearch,
        ).copyWith(workingDirectory: workingDirectory),
      );

      final cancelCompleter = Completer<void>();
      final runFuture = thread.run(
        prompt,
        TurnOptions(
          outputSchema: schema,
          cancelSignal: cancelCompleter.future,
        ),
      );
      final effectiveTimeout =
          timeout ??
          (enableWebSearch
              ? _defaultCodexWebSearchTimeout
              : _defaultCodexTimeout);
      final outcome = await Future.any<Object>([
        runFuture,
        Future<Object>.delayed(
          effectiveTimeout,
          () => const _CodexRunTimedOut(),
        ),
      ]);
      if (outcome is _CodexRunTimedOut) {
        if (!cancelCompleter.isCompleted) {
          cancelCompleter.complete();
        }
        unawaited(
          Future.any<Object?>([
            runFuture.then<Object?>((_) => null),
            Future<Object?>.delayed(_cancelDrainGracePeriod, () => null),
          ]).catchError((Object _, StackTrace _) => null),
        );
        return Failure(
          PascoaException(
            message: 'Codex generation timed out',
            description:
                'The local Codex CLI did not finish the structured generation before the timeout window expired.',
            error:
                'Timed out after ${effectiveTimeout.inSeconds}s while waiting for Codex to finish.',
          ),
        );
      }
      final result = outcome as RunResult;
      final decoded = jsonDecode(result.finalResponse);
      if (decoded is! Map) {
        return Failure(
          PascoaException(
            message: 'Codex returned an invalid JSON payload',
            description:
                'The local Codex CLI did not return a JSON object that matches the requested schema.',
            error: result.finalResponse,
          ),
        );
      }

      return Success(Map<String, dynamic>.from(decoded));
    } catch (error, stackTrace) {
      return Failure(
        PascoaException(
          message: 'Unable to complete Codex generation',
          description:
              'The local Codex CLI failed while generating a structured AI response.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
  }
}

const Duration _defaultCodexTimeout = Duration(minutes: 2);
const Duration _defaultCodexWebSearchTimeout = Duration(minutes: 5);
const Duration _cancelDrainGracePeriod = Duration(seconds: 5);

final class _CodexRunTimedOut {
  const _CodexRunTimedOut();
}

String _mapModel(JobAutomationAiModel aiModel) {
  return switch (aiModel) {
    JobAutomationAiModel.gpt55 => codexGpt55Model,
    JobAutomationAiModel.gpt54 => defaultCodexModel,
    JobAutomationAiModel.gpt54Mini => defaultCodexMiniModel,
  };
}

ModelReasoningEffort _mapReasoningEffort(
  JobAutomationAiThinkingEffort aiThinkingEffort,
) {
  return switch (aiThinkingEffort) {
    JobAutomationAiThinkingEffort.low => ModelReasoningEffort.low,
    JobAutomationAiThinkingEffort.medium => ModelReasoningEffort.medium,
    JobAutomationAiThinkingEffort.high => ModelReasoningEffort.high,
    JobAutomationAiThinkingEffort.xhigh => ModelReasoningEffort.xhigh,
  };
}

extension on ThreadOptions {
  ThreadOptions copyWith({
    String? workingDirectory,
  }) {
    return ThreadOptions(
      model: model,
      sandboxMode: sandboxMode,
      workingDirectory: workingDirectory ?? this.workingDirectory,
      skipGitRepoCheck: skipGitRepoCheck,
      modelReasoningEffort: modelReasoningEffort,
      networkAccessEnabled: networkAccessEnabled,
      webSearchMode: webSearchMode,
      webSearchEnabled: webSearchEnabled,
      approvalPolicy: approvalPolicy,
      additionalDirectories: additionalDirectories,
    );
  }
}
