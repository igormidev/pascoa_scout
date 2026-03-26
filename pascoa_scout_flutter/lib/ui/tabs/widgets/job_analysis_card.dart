import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pascoa_scout/interactor/app_notification/app_notification_providers.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout/ui/tabs/widgets/expandable_inline_text.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_formatters.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';
import 'package:url_launcher/url_launcher.dart';

class JobAnalysisCard extends StatelessWidget {
  const JobAnalysisCard({
    super.key,
    required this.analysis,
    required this.onSelect,
    this.onRefresh,
    this.isRefreshing = false,
    this.isSelected = false,
  });

  final JobAnalysisState analysis;
  final VoidCallback onSelect;
  final Future<void> Function(int id)? onRefresh;
  final bool isRefreshing;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final job = analysis.jobInfo!;
    final score = analysis.score;
    final canRefresh = analysis.id != null && onRefresh != null;
    final selectedBorderColor = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.outline.withValues(alpha: 0.22);

    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: onSelect,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.fromLTRB(18, 28, 18, 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: theme.colorScheme.surface.withValues(alpha: 0.96),
                  border: Border.all(
                    color: selectedBorderColor,
                    width: isSelected ? 2.2 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                    if (isSelected)
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(
                          alpha: 0.16,
                        ),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ExpandableInlineText(
                      text: job.description,
                      collapsedMaxLines: 1,
                      expandLabel: l10n.jobAnalysisViewMore,
                      collapseLabel: l10n.jobAnalysisViewLess,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.66,
                        ),
                        height: 1.45,
                      ),
                      linkStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 14),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final chipWrap = Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _MetricChip(
                              icon: Icons.quiz_outlined,
                              label: jobAnalysisQuestionsLabel(
                                l10n,
                                job.questions?.length ?? 0,
                              ),
                            ),
                            _MetricChip(
                              icon: jobAnalysisCompensationIcon(job),
                              label: jobAnalysisCompensationLabel(l10n, job),
                            ),
                            _MetricChip(
                              icon: Icons.trending_up_rounded,
                              label: jobAnalysisClientHireRateLabel(
                                l10n,
                                job.clientHireRatePercent,
                              ),
                            ),
                          ],
                        );
                        final openJobButton = FilledButton.tonalIcon(
                          onPressed: () => _openJob(context, job.url),
                          icon: const Icon(Icons.open_in_new_rounded),
                          label: Text(l10n.jobAnalysisViewJobButton),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFB8D89D),
                            foregroundColor: const Color(0xFF1B2514),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            textStyle: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        );

                        if (constraints.maxWidth < 720) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              chipWrap,
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: openJobButton,
                              ),
                            ],
                          );
                        }

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: chipWrap),
                            const SizedBox(width: 12),
                            openJobButton,
                          ],
                        );
                      },
                    ),
                    if (score != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        l10n.jobAnalysisAiCompatibilitySectionTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        score.aiScoreJustificationText,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.45,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.72,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -25,
            left: 18,
            right: 18,
            child: Row(
              children: [
                _ClientRatingBadge(rating: job.clientRating),
                if (analysis.createdJobAiResponsesAt != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Tooltip(
                      message: 'Completed! Have even generated AI answers',
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                const Spacer(),
                if (canRefresh)
                  _RefreshCircleButton(
                    isRefreshing: isRefreshing,
                    onTap: () => onRefresh!(analysis.id!),
                  ),
                if (score != null) ...[
                  const SizedBox(width: 10),
                  _ScoreCircle(score: score.scorePercentage),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openJob(BuildContext context, String url) async {
    final l10n = AppLocalizations.of(context);
    final uri = Uri.tryParse(url);
    if (uri == null) {
      notifySnackbarWithContext(
        context,
        message: l10n.jobAnalysisInvalidUrlMessage,
        tone: AppNotificationTone.error,
      );
      return;
    }

    final wasOpened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!wasOpened && context.mounted) {
      notifySnackbarWithContext(
        context,
        message: l10n.jobAnalysisUnableToOpenJobMessage,
        tone: AppNotificationTone.error,
      );
    }
  }
}

class _ClientRatingBadge extends StatelessWidget {
  const _ClientRatingBadge({required this.rating});

  final double? rating;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currentRating = rating;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
      child: currentRating == null
          ? Text(
              l10n.jobAnalysisNoClientRatingValue,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            )
          : RatingBarIndicator(
              rating: currentRating,
              itemBuilder: (context, _) =>
                  const Icon(Icons.star_rounded, color: Color(0xFFF2CF63)),
              itemCount: 5,
              itemSize: 20,
              unratedColor: theme.colorScheme.outline.withValues(alpha: 0.28),
            ),
    );
  }
}

class _RefreshCircleButton extends StatelessWidget {
  const _RefreshCircleButton({required this.isRefreshing, required this.onTap});

  final bool isRefreshing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      shape: const CircleBorder(),
      elevation: 6,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: isRefreshing ? null : onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                );
              },
              child: isRefreshing
                  ? const SizedBox(
                      key: ValueKey('job-card-loading'),
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.4),
                    )
                  : const Icon(
                      key: ValueKey('job-card-refresh'),
                      Icons.refresh_rounded,
                      size: 28,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreCircle extends StatelessWidget {
  const _ScoreCircle({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = jobAnalysisScoreColor(theme.colorScheme, score);

    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.surface,
        border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        '$score',
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFCBE0F6),
        border: Border.all(color: const Color(0xFF8FAED1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF1F3654)),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF112136),
            ),
          ),
        ],
      ),
    );
  }
}
