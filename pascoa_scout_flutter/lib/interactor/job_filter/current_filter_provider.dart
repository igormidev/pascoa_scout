import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout/interactor/job_filter/current_filter_state.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _currentFilterPreferenceKey = 'current_job_filter';

class CurrentFiltersNotifier extends Notifier<CurrentFiltersState> {
  SharedPreferences get _sharedPreferences =>
      ref.read(sharedPreferencesProvider);

  @override
  // SharedPreferences is ready before ProviderScope, so hydration can stay
  // synchronous and the filter form never paints an empty state first.
  CurrentFiltersState build() => _restorePersistedFilter();

  JobFilter? get currentFilter =>
      state.maybeWhen(withFilter: (jobFilter) => jobFilter, orElse: () => null);

  Future<void> saveFilter(JobFilter jobFilter) async {
    final didPersist = await _sharedPreferences.setString(
      _currentFilterPreferenceKey,
      jsonEncode(jobFilter.toJson()),
    );
    if (!didPersist) {
      throw StateError('Unable to persist the current job filter.');
    }

    state = CurrentFiltersState.withFilter(jobFilter: jobFilter);
  }

  Future<void> clear() async {
    final didClear = await _sharedPreferences.remove(
      _currentFilterPreferenceKey,
    );
    if (!didClear) {
      throw StateError('Unable to clear the current job filter.');
    }

    state = CurrentFiltersState.none();
  }

  CurrentFiltersState _restorePersistedFilter() {
    final persistedFilter = _sharedPreferences.getString(
      _currentFilterPreferenceKey,
    );
    if (persistedFilter == null || persistedFilter.isEmpty) {
      return CurrentFiltersState.none();
    }

    try {
      final decodedFilter = jsonDecode(persistedFilter);
      if (decodedFilter is! Map) {
        unawaited(_sharedPreferences.remove(_currentFilterPreferenceKey));
        return CurrentFiltersState.none();
      }

      final jobFilter = JobFilter.fromJson(
        Map<String, dynamic>.from(decodedFilter),
      );
      if (jobFilter.searchQueryTerm.trim().isEmpty) {
        unawaited(_sharedPreferences.remove(_currentFilterPreferenceKey));
        return CurrentFiltersState.none();
      }

      return CurrentFiltersState.withFilter(jobFilter: jobFilter);
    } catch (error, stackTrace) {
      debugPrint(
        'Failed to restore the saved job filter from preferences: '
        '$error\n$stackTrace',
      );
      unawaited(_sharedPreferences.remove(_currentFilterPreferenceKey));
      return CurrentFiltersState.none();
    }
  }
}
