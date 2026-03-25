import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

String jobAnalysisCompensationLabel(AppLocalizations l10n, JobInfo job) {
  if (job.jobType == JobType.hourly) {
    final minRate = job.hourlyMinRate;
    final maxRate = job.hourlyMaxRate;
    if (minRate != null && maxRate != null) {
      return '${formatUsd(minRate)} - ${formatUsd(maxRate)}';
    }
    if (minRate != null) {
      return l10n.jobAnalysisHourlyFromLabel(formatUsd(minRate));
    }
    if (maxRate != null) {
      return l10n.jobAnalysisHourlyUpToLabel(formatUsd(maxRate));
    }
  }

  if (job.fixedPriceAmount != null) {
    return formatUsd(job.fixedPriceAmount!);
  }

  if (job.budget?.isNotEmpty ?? false) {
    return job.budget!;
  }

  return l10n.jobAnalysisUnavailableValue;
}

IconData jobAnalysisCompensationIcon(JobInfo job) {
  return job.jobType == JobType.hourly
      ? Icons.schedule_rounded
      : Icons.attach_money_rounded;
}

String jobAnalysisQuestionsLabel(AppLocalizations l10n, int count) {
  return l10n.jobAnalysisQuestionsChip(count);
}

String jobAnalysisClientHireRateLabel(AppLocalizations l10n, double? value) {
  return l10n.jobAnalysisHireChip(formatPercent(value));
}

String formatUsd(num value) {
  final decimalDigits = value % 1 == 0 ? 0 : 2;
  return NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: decimalDigits,
  ).format(value);
}

String formatPercent(num? value) {
  if (value == null) {
    return '-';
  }

  final formatted = value % 1 == 0
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
  return '$formatted%';
}

String formatRating(double? value) {
  if (value == null) {
    return '-';
  }

  return value.toStringAsFixed(1);
}

String formatDateTimeValue(DateTime? value) {
  if (value == null) {
    return '-';
  }

  return DateFormat('yyyy-MM-dd HH:mm').format(value.toLocal());
}

String enumNameLabel(Enum value) {
  return sentenceCaseLabel(value.name);
}

String sentenceCaseLabel(String value) {
  final spaced = value
      .replaceAll('_', ' ')
      .replaceAllMapped(
        RegExp(r'([a-z])([A-Z])'),
        (match) => '${match.group(1)} ${match.group(2)}',
      )
      .trim();
  if (spaced.isEmpty) {
    return spaced;
  }

  return spaced[0].toUpperCase() + spaced.substring(1);
}

String boolLabel(AppLocalizations l10n, bool value) {
  return value ? l10n.jobAnalysisYesValue : l10n.jobAnalysisNoValue;
}

String paymentVerifiedStatusLabel(
  AppLocalizations l10n,
  PaymentVerifiedStatus status,
) {
  return switch (status) {
    PaymentVerifiedStatus.unknown => l10n.jobAnalysisPaymentStatusUnknown,
    PaymentVerifiedStatus.verified => l10n.jobAnalysisPaymentStatusVerified,
    PaymentVerifiedStatus.unverified => l10n.jobAnalysisPaymentStatusUnverified,
  };
}

String joinLabels(Iterable<String> values) {
  final filtered = values.where((value) => value.trim().isNotEmpty).toList();
  if (filtered.isEmpty) {
    return '-';
  }

  return filtered.join(', ');
}

Color jobAnalysisScoreColor(ColorScheme colorScheme, int score) {
  if (score >= 80) {
    return const Color(0xFF4BC27B);
  }
  if (score >= 60) {
    return const Color(0xFFF3C15A);
  }
  if (score >= 40) {
    return const Color(0xFFF49D52);
  }
  return colorScheme.error;
}

bool isSameJobAnalysis(JobAnalysisState left, JobAnalysisState right) {
  final leftId = left.id;
  final rightId = right.id;
  if (leftId != null && rightId != null) {
    return leftId == rightId;
  }

  return left.jobInfoId == right.jobInfoId;
}
