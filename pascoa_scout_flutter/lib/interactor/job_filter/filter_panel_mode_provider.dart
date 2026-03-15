import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/interactor/job_filter/job_filter_providers.dart';

class FilterPanelModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    final hasSavedFilter =
        ref.read(currentFilterNotifier.notifier).currentFilter != null;

    return !hasSavedFilter;
  }

  void showEditor() {
    state = true;
  }

  void showSummary() {
    state = false;
  }
}

final filterPanelModeProvider = NotifierProvider<FilterPanelModeNotifier, bool>(
  FilterPanelModeNotifier.new,
);
