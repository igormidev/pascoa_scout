import 'package:flutter/material.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_formatters.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

class JobAnalysisProposalMilestonesSection extends StatelessWidget {
  const JobAnalysisProposalMilestonesSection({
    super.key,
    required this.milestones,
  });

  final List<JobProposalMilestone> milestones;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final totalSuggestedPrice = milestones.fold<double>(
      0,
      (sum, milestone) => sum + milestone.suggestedPrice,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.jobAnalysisMilestonesSectionTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        _MilestoneTotalChip(totalSuggestedPrice: totalSuggestedPrice),
        const SizedBox(height: 12),
        for (var index = 0; index < milestones.length; index++) ...[
          _MilestoneCard(index: index, milestone: milestones[index]),
          if (index < milestones.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _MilestoneTotalChip extends StatelessWidget {
  const _MilestoneTotalChip({required this.totalSuggestedPrice});

  final double totalSuggestedPrice;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.34),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.18),
        ),
      ),
      child: Text(
        l10n.jobAnalysisMilestonesTotalLabel(formatUsd(totalSuggestedPrice)),
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  const _MilestoneCard({required this.index, required this.milestone});

  final int index;
  final JobProposalMilestone milestone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.12),
        ),
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.18,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.jobAnalysisMilestoneTitle(index + 1),
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      milestone.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                formatUsd(milestone.suggestedPrice),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            milestone.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.82),
            ),
          ),
        ],
      ),
    );
  }
}
