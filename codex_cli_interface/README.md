# codex_cli_interface

Dart SDK wrapper for the local Codex CLI.

This package wraps `codex exec` and exchanges JSONL events over stdin/stdout.

## Installation

```bash
dart pub add codex_cli_interface
```

## Quickstart

```dart
import 'package:codex_cli_interface/codex_cli_interface.dart';

Future<void> main() async {
  final codex = Codex();
  final thread = codex.startThread();

  final turn = await thread.run('Diagnose the failing test and propose a fix.');
  print(turn.finalResponse);
}
```

## Structured output

```dart
import 'package:codex_cli_interface/codex_cli_interface.dart';

Future<void> main() async {
  final codex = Codex();
  final thread = codex.startThread();

  final schema = {
    'type': 'object',
    'properties': {
      'summary': {'type': 'string'},
      'status': {
        'type': 'string',
        'enum': ['ok', 'action_required'],
      },
    },
    'required': ['summary', 'status'],
    'additionalProperties': false,
  };

  final result = await thread.run(
    'Summarize repository status',
    TurnOptions(outputSchema: schema),
  );

  print(result.finalResponse);
}
```

## Binary resolution strategy

This package resolves the executable in this order:

1. `codexPathOverride`
2. `CODEX_EXECUTABLE`
3. `PATH`

If `codex` cannot be found, it throws a clear error with remediation steps.

## License

See `LICENSE` and `NOTICE` for attribution details.
