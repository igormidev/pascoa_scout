import 'package:flutter/material.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_general_stats_preferences.dart';

class JobAnalysisGeneralStatOption {
  const JobAnalysisGeneralStatOption({
    required this.key,
    required this.label,
    required this.icon,
  });

  final JobAnalysisGeneralStatKey key;
  final String label;
  final IconData icon;
}

class JobAnalysisGeneralStatsEditorDialog extends StatefulWidget {
  const JobAnalysisGeneralStatsEditorDialog({
    super.key,
    required this.initialPreferences,
    required this.options,
  });

  final JobAnalysisGeneralStatsPreferences initialPreferences;
  final List<JobAnalysisGeneralStatOption> options;

  @override
  State<JobAnalysisGeneralStatsEditorDialog> createState() =>
      _JobAnalysisGeneralStatsEditorDialogState();
}

class _JobAnalysisGeneralStatsEditorDialogState
    extends State<JobAnalysisGeneralStatsEditorDialog> {
  late JobAnalysisGeneralStatsPreferences _draft = widget.initialPreferences
      .normalized();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final orderedOptions = _orderedOptions;

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.jobAnalysisGeneralStatsEditorTitle,
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.jobAnalysisGeneralStatsEditorDescription,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.74),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 420,
                child: ReorderableListView.builder(
                  buildDefaultDragHandles: false,
                  itemCount: orderedOptions.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      _draft = _draft.reorder(oldIndex, newIndex);
                    });
                  },
                  itemBuilder: (context, index) {
                    final option = orderedOptions[index];

                    return DecoratedBox(
                      key: ValueKey(option.key),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(
                            alpha: 0.18,
                          ),
                        ),
                        color: theme.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.18),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 2,
                        ),
                        leading: Icon(option.icon, size: 18),
                        title: Text(
                          option.label,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: _draft.isVisible(option.key),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }

                                setState(() {
                                  _draft = _draft.setVisibility(
                                    option.key,
                                    value,
                                  );
                                });
                              },
                            ),
                            ReorderableDragStartListener(
                              index: index,
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(Icons.drag_handle_rounded),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _draft = _draft.setVisibility(
                              option.key,
                              !_draft.isVisible(option.key),
                            );
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _draft = JobAnalysisGeneralStatsPreferences.defaults();
                      });
                    },
                    child: Text(l10n.jobAnalysisGeneralStatsEditorResetButton),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.jobAnalysisGeneralStatsEditorCancelButton),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop(_draft.normalized());
                    },
                    child: Text(l10n.jobAnalysisGeneralStatsEditorSaveButton),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<JobAnalysisGeneralStatOption> get _orderedOptions {
    final optionsByKey = {
      for (final option in widget.options) option.key: option,
    };
    final orderedOptions = <JobAnalysisGeneralStatOption>[];

    for (final key in _draft.normalized().orderedKeys) {
      final option = optionsByKey[key];
      if (option != null) {
        orderedOptions.add(option);
      }
    }

    return orderedOptions;
  }
}
