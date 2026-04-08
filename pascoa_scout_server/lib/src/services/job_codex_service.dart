import 'dart:convert';

import 'package:codex_cli_interface/codex_cli_interface.dart';
import 'package:result_dart/result_dart.dart';

import '../core/pascoa_result.dart';
import '../generated/protocol.dart';

class JobCodexService {
  const JobCodexService();

  Future<PascoaResult<Map<String, dynamic>>> runStructuredJson({
    required String workingDirectory,
    required String prompt,
    required Map<String, Object?> schema,
    bool enableWebSearch = false,
  }) async {
    try {
      final codex = Codex();
      final thread = codex.startThread(
        ThreadOptions(
          sandboxMode: SandboxMode.readOnly,
          skipGitRepoCheck: true,
          modelReasoningEffort: ModelReasoningEffort.xhigh,
          approvalPolicy: ApprovalMode.never,
          webSearchMode: enableWebSearch
              ? WebSearchMode.live
              : WebSearchMode.disabled,
          networkAccessEnabled: enableWebSearch,
        ).copyWith(workingDirectory: workingDirectory),
      );

      final result = await thread.run(
        prompt,
        TurnOptions(outputSchema: schema),
      );
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
