import 'package:flutter/material.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';

class JobAnalysisOpenJobButton extends StatelessWidget {
  const JobAnalysisOpenJobButton({
    super.key,
    required this.didViewJob,
    required this.onPressed,
  });

  final bool didViewJob;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.open_in_new_rounded),
      label: Text(l10n.jobAnalysisViewJobButton),
      style: FilledButton.styleFrom(
        backgroundColor: didViewJob
            ? theme.colorScheme.surfaceContainerHighest
            : const Color(0xFF46E5A7),
        foregroundColor: didViewJob
            ? theme.colorScheme.onSurfaceVariant
            : const Color(0xFF0A2419),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        textStyle: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
        ),
        elevation: didViewJob ? 0 : 4,
        shadowColor: Colors.black.withValues(alpha: 0.2),
      ),
    );
  }
}
