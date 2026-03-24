# Pascoa Scout

Private Serverpod workspace for scouting Upwork jobs, scoring them with AI, and drafting tailored proposals.

## Workspace layout

- `pascoa_scout_server`
  - Serverpod backend
  - Persists `JobInfo`, `JobAnalysisState`, `JobScore`, `JobProposal`, and related question/answer models
  - Owns the background automation loop for:
    1. syncing new Upwork jobs from Apify
    2. generating compatibility scores
    3. generating cover letters and question answers
- `pascoa_scout_client`
  - Generated Dart client for the backend endpoints and protocol models
- `pascoa_scout_flutter`
  - Flutter app
  - Collects the three long-form knowledge inputs required by the AI pipeline
  - Configures the saved Upwork filter and automation settings
  - Browses persisted job analyses through server-driven pagination, filtering, and per-card refresh
- `codex_cli_interface`
  - Vendored local package wrapper around the Codex CLI
  - Used by the server to run structured local AI generations without external API credits

## Current product shape

- The app blocks on a three-step onboarding flow until these server-side knowledge inputs exist:
  - curriculum
  - proposal style preference
  - good opportunity preference
- The Upwork filter is still edited in Flutter, but the saved automation settings now live on the server.
- The automation loop is server-driven through Serverpod future calls, not client timers.
- The job list UI now reads paginated `JobAnalysisState` data from the server instead of accumulating in-memory `JobInfo` rows on the client.

## Notes

- Repository and service failures should resolve to `PascoaException` on the failure side.
- Run dependency resolution from the workspace root.
- Keep generated files in sync whenever Freezed or Serverpod protocol/model definitions change.
- When Serverpod models or endpoints change, regenerate code and migrations before finishing.
