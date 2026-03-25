# AGENTS.md

## Project Rules

- Repository and service methods that can fail should return `Future<PascoaResult<T>>` and use `result_dart`.
- The failure side must always be `PascoaException`. Do not expose raw exceptions for expected failures.
- When editing Freezed or `json_serializable` models, regenerate the generated files and keep them in sync.
- When editing Serverpod protocol or endpoint definitions, regenerate the relevant Serverpod code before finishing.
- Widget-returning helper functions or methods must not exist in UI code. Patterns such as `_buildToolbar`, `_buildBody`, `_buildEditorView`, and similar non-`build` methods are forbidden and must be extracted into dedicated widget classes in separate files. Treat this as a critical performance and maintainability rule for Flutter UI work.
- When touching UI code, aggressively remove widget-returning helper methods instead of adding new ones. Re-scan the codebase after each refactor and do not stop until no non-`build` functions returning `Widget` or common widget subtypes remain.
- End every task with static analysis passing and no analyzer errors left anywhere in the workspace. This is mandatory, non-optional, and must still be true after every refactor, code generation step, or AI-assisted change.
- Keep the root README aligned with the real workspace structure and purpose.
