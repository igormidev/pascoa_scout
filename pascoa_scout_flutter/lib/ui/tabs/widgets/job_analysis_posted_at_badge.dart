import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';

class JobAnalysisPostedAtBadge extends StatefulWidget {
  const JobAnalysisPostedAtBadge({super.key, required this.postedAt});

  final DateTime? postedAt;

  @override
  State<JobAnalysisPostedAtBadge> createState() =>
      _JobAnalysisPostedAtBadgeState();
}

class _JobAnalysisPostedAtBadgeState extends State<JobAnalysisPostedAtBadge> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _scheduleRefresh();
  }

  @override
  void didUpdateWidget(covariant JobAnalysisPostedAtBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.postedAt != widget.postedAt) {
      _scheduleRefresh();
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final label = _formatPostedAtLabel(
      l10n: l10n,
      postedAt: widget.postedAt,
      now: DateTime.now(),
      localeName: localeName,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule_rounded,
            size: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void _scheduleRefresh() {
    _refreshTimer?.cancel();

    final postedAt = widget.postedAt?.toLocal();
    final now = DateTime.now();
    if (!_needsLiveRefresh(postedAt: postedAt, now: now)) {
      return;
    }

    final delay = Duration(
      minutes: 1,
      seconds: -now.second,
      milliseconds: -now.millisecond,
      microseconds: -now.microsecond,
    );
    _refreshTimer = Timer(delay, _handleRefreshTick);
  }

  void _handleRefreshTick() {
    if (!mounted) {
      return;
    }

    setState(() {});
    _scheduleRefresh();
  }
}

String _formatPostedAtLabel({
  required AppLocalizations l10n,
  required DateTime? postedAt,
  required DateTime now,
  required String localeName,
}) {
  if (postedAt == null) {
    return l10n.jobAnalysisUnavailableValue;
  }

  final localPostedAt = postedAt.toLocal();
  final clampedNow = now.isBefore(localPostedAt) ? localPostedAt : now;
  final postedDay = DateTime(
    localPostedAt.year,
    localPostedAt.month,
    localPostedAt.day,
  );
  final currentDay = DateTime(
    clampedNow.year,
    clampedNow.month,
    clampedNow.day,
  );
  final previousDay = currentDay.subtract(const Duration(days: 1));

  if (postedDay == currentDay) {
    return _formatTodayLabel(
      l10n: l10n,
      postedAt: localPostedAt,
      now: clampedNow,
    );
  }

  if (postedDay == previousDay) {
    final timeLabel = DateFormat.Hm(localeName).format(localPostedAt);
    return l10n.jobAnalysisPostedYesterdayAt(timeLabel);
  }

  final monthLabel = DateFormat.MMM(localeName).format(localPostedAt);
  return l10n.jobAnalysisPostedMonthDay(localPostedAt.day, monthLabel);
}

String _formatTodayLabel({
  required AppLocalizations l10n,
  required DateTime postedAt,
  required DateTime now,
}) {
  final elapsed = now.difference(postedAt);
  final totalMinutes = elapsed.inMinutes;
  final hours = elapsed.inHours;
  final minutes = elapsed.inMinutes.remainder(60);

  if (hours == 0) {
    return l10n.jobAnalysisPostedMinutesAgo(totalMinutes);
  }

  if (minutes == 0) {
    return l10n.jobAnalysisPostedHoursAgo(hours);
  }

  return l10n.jobAnalysisPostedHoursAndMinutesAgo(hours, minutes);
}

bool _needsLiveRefresh({required DateTime? postedAt, required DateTime now}) {
  if (postedAt == null || postedAt.isAfter(now)) {
    return false;
  }

  return postedAt.year == now.year &&
      postedAt.month == now.month &&
      postedAt.day == now.day;
}
