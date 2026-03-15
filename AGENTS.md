# AGENTS.md

## Project Rules

- Repository and service methods that can fail should return `Future<PascoaResult<T>>` and use `result_dart`.
- The failure side must always be `PascoaException`. Do not expose raw exceptions for expected failures.
- When editing Freezed or `json_serializable` models, regenerate the generated files and keep them in sync.
- When editing Serverpod protocol or endpoint definitions, regenerate the relevant Serverpod code before finishing.
- End every task with static analysis passing and no analyzer errors left in the workspace.
- Keep the root README aligned with the real workspace structure and purpose.
