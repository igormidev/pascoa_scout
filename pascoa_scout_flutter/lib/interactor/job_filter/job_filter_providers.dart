import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/interactor/job_filter/current_filter_provider.dart';
import 'package:pascoa_scout/interactor/job_filter/current_filter_state.dart';

final currentFilterNotifier =
    NotifierProvider<CurrentFiltersNotifier, CurrentFiltersState>(
      () => CurrentFiltersNotifier(),
    );
