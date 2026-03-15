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

    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JobsHeader(syncState: syncState),
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
                    separatorBuilder: (_, _) => const SizedBox(height: 14.0),
                    itemBuilder: (context, index) {
                      return _JobCard(
                        trackedJob: syncState.jobs[index],
                        now: now,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _JobsHeader extends StatelessWidget {
  const _JobsHeader({required this.syncState});

  final JobSyncState syncState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        color: theme.colorScheme.surface.withValues(alpha: 0.92),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.28),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Job matches', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 8.0),
                Text(
                  'Every unique match stays in this list. New pulls merge repeated jobs instead of paginating the view.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 12.0,
            ),
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
          ),
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

class _JobCard extends ConsumerWidget {
  const _JobCard({required this.trackedJob, required this.now});

  final TrackedJob trackedJob;
  final DateTime now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final job = trackedJob.job;
    final ageText = '${_formatPostedAge(trackedJob.ageAt(now))} ago';

    return Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        color: theme.colorScheme.surface.withValues(alpha: 0.94),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.28),
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
                      job.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _buildClientLine(job),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.74),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              _MetaPill(
                label: ageText,
                icon: Icons.schedule_rounded,
                highlighted: true,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            job.description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _MetaPill(
                label: _jobTypeLabel(job.jobType),
                icon: Icons.work_history_rounded,
              ),
              _MetaPill(
                label: _experienceLevelLabel(job.experienceLevel),
                icon: Icons.trending_up_rounded,
              ),
              if (job.budget != null && job.budget!.isNotEmpty)
                _MetaPill(label: job.budget!, icon: Icons.attach_money_rounded),
              _MetaPill(
                label: _paymentStatusLabel(job.paymentVerifiedStatus),
                icon: Icons.verified_user_rounded,
              ),
              _MetaPill(
                label: job.hasHired ? 'Client has hired' : 'No hires yet',
                icon: Icons.person_search_rounded,
              ),
              if (job.clientLocation != null)
                _MetaPill(
                  label: _clientLocationLabel(job.clientLocation!),
                  icon: Icons.public_rounded,
                ),
              if (job.clientAvgHourlyRate != null)
                _MetaPill(
                  label:
                      'Avg \$${job.clientAvgHourlyRate!.toStringAsFixed(0)}/h',
                  icon: Icons.speed_rounded,
                ),
              if (job.clientRating != null)
                _MetaPill(
                  label: 'Rating ${job.clientRating!.toStringAsFixed(1)}',
                  icon: Icons.star_rounded,
                ),
              if (job.clientTotalSpent != null)
                _MetaPill(
                  label: 'Spent \$${job.clientTotalSpent!.toStringAsFixed(0)}',
                  icon: Icons.account_balance_wallet_rounded,
                ),
              if (job.questions.isNotEmpty)
                _MetaPill(
                  label: '${job.questions.length} screening questions',
                  icon: Icons.quiz_rounded,
                ),
              _MetaPill(
                label: job.allowedApplicantCountries.isEmpty
                    ? 'Applicants not restricted'
                    : '${job.allowedApplicantCountries.length} allowed countries',
                icon: Icons.flag_rounded,
              ),
            ],
          ),
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
