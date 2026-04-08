import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pascoa_scout/interactor/app_notification/app_notification_providers.dart';
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
    final suggestedPrice = formatUsd(milestone.suggestedPrice);

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            milestone.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _CopyActionButton(
                          tooltip: l10n.jobAnalysisCopyMilestoneTitleTooltip,
                          onPressed: () {
                            _copyText(
                              context,
                              milestone.title,
                              l10n.jobAnalysisMilestoneTitleCopied,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestedPrice,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _CopyActionButton(
                    tooltip: l10n.jobAnalysisCopyMilestoneSuggestedPriceTooltip,
                    onPressed: () {
                      _copyText(
                        context,
                        suggestedPrice,
                        l10n.jobAnalysisMilestoneSuggestedPriceCopied,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          _HoverCopyDescription(
            text: milestone.description,
            tooltip: l10n.jobAnalysisCopyMilestoneDescriptionTooltip,
            copiedMessage: l10n.jobAnalysisMilestoneDescriptionCopied,
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

class _HoverCopyDescription extends StatefulWidget {
  const _HoverCopyDescription({
    required this.text,
    required this.tooltip,
    required this.copiedMessage,
    required this.style,
  });

  final String text;
  final String tooltip;
  final String copiedMessage;
  final TextStyle? style;

  @override
  State<_HoverCopyDescription> createState() => _HoverCopyDescriptionState();
}

class _HoverCopyDescriptionState extends State<_HoverCopyDescription> {
  var _isHovered = false;

  void _setHovered(bool value) {
    if (_isHovered == value) {
      return;
    }

    setState(() {
      _isHovered = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Text(widget.text, style: widget.style),
            ),
            IgnorePointer(
              ignoring: !_isHovered,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 140),
                opacity: _isHovered ? 1 : 0,
                child: _CopyActionButton(
                  tooltip: widget.tooltip,
                  onPressed: () {
                    _copyText(context, widget.text, widget.copiedMessage);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CopyActionButton extends StatelessWidget {
  const _CopyActionButton({required this.tooltip, required this.onPressed});

  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              Icons.content_copy_rounded,
              size: 18,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _copyText(
  BuildContext context,
  String text,
  String copiedMessage,
) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (!context.mounted) {
    return;
  }

  notifySnackbarWithContext(context, message: copiedMessage);
}
