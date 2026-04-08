import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _jobListageLiveRefreshPreferenceKey =
    'job_listage_live_refresh_preferences';
const _jobListageLiveRefreshMinimumSeconds = 10;
const _jobListageLiveRefreshStepSeconds = 10;

final jobListageLiveRefreshPreferencesProvider =
    NotifierProvider<
      JobListageLiveRefreshPreferencesNotifier,
      JobListageLiveRefreshPreferences
    >(JobListageLiveRefreshPreferencesNotifier.new);

class JobListageLiveRefreshPreferences {
  const JobListageLiveRefreshPreferences({
    required this.isEnabled,
    required this.intervalSeconds,
  });

  factory JobListageLiveRefreshPreferences.defaults() {
    return const JobListageLiveRefreshPreferences(
      isEnabled: false,
      intervalSeconds: _jobListageLiveRefreshMinimumSeconds,
    );
  }

  factory JobListageLiveRefreshPreferences.fromJson(Map<String, dynamic> json) {
    return JobListageLiveRefreshPreferences(
      isEnabled: json['isEnabled'] as bool? ?? false,
      intervalSeconds:
          (json['intervalSeconds'] as num?)?.round() ??
          _jobListageLiveRefreshMinimumSeconds,
    ).normalized();
  }

  final bool isEnabled;
  final int intervalSeconds;

  JobListageLiveRefreshPreferences copyWith({
    bool? isEnabled,
    int? intervalSeconds,
  }) {
    return JobListageLiveRefreshPreferences(
      isEnabled: isEnabled ?? this.isEnabled,
      intervalSeconds: intervalSeconds ?? this.intervalSeconds,
    );
  }

  JobListageLiveRefreshPreferences normalized() {
    final clampedSeconds =
        intervalSeconds < _jobListageLiveRefreshMinimumSeconds
        ? _jobListageLiveRefreshMinimumSeconds
        : intervalSeconds;
    final normalizedSeconds =
        ((clampedSeconds + (_jobListageLiveRefreshStepSeconds ~/ 2)) ~/
            _jobListageLiveRefreshStepSeconds) *
        _jobListageLiveRefreshStepSeconds;

    return JobListageLiveRefreshPreferences(
      isEnabled: isEnabled,
      intervalSeconds: normalizedSeconds,
    );
  }

  Map<String, dynamic> toJson() {
    final normalizedPreferences = normalized();
    return {
      'isEnabled': normalizedPreferences.isEnabled,
      'intervalSeconds': normalizedPreferences.intervalSeconds,
    };
  }
}

class JobListageLiveRefreshPreferencesNotifier
    extends Notifier<JobListageLiveRefreshPreferences> {
  SharedPreferences get _sharedPreferences =>
      ref.read(sharedPreferencesProvider);

  @override
  JobListageLiveRefreshPreferences build() => _restorePreferences();

  Future<void> setEnabled(bool isEnabled) async {
    await save(state.copyWith(isEnabled: isEnabled));
  }

  Future<void> setIntervalSeconds(int intervalSeconds) async {
    await save(state.copyWith(intervalSeconds: intervalSeconds));
  }

  Future<void> save(JobListageLiveRefreshPreferences preferences) async {
    final normalized = preferences.normalized();
    final didPersist = await _sharedPreferences.setString(
      _jobListageLiveRefreshPreferenceKey,
      jsonEncode(normalized.toJson()),
    );
    if (!didPersist) {
      throw StateError('Unable to persist the job list live refresh setting.');
    }

    state = normalized;
  }

  JobListageLiveRefreshPreferences _restorePreferences() {
    final persistedValue = _sharedPreferences.getString(
      _jobListageLiveRefreshPreferenceKey,
    );
    if (persistedValue == null || persistedValue.isEmpty) {
      return JobListageLiveRefreshPreferences.defaults();
    }

    try {
      final decodedValue = jsonDecode(persistedValue);
      if (decodedValue is! Map) {
        unawaited(
          _sharedPreferences.remove(_jobListageLiveRefreshPreferenceKey),
        );
        return JobListageLiveRefreshPreferences.defaults();
      }

      return JobListageLiveRefreshPreferences.fromJson(
        Map<String, dynamic>.from(decodedValue),
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Failed to restore the saved job list live refresh preferences: '
        '$error\n$stackTrace',
      );
      unawaited(_sharedPreferences.remove(_jobListageLiveRefreshPreferenceKey));
      return JobListageLiveRefreshPreferences.defaults();
    }
  }
}
