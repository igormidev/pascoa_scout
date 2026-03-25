part of '../job_listage_tab.dart';

class _FiltersDialog extends StatefulWidget {
  const _FiltersDialog({required this.initialFilters});

  final _LocalJobAnalysisFilters initialFilters;

  @override
  State<_FiltersDialog> createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<_FiltersDialog> {
  late _LocalJobAnalysisFilters _draft = widget.initialFilters;

  @override
  Widget build(BuildContext context) {
    final isDirty = _draft != widget.initialFilters;

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filters',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<JobAnalysisFilterMode>(
                initialValue: _draft.analysisFilter,
                decoration: const InputDecoration(labelText: 'Analysis state'),
                items: JobAnalysisFilterMode.values
                    .map(
                      (mode) => DropdownMenuItem(
                        value: mode,
                        child: Text(_analysisFilterLabel(mode)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _draft = _draft.copyWith(analysisFilter: value);
                  });
                },
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<bool?>(
                initialValue: _draft.hasQuestions,
                decoration: const InputDecoration(labelText: 'Has questions'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('Any')),
                  DropdownMenuItem(value: true, child: Text('Yes')),
                  DropdownMenuItem(value: false, child: Text('No')),
                ],
                onChanged: (value) {
                  setState(() {
                    _draft = _draft.copyWith(
                      hasQuestions: value,
                      clearHasQuestions: value == null,
                    );
                  });
                },
              ),
              const SizedBox(height: 14),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Use score range'),
                value: _draft.useScoreRange,
                onChanged: (value) {
                  setState(() {
                    _draft = _draft.copyWith(useScoreRange: value);
                  });
                },
              ),
              if (_draft.useScoreRange)
                RangeSlider(
                  min: 0,
                  max: 100,
                  divisions: 20,
                  values: RangeValues(
                    _draft.minimumScorePercentage.toDouble(),
                    _draft.maximumScorePercentage.toDouble(),
                  ),
                  labels: RangeLabels(
                    '${_draft.minimumScorePercentage}%',
                    '${_draft.maximumScorePercentage}%',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _draft = _draft.copyWith(
                        minimumScorePercentage: value.start.round(),
                        maximumScorePercentage: value.end.round(),
                      );
                    });
                  },
                ),
              const SizedBox(height: 14),
              _AgeSlider(
                label: 'Max age for job persistence',
                value: _draft.maxAgeJobInfoHours,
                onChanged: (value) {
                  setState(() {
                    _draft = _draft.copyWith(
                      maxAgeJobInfoHours: value,
                      clearMaxAgeJobInfoHours: value == null,
                    );
                  });
                },
              ),
              _AgeSlider(
                label: 'Max age for scoring timestamp',
                value: _draft.maxAgeScoringHours,
                onChanged: (value) {
                  setState(() {
                    _draft = _draft.copyWith(
                      maxAgeScoringHours: value,
                      clearMaxAgeScoringHours: value == null,
                    );
                  });
                },
              ),
              _AgeSlider(
                label: 'Max age for AI responses timestamp',
                value: _draft.maxAgeAiResponsesHours,
                onChanged: (value) {
                  setState(() {
                    _draft = _draft.copyWith(
                      maxAgeAiResponsesHours: value,
                      clearMaxAgeAiResponsesHours: value == null,
                    );
                  });
                },
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  TextButton(
                    onPressed: () => setState(() {
                      _draft = const _LocalJobAnalysisFilters();
                    }),
                    child: const Text('Reset'),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  if (isDirty)
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(_draft),
                      child: const Text('Save filters'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgeSlider extends StatelessWidget {
  const _AgeSlider({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(label),
          subtitle: Text(value == null ? 'Disabled' : '$value hour(s)'),
          value: value != null,
          onChanged: (enabled) => onChanged(enabled ? (value ?? 24) : null),
        ),
        if (value != null)
          Slider(
            min: 1,
            max: 168,
            divisions: 167,
            value: value!.toDouble(),
            label: '$value h',
            onChanged: (nextValue) => onChanged(nextValue.round()),
          ),
      ],
    );
  }
}
