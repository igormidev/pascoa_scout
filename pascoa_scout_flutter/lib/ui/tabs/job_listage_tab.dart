import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/interactor/job_filter/current_filter_state.dart';
import 'package:pascoa_scout/interactor/job_filter/job_filter_providers.dart';
import 'package:pascoa_scout/interactor/job_sync/job_sync_providers.dart';
import 'package:pascoa_scout/interactor/job_sync/job_sync_state.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';
import 'package:url_launcher/url_launcher.dart';

class JobListageTab extends ConsumerWidget {
  const JobListageTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(
      currentFilterNotifier.select(
        (state) => state.maybeWhen(
          withFilter: (jobFilter) => jobFilter,
          orElse: () => null,
        ),
      ),
    );
    final syncState = ref.watch(jobSyncControllerProvider);
    final now = ref
        .watch(jobSyncClockProvider)
        .maybeWhen(data: (value) => value, orElse: DateTime.now);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 720.0;
        final horizontalPadding = constraints.maxWidth < 520.0 ? 16.0 : 24.0;
        final verticalPadding = isCompact ? 20.0 : 28.0;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            verticalPadding,
            horizontalPadding,
            verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _JobsHeader(syncState: syncState, compact: isCompact),
              const SizedBox(height: 18.0),
              Expanded(
                child: currentFilter == null
                    ? const _JobsEmptyState(
                        title: 'Save a filter first',
                        description:
                            'The right side activates after you save the first Upwork filter on the left.',
                        icon: Icons.filter_alt_off_rounded,
                      )
                    : syncState.jobs.isEmpty
                    ? _JobsEmptyState(
                        title: syncState.isRunning
                            ? 'Waiting for the first pull'
                            : 'No jobs loaded yet',
                        description: syncState.isRunning
                            ? 'The polling loop is active. New matches will appear here as soon as the next pull completes.'
                            : 'Start synchronization on the left and every unique match will accumulate here without pagination.',
                        icon: syncState.isRunning
                            ? Icons.hourglass_top_rounded
                            : Icons.search_off_rounded,
                      )
                    : ListView.separated(
                        itemCount: syncState.jobs.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: 14.0),
                        itemBuilder: (context, index) {
                          return _JobCard(
                            trackedJob: syncState.jobs[index],
                            now: now,
                            compact: isCompact,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _JobsHeader extends StatelessWidget {
  const _JobsHeader({required this.syncState, required this.compact});

  final JobSyncState syncState;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = Text(
      'Every unique match stays in this list. New pulls merge repeated jobs instead of paginating the view.',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: Colors.white.withValues(alpha: 0.72),
      ),
    );
    final statsCard = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: syncState.isRunning
            ? theme.colorScheme.primary.withValues(alpha: 0.16)
            : Colors.white.withValues(alpha: 0.04),
        border: Border.all(
          color: syncState.isRunning
              ? theme.colorScheme.primary.withValues(alpha: 0.42)
              : theme.colorScheme.outline.withValues(alpha: 0.32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${syncState.jobs.length}',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            syncState.isRunning ? 'live matches' : 'saved matches',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Job matches', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8.0),
        description,
      ],
    );

    return Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        color: theme.colorScheme.surface.withValues(alpha: 0.92),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.28),
        ),
      ),
      child: compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [titleBlock, const SizedBox(height: 16.0), statsCard],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: titleBlock),
                const SizedBox(width: 16.0),
                statsCard,
              ],
            ),
    );
  }
}

class _JobsEmptyState extends StatelessWidget {
  const _JobsEmptyState({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520.0),
        child: Container(
          padding: const EdgeInsets.all(28.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: theme.colorScheme.surface.withValues(alpha: 0.9),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.26),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48.0, color: theme.colorScheme.secondary),
              const SizedBox(height: 18.0),
              Text(
                title,
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Text(
                description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.72),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({
    required this.trackedJob,
    required this.now,
    required this.compact,
  });

  final TrackedJob trackedJob;
  final DateTime now;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final job = trackedJob.job;
    final ageText = '${_formatPostedAge(trackedJob.ageAt(now))} ago';
    final topMeta = Column(
      crossAxisAlignment: compact
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        _MetaPill(
          label: ageText,
          icon: Icons.schedule_rounded,
          highlighted: true,
        ),
        const SizedBox(height: 12.0),
        _RatingSummary(rating: job.clientRating),
      ],
    );
    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          job.title,
          maxLines: compact ? 4 : 3,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          _buildClientLine(job),
          maxLines: compact ? 2 : 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.74),
          ),
        ),
      ],
    );
    final detailRows = _buildJobDetailRows(job);

    return Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface.withValues(alpha: 0.98),
            const Color(0xFF0F211C),
          ],
        ),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 26.0,
            offset: const Offset(0.0, 14.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          compact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [titleBlock, const SizedBox(height: 14.0), topMeta],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: titleBlock),
                    const SizedBox(width: 16.0),
                    topMeta,
                  ],
                ),
          const SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.0),
              color: Colors.white.withValues(alpha: 0.04),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.18),
              ),
            ),
            child: Text(
              job.description,
              maxLines: compact ? 7 : 5,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          _JobDetailsTable(rows: detailRows, compact: compact),
          if (job.tags.isNotEmpty) ...[
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                for (final tag in job.tags)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999.0),
                      color: Colors.white.withValues(alpha: 0.04),
                    ),
                    child: Text(
                      tag,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 18.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _openJob(context, job.url),
              icon: const Icon(Icons.open_in_new_rounded),
              label: const Text('Open job on Upwork'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openJob(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('The job URL is invalid.')));
      return;
    }

    final wasOpened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!wasOpened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open this Upwork job.')),
      );
    }
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({
    required this.label,
    required this.icon,
    this.highlighted = false,
  });

  final String label;
  final IconData icon;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999.0),
        color: highlighted
            ? theme.colorScheme.primary.withValues(alpha: 0.16)
            : Colors.white.withValues(alpha: 0.04),
        border: Border.all(
          color: highlighted
              ? theme.colorScheme.primary.withValues(alpha: 0.34)
              : theme.colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16.0,
            color: highlighted
                ? theme.colorScheme.primary
                : theme.colorScheme.secondary,
          ),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: highlighted
                  ? theme.colorScheme.primary
                  : Colors.white.withValues(alpha: 0.84),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingSummary extends StatelessWidget {
  const _RatingSummary({required this.rating});

  final double? rating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasRating = rating != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client rating',
            style: theme.textTheme.labelMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.62),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StarRatingBar(rating: rating),
              const SizedBox(width: 10.0),
              Text(
                hasRating ? rating!.toStringAsFixed(1) : '-',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: hasRating
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.56),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StarRatingBar extends StatelessWidget {
  const _StarRatingBar({required this.rating});

  final double? rating;

  static const _starCount = 5;
  static const _starSize = 16.0;
  static const _starSpacing = 2.0;

  @override
  Widget build(BuildContext context) {
    final clampedRating = (rating ?? 0.0).clamp(0.0, _starCount.toDouble());
    final fillFraction = clampedRating / _starCount;
    final totalWidth =
        (_starSize * _starCount) + (_starSpacing * (_starCount - 1));

    return SizedBox(
      width: totalWidth,
      height: _starSize,
      child: Stack(
        children: [
          _buildStars(Colors.white.withValues(alpha: 0.12)),
          ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: fillFraction,
              child: _buildStars(const Color(0xFFFFC94A)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStars(Color color) {
    return Row(
      children: [
        for (var index = 0; index < _starCount; index++) ...[
          Icon(Icons.star_rounded, size: _starSize, color: color),
          if (index != _starCount - 1) const SizedBox(width: _starSpacing),
        ],
      ],
    );
  }
}

class _JobDetailsTable extends StatelessWidget {
  const _JobDetailsTable({required this.rows, required this.compact});

  final List<_JobTableRowData> rows;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelColumnWidth = compact ? 108.0 : 152.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: Colors.white.withValues(alpha: 0.025),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.18),
          ),
        ),
        child: Table(
          columnWidths: {
            0: const FixedColumnWidth(44.0),
            1: FixedColumnWidth(labelColumnWidth),
            2: const FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            for (var index = 0; index < rows.length; index++)
              TableRow(
                decoration: BoxDecoration(
                  color: index.isEven
                      ? Colors.white.withValues(alpha: 0.03)
                      : Colors.white.withValues(alpha: 0.015),
                  border: index == rows.length - 1
                      ? null
                      : Border(
                          bottom: BorderSide(
                            color: theme.colorScheme.outline.withValues(
                              alpha: 0.12,
                            ),
                          ),
                        ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 14.0, 10.0, 14.0),
                    child: Icon(
                      rows[index].icon,
                      size: 18.0,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 14.0, 12.0, 14.0),
                    child: Text(
                      rows[index].label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.64),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 14.0, 16.0, 14.0),
                    child: _JobTableValue(row: rows[index], compact: compact),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _JobTableValue extends StatelessWidget {
  const _JobTableValue({required this.row, required this.compact});

  final _JobTableRowData row;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final valueStyle = theme.textTheme.bodyMedium?.copyWith(
      height: compact ? 1.4 : 1.5,
      color: Colors.white.withValues(alpha: 0.88),
      fontFamily: row.monospace ? 'monospace' : null,
    );
    final values = row.values;

    if (values.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < values.length; index++)
            Padding(
              padding: EdgeInsets.only(
                bottom: index == values.length - 1 ? 0 : 6,
              ),
              child: Text(values[index], style: valueStyle),
            ),
        ],
      );
    }

    return Text(row.value ?? '-', style: valueStyle);
  }
}

class _JobTableRowData {
  const _JobTableRowData({
    required this.icon,
    required this.label,
    this.value,
    this.values = const [],
    this.monospace = false,
  });

  final IconData icon;
  final String label;
  final String? value;
  final List<String> values;
  final bool monospace;
}

List<_JobTableRowData> _buildJobDetailRows(JobInfo job) {
  final sortedQuestions = [...job.questions]
    ..sort((left, right) => left.positionIndex.compareTo(right.positionIndex));

  return [
    _JobTableRowData(
      icon: Icons.fingerprint_rounded,
      label: 'Job ID',
      value: _textOrDash(job.id),
      monospace: true,
    ),
    _JobTableRowData(
      icon: Icons.tag_rounded,
      label: 'Sub ID',
      value: _textOrDash(job.subId),
      monospace: true,
    ),
    _JobTableRowData(
      icon: Icons.schedule_send_rounded,
      label: 'Relative date',
      value: _textOrDash(job.relativeDate),
    ),
    _JobTableRowData(
      icon: Icons.event_rounded,
      label: 'Absolute date',
      value: _textOrDash(job.absoluteDate),
    ),
    _JobTableRowData(
      icon: Icons.work_history_rounded,
      label: 'Job type',
      value: _jobTypeLabel(job.jobType),
    ),
    _JobTableRowData(
      icon: Icons.trending_up_rounded,
      label: 'Experience',
      value: _experienceLevelLabel(job.experienceLevel),
    ),
    _JobTableRowData(
      icon: Icons.attach_money_rounded,
      label: 'Budget',
      value: _textOrDash(job.budget),
    ),
    _JobTableRowData(
      icon: Icons.verified_user_rounded,
      label: 'Payment',
      value: _paymentStatusLabel(job.paymentVerifiedStatus),
    ),
    _JobTableRowData(
      icon: Icons.person_outline_rounded,
      label: 'Client name',
      value: _textOrDash(job.clientName),
    ),
    _JobTableRowData(
      icon: Icons.fact_check_rounded,
      label: 'Name confidence',
      value: _formatPercent(job.clientNameConfidencePercent),
    ),
    _JobTableRowData(
      icon: Icons.public_rounded,
      label: 'Client location',
      value: job.clientLocation == null
          ? '-'
          : _clientLocationLabel(job.clientLocation!),
    ),
    _JobTableRowData(
      icon: Icons.person_search_rounded,
      label: 'Hire history',
      value: job.hasHired ? 'Client has hired' : 'No hires yet',
    ),
    _JobTableRowData(
      icon: Icons.percent_rounded,
      label: 'Hire rate',
      value: _formatPercent(job.clientHireRatePercent),
    ),
    _JobTableRowData(
      icon: Icons.speed_rounded,
      label: 'Avg hourly rate',
      value: _formatCurrency(job.clientAvgHourlyRate, suffix: '/h'),
    ),
    _JobTableRowData(
      icon: Icons.star_rounded,
      label: 'Client rating',
      value: _formatDecimal(job.clientRating, fractionDigits: 1),
    ),
    _JobTableRowData(
      icon: Icons.account_balance_wallet_rounded,
      label: 'Total spent',
      value: _formatCurrency(job.clientTotalSpent),
    ),
    _JobTableRowData(
      icon: Icons.flag_rounded,
      label: 'Allowed countries',
      value: job.allowedApplicantCountries.isEmpty
          ? 'Applicants not restricted'
          : job.allowedApplicantCountries
                .map((country) => _humanizeEnumName(country.name))
                .join(', '),
    ),
    _JobTableRowData(
      icon: Icons.quiz_rounded,
      label: 'Questions',
      values: [
        for (var index = 0; index < sortedQuestions.length; index++)
          '${index + 1}. ${sortedQuestions[index].question}',
      ],
    ),
    _JobTableRowData(
      icon: Icons.link_rounded,
      label: 'Upwork URL',
      value: _textOrDash(job.url),
      monospace: true,
    ),
  ];
}

String _buildClientLine(JobInfo job) {
  final parts = <String>[
    if (job.clientName != null && job.clientName!.trim().isNotEmpty)
      job.clientName!,
    if (job.clientLocation != null) _clientLocationLabel(job.clientLocation!),
  ];

  if (parts.isEmpty) {
    return 'Client details not available';
  }

  return parts.join(' · ');
}

String _textOrDash(String? value) {
  if (value == null) {
    return '-';
  }

  final trimmed = value.trim();
  return trimmed.isEmpty ? '-' : trimmed;
}

String _formatDecimal(double? value, {int fractionDigits = 0}) {
  if (value == null) {
    return '-';
  }

  return value.toStringAsFixed(fractionDigits);
}

String _formatPercent(double? value) {
  if (value == null) {
    return '-';
  }

  return '${value.toStringAsFixed(1)}%';
}

String _formatCurrency(double? value, {String suffix = ''}) {
  if (value == null) {
    return '-';
  }

  final formatted = value == value.roundToDouble()
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);

  return '\$$formatted$suffix';
}

String _formatPostedAge(Duration duration) {
  final safeDuration = duration.isNegative ? Duration.zero : duration;
  final days = safeDuration.inDays;
  final hours = safeDuration.inHours.remainder(24);
  final minutes = safeDuration.inMinutes.remainder(60);
  final seconds = safeDuration.inSeconds.remainder(60);

  final segments = <String>[
    if (days > 0) '${days}d',
    if (hours > 0 || days > 0) '${hours.toString().padLeft(2, '0')}h',
    if (minutes > 0 || hours > 0 || days > 0)
      '${minutes.toString().padLeft(2, '0')}m',
    '${seconds.toString().padLeft(2, '0')}s',
  ];

  return segments.join(' ');
}

String _jobTypeLabel(JobType jobType) {
  return switch (jobType) {
    JobType.fixed => 'Fixed price',
    JobType.hourly => 'Hourly',
  };
}

String _experienceLevelLabel(ExperienceLevel level) {
  return switch (level) {
    ExperienceLevel.entryLevel => 'Entry level',
    ExperienceLevel.intermediate => 'Intermediate',
    ExperienceLevel.expert => 'Expert',
  };
}

String _paymentStatusLabel(PaymentVerifiedStatus status) {
  return switch (status) {
    PaymentVerifiedStatus.unknown => 'Payment status unknown',
    PaymentVerifiedStatus.verified => 'Payment verified',
    PaymentVerifiedStatus.unverified => 'Payment unverified',
  };
}

String _clientLocationLabel(ClientLocation location) {
  final country = location.country;
  final subRegion = location.subRegion;
  final region = location.region;

  if (country != null) {
    return _humanizeEnumName(country.name);
  }
  if (subRegion != null) {
    return _humanizeEnumName(subRegion.name);
  }
  if (region != null) {
    return _humanizeEnumName(region.name);
  }

  return 'Location unavailable';
}

String _humanizeEnumName(String name) {
  final buffer = StringBuffer();

  for (var index = 0; index < name.length; index++) {
    final char = name[index];
    final isUppercase =
        char.toUpperCase() == char && char.toLowerCase() != char;
    final isDigit = int.tryParse(char) != null;
    if (index > 0 && (isUppercase || isDigit)) {
      buffer.write(' ');
    }
    buffer.write(char);
  }

  return buffer
      .toString()
      .split(' ')
      .map((word) {
        if (word.isEmpty) {
          return word;
        }
        return '${word[0].toUpperCase()}${word.substring(1)}';
      })
      .join(' ');
}
