import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/interactor/job_filter/current_filter_state.dart';

class CurrentFiltersNotifier extends Notifier<CurrentFiltersState> {
  @override
  CurrentFiltersState build() => CurrentFiltersState.none();
}
