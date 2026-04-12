import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

class JobAnalysisForceSyncDialog extends StatefulWidget {
  const JobAnalysisForceSyncDialog({
    super.key,
    required this.progressStream,
    required this.jobAnalysisStateId,
    this.jobTitle,
  });

  final Stream<JobAnalysisForceSyncProgress> progressStream;
  final int jobAnalysisStateId;
  final String? jobTitle;

  @override
  State<JobAnalysisForceSyncDialog> createState() =>
      _JobAnalysisForceSyncDialogState();
}

class _JobAnalysisForceSyncDialogState
    extends State<JobAnalysisForceSyncDialog> {
  StreamSubscription<JobAnalysisForceSyncProgress>? _subscription;
  JobAnalysisForceSyncProgress? _progress;
  JobAnalysisState? _resultAnalysis;
  Object? _streamError;

  bool get _canClose {
    final currentStage = _progress?.currentStage;
    return currentStage == JobAnalysisForceSyncStage.completed ||
        currentStage == JobAnalysisForceSyncStage.failed;
  }

  @override
  void initState() {
    super.initState();
    _subscription = widget.progressStream.listen(
      (progress) {
        if (!mounted) {
          return;
        }
        setState(() {
          _progress = progress;
          _resultAnalysis = progress.analysis ?? _resultAnalysis;
          _streamError = null;
        });
      },
      onError: (error, _) {
        if (!mounted) {
          return;
        }
        setState(() {
          _streamError = error;
          _progress =
              _progress ??
              JobAnalysisForceSyncProgress(
                jobAnalysisStateId: widget.jobAnalysisStateId,
                currentStage: JobAnalysisForceSyncStage.failed,
                isFixedPriceJob: false,
                scoreStatus: JobAnalysisForceSyncStageStatus.pending,
                proposalStatus: JobAnalysisForceSyncStageStatus.pending,
                answersStatus: JobAnalysisForceSyncStageStatus.pending,
                milestonesStatus: JobAnalysisForceSyncStageStatus.pending,
                errorMessage: error.toString(),
              );
        });
      },
      onDone: () {
        if (!mounted || _canClose) {
          return;
        }
        setState(() {
          _progress = JobAnalysisForceSyncProgress(
            jobAnalysisStateId: widget.jobAnalysisStateId,
            currentStage: JobAnalysisForceSyncStage.failed,
            isFixedPriceJob: _progress?.isFixedPriceJob ?? false,
            scoreStatus:
                _progress?.scoreStatus ??
                JobAnalysisForceSyncStageStatus.pending,
            proposalStatus:
                _progress?.proposalStatus ??
                JobAnalysisForceSyncStageStatus.pending,
            answersStatus:
                _progress?.answersStatus ??
                JobAnalysisForceSyncStageStatus.pending,
            milestonesStatus:
                _progress?.milestonesStatus ??
                JobAnalysisForceSyncStageStatus.pending,
            errorMessage: null,
            analysis: _resultAnalysis,
          );
        });
      },
      cancelOnError: false,
    );
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final progress = _progress;
    final progressValue = progress == null
        ? null
        : jobAnalysisForceSyncProgressValue(progress);
    final percentageLabel = progress == null
        ? '--'
        : '${(progressValue! * 100).round()}%';
    final currentStageLabel = jobAnalysisForceSyncStageLabel(
      l10n,
      progress?.currentStage ?? JobAnalysisForceSyncStage.preparing,
    );
    final errorMessage = progress?.errorMessage ?? _streamError?.toString();
    final actionLabel =
        progress?.currentStage == JobAnalysisForceSyncStage.completed
        ? l10n.jobAnalysisForceSyncDoneButton
        : l10n.jobAnalysisForceSyncCloseButton;

    return PopScope(
      canPop: _canClose,
      child: AlertDialog(
        title: Text(l10n.jobAnalysisForceSyncDialogTitle),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.jobTitle?.isNotEmpty ?? false)
                Text(
                  widget.jobTitle!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              if (widget.jobTitle?.isNotEmpty ?? false)
                const SizedBox(height: 8),
              Text(
                l10n.jobAnalysisForceSyncDialogDescription,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 108,
                  height: 108,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 92,
                        height: 92,
                        child: CircularProgressIndicator(
                          value: progressValue,
                          strokeWidth: 7,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Text(
                        percentageLabel,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  currentStageLabel,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: theme.colorScheme.errorContainer,
                  ),
                  child: Text(
                    errorMessage.isEmpty
                        ? l10n.jobAnalysisForceSyncUnexpectedFailure
                        : errorMessage,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              _JobAnalysisForceSyncStageTile(
                label: l10n.jobAnalysisForceSyncStepScore,
                status:
                    progress?.scoreStatus ??
                    JobAnalysisForceSyncStageStatus.pending,
              ),
              const SizedBox(height: 10),
              _JobAnalysisForceSyncStageTile(
                label: l10n.jobAnalysisForceSyncStepProposal,
                status:
                    progress?.proposalStatus ??
                    JobAnalysisForceSyncStageStatus.pending,
              ),
              const SizedBox(height: 10),
              _JobAnalysisForceSyncStageTile(
                label: l10n.jobAnalysisForceSyncStepAnswers,
                status:
                    progress?.answersStatus ??
                    JobAnalysisForceSyncStageStatus.pending,
              ),
              const SizedBox(height: 10),
              _JobAnalysisForceSyncStageTile(
                label: l10n.jobAnalysisForceSyncStepMilestones,
                status:
                    progress?.milestonesStatus ??
                    JobAnalysisForceSyncStageStatus.pending,
              ),
            ],
          ),
        ),
        actions: [
          if (_canClose)
            FilledButton(
              onPressed: () => Navigator.of(context).pop(_resultAnalysis),
              child: Text(actionLabel),
            ),
        ],
      ),
    );
  }
}

class _JobAnalysisForceSyncStageTile extends StatelessWidget {
  const _JobAnalysisForceSyncStageTile({
    required this.label,
    required this.status,
  });

  final String label;
  final JobAnalysisForceSyncStageStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final statusColor = jobAnalysisForceSyncStatusColor(
      theme.colorScheme,
      status,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.35,
        ),
      ),
      child: Row(
        children: [
          _JobAnalysisForceSyncStageIndicator(
            status: status,
            color: statusColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            jobAnalysisForceSyncStatusLabel(l10n, status),
            style: theme.textTheme.labelLarge?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _JobAnalysisForceSyncStageIndicator extends StatelessWidget {
  const _JobAnalysisForceSyncStageIndicator({
    required this.status,
    required this.color,
  });

  final JobAnalysisForceSyncStageStatus status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case JobAnalysisForceSyncStageStatus.running:
        return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2.4, color: color),
        );
      case JobAnalysisForceSyncStageStatus.completed:
        return Icon(Icons.check_circle_rounded, color: color, size: 22);
      case JobAnalysisForceSyncStageStatus.failed:
        return Icon(Icons.error_rounded, color: color, size: 22);
      case JobAnalysisForceSyncStageStatus.skipped:
        return Icon(
          Icons.remove_circle_outline_rounded,
          color: color,
          size: 22,
        );
      case JobAnalysisForceSyncStageStatus.pending:
        return Icon(
          Icons.radio_button_unchecked_rounded,
          color: color,
          size: 22,
        );
    }
  }
}

double jobAnalysisForceSyncProgressValue(
  JobAnalysisForceSyncProgress progress,
) {
  final statuses = <JobAnalysisForceSyncStageStatus>[
    progress.scoreStatus,
    progress.proposalStatus,
    progress.answersStatus,
    progress.milestonesStatus,
  ].where((status) => status != JobAnalysisForceSyncStageStatus.skipped);

  final actionableStatuses = statuses.toList(growable: false);
  if (actionableStatuses.isEmpty) {
    return 1;
  }

  final completedUnits = actionableStatuses.fold<double>(
    0,
    (sum, status) =>
        sum +
        switch (status) {
          JobAnalysisForceSyncStageStatus.pending => 0,
          JobAnalysisForceSyncStageStatus.running => 0.5,
          JobAnalysisForceSyncStageStatus.completed => 1,
          JobAnalysisForceSyncStageStatus.skipped => 1,
          JobAnalysisForceSyncStageStatus.failed => 1,
        },
  );

  return (completedUnits / actionableStatuses.length).clamp(0, 1);
}

String jobAnalysisForceSyncStageLabel(
  AppLocalizations l10n,
  JobAnalysisForceSyncStage stage,
) {
  return switch (stage) {
    JobAnalysisForceSyncStage.preparing =>
      l10n.jobAnalysisForceSyncCurrentPreparing,
    JobAnalysisForceSyncStage.score => l10n.jobAnalysisForceSyncCurrentScore,
    JobAnalysisForceSyncStage.proposal =>
      l10n.jobAnalysisForceSyncCurrentProposal,
    JobAnalysisForceSyncStage.answers =>
      l10n.jobAnalysisForceSyncCurrentAnswers,
    JobAnalysisForceSyncStage.milestones =>
      l10n.jobAnalysisForceSyncCurrentMilestones,
    JobAnalysisForceSyncStage.reloadingCard =>
      l10n.jobAnalysisForceSyncCurrentReloading,
    JobAnalysisForceSyncStage.completed =>
      l10n.jobAnalysisForceSyncCurrentCompleted,
    JobAnalysisForceSyncStage.failed => l10n.jobAnalysisForceSyncCurrentFailed,
  };
}

String jobAnalysisForceSyncStatusLabel(
  AppLocalizations l10n,
  JobAnalysisForceSyncStageStatus status,
) {
  return switch (status) {
    JobAnalysisForceSyncStageStatus.pending =>
      l10n.jobAnalysisForceSyncStatusPending,
    JobAnalysisForceSyncStageStatus.running =>
      l10n.jobAnalysisForceSyncStatusRunning,
    JobAnalysisForceSyncStageStatus.completed =>
      l10n.jobAnalysisForceSyncStatusCompleted,
    JobAnalysisForceSyncStageStatus.skipped =>
      l10n.jobAnalysisForceSyncStatusSkipped,
    JobAnalysisForceSyncStageStatus.failed =>
      l10n.jobAnalysisForceSyncStatusFailed,
  };
}

Color jobAnalysisForceSyncStatusColor(
  ColorScheme colorScheme,
  JobAnalysisForceSyncStageStatus status,
) {
  return switch (status) {
    JobAnalysisForceSyncStageStatus.pending => colorScheme.onSurface.withValues(
      alpha: 0.38,
    ),
    JobAnalysisForceSyncStageStatus.running => colorScheme.primary,
    JobAnalysisForceSyncStageStatus.completed => const Color(0xFF1E8E5A),
    JobAnalysisForceSyncStageStatus.skipped => colorScheme.onSurface.withValues(
      alpha: 0.5,
    ),
    JobAnalysisForceSyncStageStatus.failed => colorScheme.error,
  };
}
