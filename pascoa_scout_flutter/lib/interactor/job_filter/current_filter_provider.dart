import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';
import 'package:pascoa_scout/interactor/job_filter/current_filter_state.dart';

class CurrentFiltersNotifier extends Notifier<CurrentFiltersState> {
  @override
  CurrentFiltersState build() => CurrentFiltersState.none();

  JobFilter? get currentFilter =>
      state.maybeWhen(withFilter: (jobFilter) => jobFilter, orElse: () => null);

  void saveFilter(JobFilter jobFilter) {
    state = CurrentFiltersState.withFilter(jobFilter: jobFilter);
  }

  void clear() {
    state = CurrentFiltersState.none();
  }
}
