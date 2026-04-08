import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout/interactor/app_notification/app_notification_providers.dart';
import 'package:pascoa_scout/interactor/job_analysis_selection/selected_job_analysis_provider.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout/ui/tabs/widgets/expandable_inline_text.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_formatters.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_general_stats_editor_dialog.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_general_stats_preferences.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_open_job_button.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_proposal_milestones_section.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';
import 'package:url_launcher/url_launcher.dart';

class JobAnalysisDetailPanel extends ConsumerWidget {
  const JobAnalysisDetailPanel({
    super.key,
    required this.analysis,
    required this.onBack,
  });

  final JobAnalysisState analysis;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final job = analysis.jobInfo!;
    final score = analysis.score;
    final proposal = analysis.proposal;
    final statsPreferences = ref.watch(
      jobAnalysisGeneralStatsPreferencesProvider,
    );
    final statItems = _detailRows(context, analysis);
    final visibleStatItems = _visibleStatItems(statItems, statsPreferences);

    return SafeArea(
      bottom: false,
      child: SelectionArea(
        child: Scrollbar(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 18, 0, 0),
                sliver: SliverList.list(
                  children: [
                    _DetailHeader(
                      analysis: analysis,
                      onBack: onBack,
                      onOpenJob: () => _openJob(
                        context,
                        ref,
                        analysis: analysis,
                        url: job.url,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (score != null) ...[
                      _SectionHeading(
                        title: l10n.jobAnalysisAiCompatibilitySectionTitle,
                        trailing: IconButton(
                          tooltip: l10n.jobAnalysisCopyAiCompatibilityTooltip,
                          onPressed: () => _copyText(
                            context,
                            score.aiScoreJustificationText,
                            l10n.jobAnalysisAiCompatibilityCopied,
                          ),
                          icon: const Icon(Icons.content_copy_rounded),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SelectableText(
                        score.aiScoreJustificationText,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.55,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.82,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    _SectionHeading(
                      title: l10n.jobAnalysisDescriptionSectionTitle,
                      trailing: IconButton(
                        tooltip: l10n.jobAnalysisCopyDescriptionTooltip,
                        onPressed: () => _copyText(
                          context,
                          job.description,
                          l10n.jobAnalysisDescriptionCopied,
                        ),
                        icon: const Icon(Icons.content_copy_rounded),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ExpandableInlineText(
                      text: job.description,
                      collapsedMaxLines: 3,
                      expandLabel: l10n.jobAnalysisViewMore,
                      collapseLabel: l10n.jobAnalysisViewLess,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.55,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.82,
                        ),
                      ),
                      linkStyle: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionHeading(
                      title: l10n.jobAnalysisGeneralStatsSectionTitle,
                      trailing: TextButton.icon(
                        onPressed: () => _editGeneralStats(
                          context,
                          ref,
                          statItems,
                          statsPreferences,
                        ),
                        icon: const Icon(Icons.edit_rounded, size: 18),
                        label: Text(l10n.jobAnalysisGeneralStatsEditButton),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 16, right: 0),
                sliver: _StatsList(
                  rows: visibleStatItems,
                  onCopyRow: (row) {
                    return _copyText(
                      context,
                      row.value,
                      l10n.jobAnalysisGeneralStatsCopied(row.label),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 24, 0, 32),
                sliver: SliverList.list(
                  children: [
                    if (job.questions?.isNotEmpty ?? false) ...[
                      _SectionHeading(
                        title: l10n.jobAnalysisQuestionsSectionTitle,
                      ),
                      const SizedBox(height: 12),
                      for (final question in job.questions!) ...[
                        _CopyableTextSection(
                          title: l10n.jobAnalysisQuestionTitle(
                            question.positionIndex + 1,
                          ),
                          text: question.question,
                          tooltip: l10n.jobAnalysisCopyQuestionTooltip,
                          copiedMessage: l10n.jobAnalysisQuestionCopied,
                        ),
                        const SizedBox(height: 18),
                      ],
                    ],

                    if (proposal != null) ...[
                      _CopyableTextSection(
                        title: l10n.jobAnalysisCoverLetterSectionTitle,
                        text: proposal.aiGeneratedCoverLetterText,
                        tooltip: l10n.jobAnalysisCopyCoverLetterTooltip,
                        copiedMessage: l10n.jobAnalysisCoverLetterCopied,
                      ),
                      const SizedBox(height: 24),
                    ],
                    if (proposal?.milestones?.isNotEmpty ?? false) ...[
                      JobAnalysisProposalMilestonesSection(
                        milestones: proposal!.milestones!,
                      ),
                      const SizedBox(height: 24),
                    ],
                    if (proposal?.answers?.isNotEmpty ?? false) ...[
                      _SectionHeading(
                        title: l10n.jobAnalysisAiAnswersSectionTitle,
                      ),
                      const SizedBox(height: 12),
                      for (final answer in proposal!.answers!) ...[
                        _CopyableTextSection(
                          title:
                              answer.relatedQuestion?.question ??
                              l10n.jobAnalysisAnswerFallbackTitle,
                          text: answer.aiGeneratedAnswerText,
                          tooltip: l10n.jobAnalysisCopyAnswerTooltip,
                          copiedMessage: l10n.jobAnalysisAnswerCopied,
                        ),
                        const SizedBox(height: 18),
                      ],
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<_DetailRowData> _detailRows(
    BuildContext context,
    JobAnalysisState analysis,
  ) {
    final l10n = AppLocalizations.of(context);
    final job = analysis.jobInfo!;

    return [
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.upworkId,
        label: l10n.jobAnalysisUpworkIdLabel,
        value: job.upworkId,
        icon: Icons.badge_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.subId,
        label: l10n.jobAnalysisSubIdLabel,
        value: job.subId ?? l10n.jobAnalysisUnavailableValue,
        icon: Icons.tag_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.jobUrl,
        label: l10n.jobAnalysisJobUrlLabel,
        value: job.url,
        icon: Icons.link_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.relativeDate,
        label: l10n.jobAnalysisRelativeDateLabel,
        value: job.relativeDate ?? l10n.jobAnalysisUnavailableValue,
        icon: Icons.schedule_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.relativeDateMinutes,
        label: l10n.jobAnalysisRelativeDateMinutesLabel,
        value:
            job.relativeDateMinutes?.toString() ??
            l10n.jobAnalysisUnavailableValue,
        icon: Icons.timer_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.absoluteDate,
        label: l10n.jobAnalysisAbsoluteDateLabel,
        value: job.absoluteDate ?? l10n.jobAnalysisUnavailableValue,
        icon: Icons.event_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.absoluteDateTime,
        label: l10n.jobAnalysisAbsoluteDateTimeLabel,
        value: formatDateTimeValue(job.absoluteDateTime),
        icon: Icons.event_note_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.budget,
        label: l10n.jobAnalysisBudgetLabel,
        value: job.budget ?? l10n.jobAnalysisUnavailableValue,
        icon: Icons.payments_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.compensation,
        label: l10n.jobAnalysisCompensationLabel,
        value: jobAnalysisCompensationLabel(l10n, job),
        icon: Icons.account_balance_wallet_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.fixedPriceAmount,
        label: l10n.jobAnalysisFixedPriceAmountLabel,
        value: job.fixedPriceAmount == null
            ? l10n.jobAnalysisUnavailableValue
            : formatUsd(job.fixedPriceAmount!),
        icon: Icons.price_change_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.hourlyMin,
        label: l10n.jobAnalysisHourlyMinLabel,
        value: job.hourlyMinRate == null
            ? l10n.jobAnalysisUnavailableValue
            : formatUsd(job.hourlyMinRate!),
        icon: Icons.arrow_downward_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.hourlyMax,
        label: l10n.jobAnalysisHourlyMaxLabel,
        value: job.hourlyMaxRate == null
            ? l10n.jobAnalysisUnavailableValue
            : formatUsd(job.hourlyMaxRate!),
        icon: Icons.arrow_upward_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.jobType,
        label: l10n.jobAnalysisJobTypeLabel,
        value: enumNameLabel(job.jobType),
        icon: Icons.work_outline_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.experience,
        label: l10n.jobAnalysisExperienceLabel,
        value: enumNameLabel(job.experienceLevel),
        icon: Icons.school_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.paymentVerified,
        label: l10n.jobAnalysisPaymentVerifiedLabel,
        value: paymentVerifiedStatusLabel(l10n, job.paymentVerifiedStatus),
        icon: Icons.verified_user_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.allowedCountries,
        label: l10n.jobAnalysisAllowedCountriesLabel,
        value: job.allowedApplicantCountries.isEmpty
            ? l10n.jobAnalysisUnavailableValue
            : joinLabels(job.allowedApplicantCountries.map(enumNameLabel)),
        icon: Icons.public_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.clientName,
        label: l10n.jobAnalysisClientNameLabel,
        value: job.clientName ?? l10n.jobAnalysisUnavailableValue,
        icon: Icons.business_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.clientNameConfidence,
        label: l10n.jobAnalysisClientNameConfidenceLabel,
        value: job.clientNameConfidencePercent == null
            ? l10n.jobAnalysisUnavailableValue
            : formatPercent(job.clientNameConfidencePercent),
        icon: Icons.analytics_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.clientAverageHourlyRate,
        label: l10n.jobAnalysisClientAverageHourlyRateLabel,
        value: job.clientAvgHourlyRate == null
            ? l10n.jobAnalysisUnavailableValue
            : formatUsd(job.clientAvgHourlyRate!),
        icon: Icons.attach_money_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.clientRating,
        label: l10n.jobAnalysisClientRatingLabel,
        value: job.clientRating == null
            ? l10n.jobAnalysisUnavailableValue
            : l10n.jobAnalysisClientRatingValue(formatRating(job.clientRating)),
        icon: Icons.star_outline_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.clientHireRate,
        label: l10n.jobAnalysisClientHireRateLabel,
        value: job.clientHireRatePercent == null
            ? l10n.jobAnalysisUnavailableValue
            : formatPercent(job.clientHireRatePercent),
        icon: Icons.person_add_alt_1_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.clientTotalSpent,
        label: l10n.jobAnalysisClientTotalSpentLabel,
        value: job.clientTotalSpent == null
            ? l10n.jobAnalysisUnavailableValue
            : formatUsd(job.clientTotalSpent!),
        icon: Icons.savings_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.clientCountry,
        label: l10n.jobAnalysisClientCountryLabel,
        value: job.clientLocation?.country == null
            ? l10n.jobAnalysisUnavailableValue
            : enumNameLabel(job.clientLocation!.country!),
        icon: Icons.flag_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.clientRegion,
        label: l10n.jobAnalysisClientRegionLabel,
        value: job.clientLocation?.region == null
            ? l10n.jobAnalysisUnavailableValue
            : enumNameLabel(job.clientLocation!.region!),
        icon: Icons.map_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.clientSubRegion,
        label: l10n.jobAnalysisClientSubRegionLabel,
        value: job.clientLocation?.subRegion == null
            ? l10n.jobAnalysisUnavailableValue
            : enumNameLabel(job.clientLocation!.subRegion!),
        icon: Icons.location_on_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.tags,
        label: l10n.jobAnalysisTagsLabel,
        value: job.tags.isEmpty
            ? l10n.jobAnalysisUnavailableValue
            : job.tags.join(', '),
        icon: Icons.sell_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.hasHired,
        label: l10n.jobAnalysisHasHiredLabel,
        value: boolLabel(l10n, job.hasHired),
        icon: Icons.group_add_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.questionCount,
        label: l10n.jobAnalysisQuestionCountLabel,
        value: (job.questions?.length ?? 0).toString(),
        icon: Icons.quiz_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.persistedAt,
        label: l10n.jobAnalysisPersistedAtLabel,
        value: formatDateTimeValue(analysis.createdJobInfoAt),
        icon: Icons.save_outlined,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.scoreGeneratedAt,
        label: l10n.jobAnalysisScoreGeneratedAtLabel,
        value: formatDateTimeValue(analysis.createdJobScoringAt),
        icon: Icons.auto_graph_rounded,
      ),
      _DetailRowData(
        key: JobAnalysisGeneralStatKey.aiResponsesGeneratedAt,
        label: l10n.jobAnalysisAiResponsesGeneratedAtLabel,
        value: formatDateTimeValue(analysis.createdJobAiResponsesAt),
        icon: Icons.auto_awesome_outlined,
      ),
    ];
  }

  List<_DetailRowData> _visibleStatItems(
    List<_DetailRowData> rows,
    JobAnalysisGeneralStatsPreferences preferences,
  ) {
    final rowsByKey = {for (final row in rows) row.key: row};

    return [
      for (final key in preferences.visibleOrderedKeys)
        ...?switch (rowsByKey[key]) {
          final row? => [row],
          null => null,
        },
    ];
  }

  Future<void> _editGeneralStats(
    BuildContext context,
    WidgetRef ref,
    List<_DetailRowData> statItems,
    JobAnalysisGeneralStatsPreferences preferences,
  ) async {
    final l10n = AppLocalizations.of(context);
    final updatedPreferences =
        await showDialog<JobAnalysisGeneralStatsPreferences>(
          context: context,
          builder: (context) {
            return JobAnalysisGeneralStatsEditorDialog(
              initialPreferences: preferences,
              options: [
                for (final statItem in statItems)
                  JobAnalysisGeneralStatOption(
                    key: statItem.key,
                    label: statItem.label,
                    icon: statItem.icon,
                  ),
              ],
            );
          },
        );
    if (updatedPreferences == null || !context.mounted) {
      return;
    }

    try {
      await ref
          .read(jobAnalysisGeneralStatsPreferencesProvider.notifier)
          .save(updatedPreferences);
    } catch (_) {
      if (!context.mounted) {
        return;
      }

      notifySnackbarWithContext(
        context,
        message: l10n.jobAnalysisGeneralStatsSaveFailed,
        tone: AppNotificationTone.error,
      );
    }
  }

  Future<void> _openJob(
    BuildContext context,
    WidgetRef ref, {
    required JobAnalysisState analysis,
    required String url,
  }) async {
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
      return;
    }

    if (!wasOpened || analysis.didViewJob) {
      return;
    }

    final optimistic = analysis.copyWith(didViewJob: true);
    ref.read(selectedJobAnalysisProvider.notifier).update(optimistic);

    if (analysis.id == null) {
      return;
    }

    try {
      final updated = await ref
          .read(clientProvider)
          .jobAnalysis
          .markJobViewed(jobAnalysisStateId: analysis.id!);
      ref.read(selectedJobAnalysisProvider.notifier).update(updated);
    } catch (error) {
      ref.read(selectedJobAnalysisProvider.notifier).update(analysis);
      if (!context.mounted) {
        return;
      }
      notifySnackbarWithContext(
        context,
        message: error.toString(),
        tone: AppNotificationTone.error,
      );
    }
  }

  Future<void> _copyText(
    BuildContext context,
    String text,
    String message,
  ) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) {
      return;
    }

    notifySnackbarWithContext(context, message: message);
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({
    required this.analysis,
    required this.onBack,
    required this.onOpenJob,
  });

  final JobAnalysisState analysis;
  final VoidCallback onBack;
  final VoidCallback onOpenJob;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final job = analysis.jobInfo!;
    final rating = job.clientRating;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextButton.icon(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded),
              label: Text(l10n.jobAnalysisBackToFiltersButton),
            ),
            const Spacer(),
            JobAnalysisOpenJobButton(
              didViewJob: analysis.didViewJob,
              onPressed: onOpenJob,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          job.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _ClientRatingSummary(rating: rating),
            if (analysis.score != null)
              _DetailScoreBadge(score: analysis.score!.scorePercentage),
          ],
        ),
      ],
    );
  }
}

class _ClientRatingSummary extends StatelessWidget {
  const _ClientRatingSummary({required this.rating});

  final double? rating;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currentRating = rating;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.32,
        ),
      ),
      child: currentRating == null
          ? Text(
              l10n.jobAnalysisNoClientRatingValue,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBarIndicator(
                  rating: currentRating,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star_rounded, color: Color(0xFFF2CF63)),
                  itemCount: 5,
                  itemSize: 20,
                  unratedColor: theme.colorScheme.outline.withValues(
                    alpha: 0.28,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  formatRating(currentRating),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
    );
  }
}

class _DetailScoreBadge extends StatelessWidget {
  const _DetailScoreBadge({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = jobAnalysisScoreColor(theme.colorScheme, score);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: color.withValues(alpha: 0.14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        '$score',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        ...?switch (trailing) {
          final widget? => [widget],
          null => null,
        },
      ],
    );
  }
}

class _StatsList extends StatelessWidget {
  const _StatsList({required this.rows, required this.onCopyRow});

  final List<_DetailRowData> rows;
  final Future<void> Function(_DetailRowData row) onCopyRow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = theme.colorScheme.outline.withValues(alpha: 0.12);

    if (rows.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index.isEven) {
          return Divider(height: 1, thickness: 1, color: dividerColor);
        }

        final row = rows[index ~/ 2];
        return _StatsListRow(row: row, onCopy: () => onCopyRow(row));
      }, childCount: rows.length * 2 + 1),
    );
  }
}

class _StatsListRow extends StatelessWidget {
  const _StatsListRow({required this.row, required this.onCopy});

  final _DetailRowData row;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(
                    row.icon,
                    size: 17,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    row.label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.72,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SelectableText(
              row.value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.88),
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _CompactIconAction(
            icon: Icons.content_copy_rounded,
            tooltip: AppLocalizations.of(context).jobAnalysisCopyStatTooltip,
            onTap: onCopy,
          ),
        ],
      ),
    );
  }
}

class _CompactIconAction extends StatelessWidget {
  const _CompactIconAction({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              icon,
              size: 18,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class _CopyableTextSection extends StatelessWidget {
  const _CopyableTextSection({
    required this.title,
    required this.text,
    required this.tooltip,
    required this.copiedMessage,
  });

  final String title;
  final String text;
  final String tooltip;
  final String copiedMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton(
              tooltip: tooltip,
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: text));
                if (!context.mounted) {
                  return;
                }

                notifySnackbarWithContext(context, message: copiedMessage);
              },
              icon: const Icon(Icons.content_copy_rounded),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SelectableText(
          text,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.55,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.82),
          ),
        ),
      ],
    );
  }
}

class _DetailRowData {
  const _DetailRowData({
    required this.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  final JobAnalysisGeneralStatKey key;
  final String label;
  final String value;
  final IconData icon;
}
