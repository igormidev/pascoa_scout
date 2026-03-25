import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pascoa_scout/interactor/app_notification/app_notification_providers.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';
import 'package:url_launcher/url_launcher.dart';

class JobAnalysisCard extends StatefulWidget {
  const JobAnalysisCard({
    super.key,
    required this.analysis,
    required this.onRefresh,
    this.isRefreshing = false,
  });

  final JobAnalysisState analysis;
  final Future<void> Function(int id)? onRefresh;
  final bool isRefreshing;

  @override
  State<JobAnalysisCard> createState() => _JobAnalysisCardState();
}

class _JobAnalysisCardState extends State<JobAnalysisCard> {
  bool _isCoverLetterExpanded = false;

  JobInfo get _job => widget.analysis.jobInfo!;
  bool get _isCompleted =>
      widget.analysis.score != null && widget.analysis.proposal != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final proposal = widget.analysis.proposal;
    final score = widget.analysis.score;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: theme.colorScheme.surface.withValues(alpha: 0.94),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.26),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 26,
                offset: const Offset(0, 14),
              ),
            ],
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
                          _job.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _buildClientLine(_job),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.72),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _MetaPill(
                        icon: Icons.schedule_rounded,
                        label:
                            _job.relativeDate ??
                            _job.absoluteDate ??
                            'Date unavailable',
                      ),
                      const SizedBox(height: 10),
                      _StatusPill(analysis: widget.analysis),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (_job.budget != null)
                    _InfoChip(
                      icon: Icons.payments_rounded,
                      label: _job.budget!,
                    ),
                  if (_job.clientRating != null)
                    _InfoChip(
                      icon: Icons.star_rounded,
                      label: 'Client ${_job.clientRating!.toStringAsFixed(1)}',
                    ),
                  if (_job.clientHireRatePercent != null)
                    _InfoChip(
                      icon: Icons.percent_rounded,
                      label:
                          'Hire ${_job.clientHireRatePercent!.toStringAsFixed(1)}%',
                    ),
                  if ((_job.questions?.isNotEmpty ?? false))
                    _InfoChip(
                      icon: Icons.quiz_rounded,
                      label: '${_job.questions!.length} question(s)',
                    ),
                  if (_job.tags.isNotEmpty)
                    for (final tag in _job.tags.take(5))
                      _InfoChip(icon: Icons.sell_rounded, label: tag),
                ],
              ),
              const SizedBox(height: 18),
              _SectionBlock(
                title: 'Description',
                child: SelectableText(
                  _job.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.55,
                    color: Colors.white.withValues(alpha: 0.82),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SectionBlock(
                title: 'Analysis timeline',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TimelineRow(
                      label: 'Job persisted',
                      value: _formatDateTime(widget.analysis.createdJobInfoAt),
                    ),
                    _TimelineRow(
                      label: 'Score generated',
                      value: _formatDateTime(
                        widget.analysis.createdJobScoringAt,
                      ),
                    ),
                    _TimelineRow(
                      label: 'AI responses generated',
                      value: _formatDateTime(
                        widget.analysis.createdJobAiResponsesAt,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionBlock(
                title: 'Compatibility score',
                child: score == null
                    ? _PendingCopy(
                        icon: Icons.psychology_alt_rounded,
                        message:
                            'The scoring step has not finished for this job yet.',
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: _scoreColor(
                                    score.scorePercentage,
                                  ).withValues(alpha: 0.16),
                                ),
                                child: Text(
                                  '${score.scorePercentage}%',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: _scoreColor(score.scorePercentage),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SelectableText(
                            score.aiScoreJustificationText,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.82),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 16),
              _SectionBlock(
                title: 'AI-generated cover letter',
                trailing: proposal == null
                    ? null
                    : IconButton(
                        tooltip: 'Copy cover letter',
                        onPressed: () => _copyText(
                          context,
                          proposal.aiGeneratedCoverLetterText,
                          'Cover letter copied.',
                        ),
                        icon: const Icon(Icons.content_copy_rounded),
                      ),
                child: proposal == null
                    ? _PendingCopy(
                        icon: Icons.mark_email_unread_outlined,
                        message:
                            'The proposal step has not finished for this job yet.',
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            proposal.aiGeneratedCoverLetterText,
                            maxLines: _isCoverLetterExpanded ? null : 2,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.82),
                              height: 1.55,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _isCoverLetterExpanded =
                                    !_isCoverLetterExpanded;
                              });
                            },
                            icon: Icon(
                              _isCoverLetterExpanded
                                  ? Icons.unfold_less_rounded
                                  : Icons.unfold_more_rounded,
                            ),
                            label: Text(
                              _isCoverLetterExpanded ? 'Collapse' : 'Expand',
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 16),
              _SectionBlock(
                title: 'Question answers',
                child: proposal == null || (proposal.answers?.isEmpty ?? true)
                    ? _PendingCopy(
                        icon: Icons.question_answer_outlined,
                        message: (_job.questions?.isNotEmpty ?? false)
                            ? 'Answers will appear here after proposal generation finishes.'
                            : 'This job has no application questions.',
                      )
                    : Column(
                        children: [
                          for (final answer in proposal.answers!)
                            _AnswerCard(answer: answer),
                        ],
                      ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _openJob(context, _job.url),
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: const Text('Open job on Upwork'),
                ),
              ),
            ],
          ),
        ),
        if (!_isCompleted && widget.analysis.id != null)
          Positioned(
            top: -8,
            right: -8,
            child: Material(
              elevation: 8,
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(999),
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: widget.onRefresh == null || widget.isRefreshing
                    ? null
                    : () => widget.onRefresh!(widget.analysis.id!),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: widget.isRefreshing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF03110D),
                          ),
                        )
                      : const Icon(
                          Icons.refresh_rounded,
                          color: Color(0xFF03110D),
                        ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _openJob(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      notifySnackbarWithContext(
        context,
        message: 'The job URL is invalid.',
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
        message: 'Unable to open this Upwork job.',
        tone: AppNotificationTone.error,
      );
    }
  }

  Future<void> _copyText(
    BuildContext context,
    String text,
    String successMessage,
  ) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) {
      return;
    }
    notifySnackbarWithContext(context, message: successMessage);
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({
    required this.title,
    required this.child,
    this.trailing,
  });

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.03),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (trailing != null) ...[trailing!],
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _AnswerCard extends StatelessWidget {
  const _AnswerCard({required this.answer});

  final JobProposalAnswerToQuestion answer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final questionLabel = answer.relatedQuestion?.question ?? 'Question';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  questionLabel,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Copy answer',
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: answer.aiGeneratedAnswerText),
                  );
                  if (!context.mounted) {
                    return;
                  }
                  notifySnackbarWithContext(context, message: 'Answer copied.');
                },
                icon: const Icon(Icons.content_copy_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SelectableText(
            answer.aiGeneratedAnswerText,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: Colors.white.withValues(alpha: 0.82),
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingCopy extends StatelessWidget {
  const _PendingCopy({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.68),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.05),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.analysis});

  final JobAnalysisState analysis;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch ((
      analysis.score != null,
      analysis.proposal != null,
    )) {
      (true, true) => ('Completed', const Color(0xFF5EE9B5)),
      (true, false) => ('Scored', const Color(0xFFFAC94A)),
      (false, false) => ('Pending AI', Theme.of(context).colorScheme.secondary),
      _ => ('In progress', Theme.of(context).colorScheme.secondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: color.withValues(alpha: 0.16),
      ),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w700, color: color),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.05),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8),
          Text(label),
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

String _formatDateTime(DateTime? value) {
  if (value == null) {
    return 'Not available yet';
  }

  final local = value.toLocal();
  final month = local.month.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '${local.year}-$month-$day $hour:$minute';
}

Color _scoreColor(int value) {
  if (value >= 80) {
    return const Color(0xFF5EE9B5);
  }
  if (value >= 60) {
    return const Color(0xFFFAC94A);
  }
  return const Color(0xFFFF8C7A);
}
