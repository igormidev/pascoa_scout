import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

final selectedJobAnalysisProvider =
    NotifierProvider<SelectedJobAnalysisNotifier, JobAnalysisState?>(
      SelectedJobAnalysisNotifier.new,
    );

class SelectedJobAnalysisNotifier extends Notifier<JobAnalysisState?> {
  @override
  JobAnalysisState? build() => null;

  void clear() {
    state = null;
  }

  void select(JobAnalysisState analysis) {
    state = analysis;
  }

  void syncWithVisibleItems(List<JobAnalysisState> analyses) {
    final selectedAnalysis = state;
    if (selectedAnalysis == null) {
      return;
    }

    for (final analysis in analyses) {
      if (_sameAnalysis(analysis, selectedAnalysis)) {
        state = analysis;
        return;
      }
    }

    state = null;
  }

  void update(JobAnalysisState analysis) {
    final selectedAnalysis = state;
    if (selectedAnalysis == null) {
      return;
    }

    if (_sameAnalysis(analysis, selectedAnalysis)) {
      state = analysis;
    }
  }
}

bool _sameAnalysis(JobAnalysisState left, JobAnalysisState right) {
  final leftId = left.id;
  final rightId = right.id;
  if (leftId != null && rightId != null) {
    return leftId == rightId;
  }

  return left.jobInfoId == right.jobInfoId;
}
