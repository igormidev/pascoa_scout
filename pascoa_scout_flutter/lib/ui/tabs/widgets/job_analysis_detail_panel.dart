import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pascoa_scout/interactor/app_notification/app_notification_providers.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout/ui/tabs/widgets/expandable_inline_text.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_formatters.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';
import 'package:url_launcher/url_launcher.dart';

class JobAnalysisDetailPanel extends StatelessWidget {
  const JobAnalysisDetailPanel({
    super.key,
    required this.analysis,
    required this.onBack,
  });

  final JobAnalysisState analysis;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final job = analysis.jobInfo!;
    final score = analysis.score;
    final proposal = analysis.proposal;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.92),
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.12),
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SelectionArea(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailHeader(
                    analysis: analysis,
                    onBack: onBack,
                    onOpenJob: () => _openJob(context, job.url),
                  ),
                  const SizedBox(height: 20),
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
                  ),
                  const SizedBox(height: 12),
                  _StatsTable(rows: _detailRows(context, analysis)),
                  if (job.questions?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 24),
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
                    const SizedBox(height: 24),
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
      _DetailRowData(label: l10n.jobAnalysisUpworkIdLabel, value: job.upworkId),
      _DetailRowData(
        label: l10n.jobAnalysisSubIdLabel,
        value: job.subId ?? l10n.jobAnalysisUnavailableValue,
      ),
      _DetailRowData(label: l10n.jobAnalysisJobUrlLabel, value: job.url),
      _DetailRowData(
        label: l10n.jobAnalysisRelativeDateLabel,
        value: job.relativeDate ?? l10n.jobAnalysisUnavailableValue,
      ),
      _DetailRowData(
        label: l10n.jobAnalysisRelativeDateMinutesLabel,
        value:
            job.relativeDateMinutes?.toString() ??
            l10n.jobAnalysisUnavailableValue,
      ),
      _DetailRowData(
        label: l10n.jobAnalysisAbsoluteDateLabel,
        value: job.absoluteDate ?? l10n.jobAnalysisUnavailableValue,
      ),
      _DetailRowData(
        label: l10n.jobAnalysisAbsoluteDateTimeLabel,
        value: formatDateTimeValue(job.absoluteDateTime),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisBudgetLabel,
        value: job.budget ?? l10n.jobAnalysisUnavailableValue,
      ),
      _DetailRowData(
        label: l10n.jobAnalysisCompensationLabel,
        value: jobAnalysisCompensationLabel(l10n, job),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisFixedPriceAmountLabel,
        value: job.fixedPriceAmount == null
            ? l10n.jobAnalysisUnavailableValue
            : formatUsd(job.fixedPriceAmount!),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisHourlyMinLabel,
        value: job.hourlyMinRate == null
            ? l10n.jobAnalysisUnavailableValue
            : formatUsd(job.hourlyMinRate!),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisHourlyMaxLabel,
        value: job.hourlyMaxRate == null
            ? l10n.jobAnalysisUnavailableValue
            : formatUsd(job.hourlyMaxRate!),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisJobTypeLabel,
        value: enumNameLabel(job.jobType),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisExperienceLabel,
        value: enumNameLabel(job.experienceLevel),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisPaymentVerifiedLabel,
        value: paymentVerifiedStatusLabel(l10n, job.paymentVerifiedStatus),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisAllowedCountriesLabel,
        value: job.allowedApplicantCountries.isEmpty
            ? l10n.jobAnalysisUnavailableValue
            : joinLabels(job.allowedApplicantCountries.map(enumNameLabel)),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisClientNameLabel,
        value: job.clientName ?? l10n.jobAnalysisUnavailableValue,
      ),
      _DetailRowData(
        label: l10n.jobAnalysisClientNameConfidenceLabel,
        value: job.clientNameConfidencePercent == null
            ? l10n.jobAnalysisUnavailableValue
            : formatPercent(job.clientNameConfidencePercent),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisClientAverageHourlyRateLabel,
        value: job.clientAvgHourlyRate == null
            ? l10n.jobAnalysisUnavailableValue
            : formatUsd(job.clientAvgHourlyRate!),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisClientRatingLabel,
        value: job.clientRating == null
            ? l10n.jobAnalysisUnavailableValue
            : l10n.jobAnalysisClientRatingValue(formatRating(job.clientRating)),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisClientHireRateLabel,
        value: job.clientHireRatePercent == null
            ? l10n.jobAnalysisUnavailableValue
            : formatPercent(job.clientHireRatePercent),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisClientTotalSpentLabel,
        value: job.clientTotalSpent == null
            ? l10n.jobAnalysisUnavailableValue
            : formatUsd(job.clientTotalSpent!),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisClientCountryLabel,
        value: job.clientLocation?.country == null
            ? l10n.jobAnalysisUnavailableValue
            : enumNameLabel(job.clientLocation!.country!),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisClientRegionLabel,
        value: job.clientLocation?.region == null
            ? l10n.jobAnalysisUnavailableValue
            : enumNameLabel(job.clientLocation!.region!),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisClientSubRegionLabel,
        value: job.clientLocation?.subRegion == null
            ? l10n.jobAnalysisUnavailableValue
            : enumNameLabel(job.clientLocation!.subRegion!),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisTagsLabel,
        value: job.tags.isEmpty
            ? l10n.jobAnalysisUnavailableValue
            : job.tags.join(', '),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisHasHiredLabel,
        value: boolLabel(l10n, job.hasHired),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisQuestionCountLabel,
        value: (job.questions?.length ?? 0).toString(),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisPersistedAtLabel,
        value: formatDateTimeValue(analysis.createdJobInfoAt),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisScoreGeneratedAtLabel,
        value: formatDateTimeValue(analysis.createdJobScoringAt),
      ),
      _DetailRowData(
        label: l10n.jobAnalysisAiResponsesGeneratedAtLabel,
        value: formatDateTimeValue(analysis.createdJobAiResponsesAt),
      ),
    ];
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
            FilledButton.icon(
              onPressed: onOpenJob,
              icon: const Icon(Icons.open_in_new_rounded),
              label: Text(l10n.jobAnalysisViewJobButton),
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

class _StatsTable extends StatelessWidget {
  const _StatsTable({required this.rows});

  final List<_DetailRowData> rows;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Table(
      columnWidths: const {0: FixedColumnWidth(180), 1: FlexColumnWidth()},
      border: TableBorder(
        horizontalInside: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.12),
        ),
        top: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.12),
        ),
        bottom: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      children: [
        for (final row in rows)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Text(
                  row.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: SelectableText(
                  row.value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.88),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
      ],
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
  const _DetailRowData({required this.label, required this.value});

  final String label;
  final String value;
}
