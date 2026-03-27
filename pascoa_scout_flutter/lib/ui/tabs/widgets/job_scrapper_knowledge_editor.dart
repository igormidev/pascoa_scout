part of '../job_scrapper_config_tab.dart';

enum _JobKnowledgeEditorKind { curriculum, answerStyle, scoreLogic }

class _JobKnowledgeQuickActionsRow extends StatelessWidget {
  const _JobKnowledgeQuickActionsRow({
    required this.onChangeCurriculum,
    required this.onChangeProposalWriting,
    required this.onChangeJobScoreLogic,
  });

  final Future<void> Function() onChangeCurriculum;
  final Future<void> Function() onChangeProposalWriting;
  final Future<void> Function() onChangeJobScoreLogic;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => unawaited(onChangeCurriculum()),
            child: Text(
              l10n.jobKnowledgeQuickActionsEditCurriculumButton,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: OutlinedButton(
            onPressed: () => unawaited(onChangeProposalWriting()),
            child: Text(
              l10n.jobKnowledgeQuickActionsEditAnswerStyleButton,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: OutlinedButton(
            onPressed: () => unawaited(onChangeJobScoreLogic()),
            child: Text(
              l10n.jobKnowledgeQuickActionsEditScoreLogicButton,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _JobKnowledgeEditorDialog extends ConsumerStatefulWidget {
  const _JobKnowledgeEditorDialog({required this.kind});

  final _JobKnowledgeEditorKind kind;

  @override
  ConsumerState<_JobKnowledgeEditorDialog> createState() =>
      _JobKnowledgeEditorDialogState();
}

class _JobKnowledgeEditorDialogState
    extends ConsumerState<_JobKnowledgeEditorDialog> {
  static const int _minimumLength = 100;
  static const int _maximumLength = 60000;

  final TextEditingController _controller = TextEditingController();

  bool _isLoading = true;
  bool _isSaving = false;
  String? _loadErrorMessage;
  String? _validationMessage;

  @override
  void initState() {
    super.initState();
    unawaited(_loadDraft());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 860.0),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_dialogTitle(l10n), style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8.0),
              Text(
                _dialogDescription(l10n),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.74),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18.0),
              SizedBox(
                height: 420.0,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: _isLoading
                      ? const Center(
                          key: ValueKey('job-knowledge-editor-loading'),
                          child: CircularProgressIndicator(),
                        )
                      : _loadErrorMessage != null
                      ? _JobKnowledgeEditorLoadErrorState(
                          key: const ValueKey('job-knowledge-editor-error'),
                          title: l10n.jobKnowledgeEditorLoadFailedTitle,
                          message: _loadErrorMessage!,
                          retryLabel: l10n.jobKnowledgeEditorRetryButton,
                          onRetry: _loadDraft,
                        )
                      : DecoratedBox(
                          key: const ValueKey('job-knowledge-editor-form'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: theme.colorScheme.outline.withValues(
                                alpha: 0.18,
                              ),
                            ),
                            color: theme.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              controller: _controller,
                              expands: true,
                              maxLines: null,
                              minLines: null,
                              maxLength: _maximumLength,
                              textAlignVertical: TextAlignVertical.top,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                height: 1.5,
                              ),
                              onChanged: (_) {
                                if (_validationMessage == null) {
                                  return;
                                }

                                setState(() {
                                  _validationMessage = null;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: _inputLabel(l10n),
                                alignLabelWithHint: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                counterStyle: theme.textTheme.bodySmall
                                    ?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.62),
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              if (!_isLoading && _loadErrorMessage == null) ...[
                const SizedBox(height: 14.0),
                Text(
                  l10n.jobKnowledgeEditorCharacterHint(
                    _minimumLength,
                    _maximumLength,
                  ),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.66),
                  ),
                ),
                if (_validationMessage != null) ...[
                  const SizedBox(height: 12.0),
                  Text(
                    _validationMessage!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
              const SizedBox(height: 18.0),
              LayoutBuilder(
                builder: (context, constraints) {
                  final useColumn = constraints.maxWidth < 560.0;
                  final cancelButton = TextButton(
                    onPressed: _isSaving
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(l10n.jobKnowledgeEditorCancelButton),
                  );
                  final saveButton = FilledButton.icon(
                    onPressed:
                        _isLoading || _loadErrorMessage != null || _isSaving
                        ? null
                        : () => unawaited(_save(l10n)),
                    icon: _isSaving
                        ? const SizedBox(
                            width: 18.0,
                            height: 18.0,
                            child: CircularProgressIndicator(strokeWidth: 2.0),
                          )
                        : const Icon(Icons.save_rounded),
                    label: Text(
                      _isSaving
                          ? l10n.jobKnowledgeEditorSavingButton
                          : l10n.jobKnowledgeEditorSaveButton,
                    ),
                  );

                  if (useColumn) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        saveButton,
                        const SizedBox(height: 10.0),
                        cancelButton,
                      ],
                    );
                  }

                  return Row(
                    children: [
                      const Spacer(),
                      cancelButton,
                      const SizedBox(width: 8.0),
                      saveButton,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadDraft() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _loadErrorMessage = null;
        _validationMessage = null;
      });
    }

    try {
      final draft = await ref.read(jobKnowledgeDraftProvider.future);
      final initialText = _draftText(draft);

      if (!mounted) {
        return;
      }

      _controller.value = TextEditingValue(
        text: initialText,
        selection: TextSelection.collapsed(offset: initialText.length),
      );

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _loadErrorMessage = error.toString();
      });
    }
  }

  Future<void> _save(AppLocalizations l10n) async {
    final text = _controller.text.trim();
    final validationMessage = _validateText(text, l10n);
    if (validationMessage != null) {
      setState(() {
        _validationMessage = validationMessage;
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _validationMessage = null;
    });

    try {
      await _persistText(ref.read(clientProvider), text);
      ref.invalidate(jobKnowledgeDraftProvider);
      ref.invalidate(jobKnowledgeSummaryProvider);
      ref
          .read(appNotificationControllerProvider.notifier)
          .notifySnackbar(message: _savedMessage(l10n));

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _validationMessage = error.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  String? _validateText(String text, AppLocalizations l10n) {
    if (text.length < _minimumLength) {
      return l10n.jobKnowledgeEditorValidationMin(_minimumLength);
    }
    if (text.length > _maximumLength) {
      return l10n.jobKnowledgeEditorValidationMax(_maximumLength);
    }
    return null;
  }

  String _dialogTitle(AppLocalizations l10n) {
    return switch (widget.kind) {
      _JobKnowledgeEditorKind.curriculum =>
        l10n.jobKnowledgeEditorCurriculumTitle,
      _JobKnowledgeEditorKind.answerStyle =>
        l10n.jobKnowledgeEditorAnswerStyleTitle,
      _JobKnowledgeEditorKind.scoreLogic =>
        l10n.jobKnowledgeEditorScoreLogicTitle,
    };
  }

  String _dialogDescription(AppLocalizations l10n) {
    return switch (widget.kind) {
      _JobKnowledgeEditorKind.curriculum =>
        l10n.jobKnowledgeEditorCurriculumDescription,
      _JobKnowledgeEditorKind.answerStyle =>
        l10n.jobKnowledgeEditorAnswerStyleDescription,
      _JobKnowledgeEditorKind.scoreLogic =>
        l10n.jobKnowledgeEditorScoreLogicDescription,
    };
  }

  String _inputLabel(AppLocalizations l10n) {
    return switch (widget.kind) {
      _JobKnowledgeEditorKind.curriculum =>
        l10n.jobKnowledgeEditorCurriculumInputLabel,
      _JobKnowledgeEditorKind.answerStyle =>
        l10n.jobKnowledgeEditorAnswerStyleInputLabel,
      _JobKnowledgeEditorKind.scoreLogic =>
        l10n.jobKnowledgeEditorScoreLogicInputLabel,
    };
  }

  String _savedMessage(AppLocalizations l10n) {
    return switch (widget.kind) {
      _JobKnowledgeEditorKind.curriculum =>
        l10n.jobKnowledgeEditorCurriculumSaved,
      _JobKnowledgeEditorKind.answerStyle =>
        l10n.jobKnowledgeEditorAnswerStyleSaved,
      _JobKnowledgeEditorKind.scoreLogic =>
        l10n.jobKnowledgeEditorScoreLogicSaved,
    };
  }

  String _draftText(JobKnowledgeDraft draft) {
    return switch (widget.kind) {
      _JobKnowledgeEditorKind.curriculum => draft.curriculumMarkdownText ?? '',
      _JobKnowledgeEditorKind.answerStyle =>
        draft.proposalStyleMarkdownText ?? '',
      _JobKnowledgeEditorKind.scoreLogic =>
        draft.opportunityPreferenceMarkdownText ?? '',
    };
  }

  Future<void> _persistText(Client client, String text) {
    return switch (widget.kind) {
      _JobKnowledgeEditorKind.curriculum => client.jobKnowledge.saveCurriculum(
        markdownText: text,
      ),
      _JobKnowledgeEditorKind.answerStyle =>
        client.jobKnowledge.saveProposalStylePreference(markdownText: text),
      _JobKnowledgeEditorKind.scoreLogic =>
        client.jobKnowledge.saveOpportunityPreference(markdownText: text),
    };
  }
}

class _JobKnowledgeEditorLoadErrorState extends StatelessWidget {
  const _JobKnowledgeEditorLoadErrorState({
    super.key,
    required this.title,
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  final String title;
  final String message;
  final String retryLabel;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.0),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.18),
            ),
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.14,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 34.0,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 12.0),
                Text(
                  title,
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.74),
                    height: 1.45,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                FilledButton.icon(
                  onPressed: () => unawaited(onRetry()),
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(retryLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
