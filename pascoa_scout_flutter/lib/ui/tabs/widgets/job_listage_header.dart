import 'package:flutter/material.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';

class JobListageHeader extends StatelessWidget {
  const JobListageHeader({super.key, required this.onManualFetch});

  final VoidCallback onManualFetch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 720;
        final titleBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.jobListHeaderTitle,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.jobListHeaderDescription,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.72),
              ),
            ),
          ],
        );
        final button = FilledButton.icon(
          onPressed: onManualFetch,
          icon: const Icon(Icons.download_rounded),
          label: Text(l10n.jobListManualFetchButton),
        );

        return Padding(
          padding: const EdgeInsets.only(top: 28, bottom: 20),
          child: isCompact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [titleBlock, const SizedBox(height: 16), button],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: titleBlock),
                    const SizedBox(width: 16),
                    button,
                  ],
                ),
        );
      },
    );
  }
}
