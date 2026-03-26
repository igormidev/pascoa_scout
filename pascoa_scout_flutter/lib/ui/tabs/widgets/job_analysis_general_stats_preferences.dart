import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _jobAnalysisGeneralStatsPreferenceKey =
    'job_analysis_general_stats_preferences';

enum JobAnalysisGeneralStatKey {
  upworkId,
  subId,
  jobUrl,
  relativeDate,
  relativeDateMinutes,
  absoluteDate,
  absoluteDateTime,
  budget,
  compensation,
  fixedPriceAmount,
  hourlyMin,
  hourlyMax,
  jobType,
  experience,
  paymentVerified,
  allowedCountries,
  clientName,
  clientNameConfidence,
  clientAverageHourlyRate,
  clientRating,
  clientHireRate,
  clientTotalSpent,
  clientCountry,
  clientRegion,
  clientSubRegion,
  tags,
  hasHired,
  questionCount,
  persistedAt,
  scoreGeneratedAt,
  aiResponsesGeneratedAt,
}

final jobAnalysisGeneralStatsPreferencesProvider =
    NotifierProvider<
      JobAnalysisGeneralStatsPreferencesNotifier,
      JobAnalysisGeneralStatsPreferences
    >(JobAnalysisGeneralStatsPreferencesNotifier.new);

class JobAnalysisGeneralStatsPreferences {
  const JobAnalysisGeneralStatsPreferences({
    required this.orderedKeys,
    required this.hiddenKeys,
  });

  factory JobAnalysisGeneralStatsPreferences.defaults() {
    return const JobAnalysisGeneralStatsPreferences(
      orderedKeys: JobAnalysisGeneralStatKey.values,
      hiddenKeys: {},
    );
  }

  factory JobAnalysisGeneralStatsPreferences.fromJson(
    Map<String, dynamic> json,
  ) {
    final orderedIds = json['orderedKeys'];
    final hiddenIds = json['hiddenKeys'];

    return JobAnalysisGeneralStatsPreferences(
      orderedKeys: _parseKeys(orderedIds),
      hiddenKeys: _parseKeys(hiddenIds).toSet(),
    ).normalized();
  }

  final List<JobAnalysisGeneralStatKey> orderedKeys;
  final Set<JobAnalysisGeneralStatKey> hiddenKeys;

  List<JobAnalysisGeneralStatKey> get visibleOrderedKeys => [
    for (final key in normalized().orderedKeys)
      if (!hiddenKeys.contains(key)) key,
  ];

  JobAnalysisGeneralStatsPreferences copyWith({
    List<JobAnalysisGeneralStatKey>? orderedKeys,
    Set<JobAnalysisGeneralStatKey>? hiddenKeys,
  }) {
    return JobAnalysisGeneralStatsPreferences(
      orderedKeys: orderedKeys ?? this.orderedKeys,
      hiddenKeys: hiddenKeys ?? this.hiddenKeys,
    );
  }

  JobAnalysisGeneralStatsPreferences normalized() {
    final seen = <JobAnalysisGeneralStatKey>{};
    final normalizedOrder = <JobAnalysisGeneralStatKey>[];

    for (final key in orderedKeys) {
      if (seen.add(key)) {
        normalizedOrder.add(key);
      }
    }
    for (final key in JobAnalysisGeneralStatKey.values) {
      if (seen.add(key)) {
        normalizedOrder.add(key);
      }
    }

    return JobAnalysisGeneralStatsPreferences(
      orderedKeys: normalizedOrder,
      hiddenKeys: hiddenKeys.where(seen.contains).toSet(),
    );
  }

  JobAnalysisGeneralStatsPreferences reorder(int oldIndex, int newIndex) {
    final normalizedPreferences = normalized();
    final adjustedIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    final reordered = [...normalizedPreferences.orderedKeys];
    final item = reordered.removeAt(oldIndex);
    reordered.insert(adjustedIndex, item);

    return normalizedPreferences.copyWith(orderedKeys: reordered);
  }

  JobAnalysisGeneralStatsPreferences setVisibility(
    JobAnalysisGeneralStatKey key,
    bool isVisible,
  ) {
    final updatedHiddenKeys = {...hiddenKeys};
    if (isVisible) {
      updatedHiddenKeys.remove(key);
    } else {
      updatedHiddenKeys.add(key);
    }

    return copyWith(hiddenKeys: updatedHiddenKeys).normalized();
  }

  bool isVisible(JobAnalysisGeneralStatKey key) => !hiddenKeys.contains(key);

  Map<String, dynamic> toJson() {
    final normalizedPreferences = normalized();
    return {
      'orderedKeys': normalizedPreferences.orderedKeys
          .map((key) => key.name)
          .toList(),
      'hiddenKeys': normalizedPreferences.hiddenKeys
          .map((key) => key.name)
          .toList(),
    };
  }

  static List<JobAnalysisGeneralStatKey> _parseKeys(Object? rawValue) {
    if (rawValue is! List) {
      return <JobAnalysisGeneralStatKey>[];
    }

    return [
      for (final entry in rawValue)
        if (entry is String)
          ...switch (_jobAnalysisGeneralStatKeyFromName(entry)) {
            final key? => [key],
            null => const <JobAnalysisGeneralStatKey>[],
          },
    ];
  }
}

class JobAnalysisGeneralStatsPreferencesNotifier
    extends Notifier<JobAnalysisGeneralStatsPreferences> {
  SharedPreferences get _sharedPreferences =>
      ref.read(sharedPreferencesProvider);

  @override
  JobAnalysisGeneralStatsPreferences build() => _restorePreferences();

  Future<void> save(JobAnalysisGeneralStatsPreferences preferences) async {
    final normalized = preferences.normalized();
    final didPersist = await _sharedPreferences.setString(
      _jobAnalysisGeneralStatsPreferenceKey,
      jsonEncode(normalized.toJson()),
    );
    if (!didPersist) {
      throw StateError('Unable to persist the job analysis general stats.');
    }

    state = normalized;
  }

  Future<void> reset() async {
    await save(JobAnalysisGeneralStatsPreferences.defaults());
  }

  JobAnalysisGeneralStatsPreferences _restorePreferences() {
    final persistedValue = _sharedPreferences.getString(
      _jobAnalysisGeneralStatsPreferenceKey,
    );
    if (persistedValue == null || persistedValue.isEmpty) {
      return JobAnalysisGeneralStatsPreferences.defaults();
    }

    try {
      final decodedValue = jsonDecode(persistedValue);
      if (decodedValue is! Map) {
        unawaited(
          _sharedPreferences.remove(_jobAnalysisGeneralStatsPreferenceKey),
        );
        return JobAnalysisGeneralStatsPreferences.defaults();
      }

      return JobAnalysisGeneralStatsPreferences.fromJson(
        Map<String, dynamic>.from(decodedValue),
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Failed to restore the saved general stats preferences: '
        '$error\n$stackTrace',
      );
      unawaited(
        _sharedPreferences.remove(_jobAnalysisGeneralStatsPreferenceKey),
      );
      return JobAnalysisGeneralStatsPreferences.defaults();
    }
  }
}

JobAnalysisGeneralStatKey? _jobAnalysisGeneralStatKeyFromName(String name) {
  for (final key in JobAnalysisGeneralStatKey.values) {
    if (key.name == name) {
      return key;
    }
  }
  return null;
}
