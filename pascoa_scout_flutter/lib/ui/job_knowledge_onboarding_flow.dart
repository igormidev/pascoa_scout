import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout/interactor/job_knowledge/job_knowledge_providers.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

class JobKnowledgeOnboardingFlow extends ConsumerStatefulWidget {
  const JobKnowledgeOnboardingFlow({super.key});

  @override
  ConsumerState<JobKnowledgeOnboardingFlow> createState() =>
      _JobKnowledgeOnboardingFlowState();
}

class _JobKnowledgeOnboardingFlowState
    extends ConsumerState<JobKnowledgeOnboardingFlow> {
  final Map<_KnowledgeStepId, String> _draftTexts = {};
  bool _isSaving = false;
  String? _validationMessage;
  _KnowledgeStepId? _selectedStepId;
  double _editorFontSize = 18;

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(jobKnowledgeSummaryProvider);
    final draftAsync = ref.watch(jobKnowledgeDraftProvider);

    if (summaryAsync.isLoading || draftAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (summaryAsync.hasError) {
      return _OnboardingErrorState(error: summaryAsync.error!);
    }
    if (draftAsync.hasError) {
      return _OnboardingErrorState(error: draftAsync.error!);
    }

    final summary = summaryAsync.requireValue;
    final draft = draftAsync.requireValue;
    final steps = _buildSteps(summary, draft);
    if (steps.isEmpty) {
      return const SizedBox.shrink();
    }

    final selectedStepId =
        _selectedStepId ?? _firstIncompleteStepId(steps) ?? steps.first.id;
    final currentIndex = steps.indexWhere((step) => step.id == selectedStepId);
    final currentStep = steps[currentIndex == -1 ? 0 : currentIndex];
    final currentStepIndex = steps.indexOf(currentStep);
    final currentText = _draftTexts[currentStep.id] ?? currentStep.initialText;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          currentStep.stepLabel,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.86),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      _FontSizeControl(
                        fontSize: _editorFontSize,
                        onDecrease: _isSaving
                            ? null
                            : () => _changeFontSize(-1),
                        onIncrease: _isSaving ? null : () => _changeFontSize(1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (final step in steps)
                        _OnboardingStepChip(
                          title: step.navTitle,
                          isSelected: step.id == currentStep.id,
                          isCompleted: step.isCompleted,
                          onTap: _isSaving
                              ? null
                              : () => setState(() {
                                  _selectedStepId = step.id;
                                  _validationMessage = null;
                                }),
                        ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Text(
                    currentStep.title,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 860),
                    child: Text(
                      currentStep.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.78),
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: currentStep.isCompleted
                              ? colorScheme.primary.withValues(alpha: 0.28)
                              : Colors.white.withValues(alpha: 0.08),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.18),
                            blurRadius: 28,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: TextFormField(
                          key: ValueKey(currentStep.id),
                          initialValue: currentText,
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          maxLength: 60000,
                          textAlignVertical: TextAlignVertical.top,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: _editorFontSize,
                            height: 1.55,
                            letterSpacing: 0.1,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _draftTexts[currentStep.id] = value;
                              _validationMessage = null;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: currentStep.inputLabel,
                            alignLabelWithHint: true,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            helperText:
                                'Minimum 100 characters. Maximum 60,000 characters.',
                            errorText: _validationMessage,
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            counterStyle: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.72),
                              fontWeight: FontWeight.w700,
                            ),
                            helperStyle: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.56),
                            ),
                            errorStyle: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.error,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.035),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            currentStep.helper,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.68),
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        OutlinedButton.icon(
                          onPressed: _isSaving || currentStepIndex == 0
                              ? null
                              : () => setState(() {
                                  _selectedStepId =
                                      steps[currentStepIndex - 1].id;
                                  _validationMessage = null;
                                }),
                          icon: const Icon(Icons.arrow_back_rounded),
                          label: const Text('Back'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: _isSaving
                              ? null
                              : () => _handleContinue(
                                  step: currentStep,
                                  steps: steps,
                                ),
                          icon: _isSaving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF03110D),
                                  ),
                                )
                              : Icon(
                                  currentStepIndex == steps.length - 1
                                      ? Icons.check_rounded
                                      : Icons.arrow_forward_rounded,
                                ),
                          label: Text(
                            _isSaving
                                ? 'Saving…'
                                : currentStepIndex == steps.length - 1
                                ? 'Save & finish'
                                : 'Save & continue',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<_KnowledgeStep> _buildSteps(
    JobKnowledgeSummary summary,
    JobKnowledgeDraft draft,
  ) {
    return [
      _KnowledgeStep(
        id: _KnowledgeStepId.curriculum,
        stepLabel: 'Step 1 of 3',
        navTitle: 'Curriculum',
        title: 'Curriculum',
        description:
            'Paste a digitalized version of your curriculum in markdown-like plain text. This gives the AI grounded context about your skills, experience, and positioning.',
        inputLabel: 'Curriculum text',
        helper:
            'Focus on skills, years of experience, niche strengths, and proof points.',
        initialText: draft.curriculumMarkdownText ?? '',
        isCompleted: summary.hasCurriculum,
        save: (client, text) =>
            client.jobKnowledge.saveCurriculum(markdownText: text),
      ),
      _KnowledgeStep(
        id: _KnowledgeStepId.proposalStyle,
        stepLabel: 'Step 2 of 3',
        navTitle: 'Proposal style',
        title: 'How you like proposals to be answered',
        description:
            'Describe how you usually write proposals: tone, structure, level of detail, how direct you are, what you avoid, and what you want highlighted.',
        inputLabel: 'Proposal style preference',
        helper:
            'Explain voice, pacing, what strong openings look like, and what should never appear.',
        initialText: draft.proposalStyleMarkdownText ?? '',
        isCompleted: summary.hasProposalStylePreference,
        save: (client, text) =>
            client.jobKnowledge.saveProposalStylePreference(markdownText: text),
      ),
      _KnowledgeStep(
        id: _KnowledgeStepId.opportunityPreference,
        stepLabel: 'Step 3 of 3',
        navTitle: 'Opportunity filter',
        title: 'What you consider a good job opportunity',
        description:
            'Describe what makes a job worth your time and connections, plus the red flags that should lower the AI score even when the filter matches.',
        inputLabel: 'Good opportunity preference',
        helper:
            'Include budget expectations, client quality signals, risk flags, and the kinds of projects you want more of.',
        initialText: draft.opportunityPreferenceMarkdownText ?? '',
        isCompleted: summary.hasOpportunityPreference,
        save: (client, text) =>
            client.jobKnowledge.saveOpportunityPreference(markdownText: text),
      ),
    ];
  }

  _KnowledgeStepId? _firstIncompleteStepId(List<_KnowledgeStep> steps) {
    for (final step in steps) {
      if (!step.isCompleted) {
        return step.id;
      }
    }
    return steps.isEmpty ? null : steps.last.id;
  }

  void _changeFontSize(double delta) {
    setState(() {
      _editorFontSize = (_editorFontSize + delta).clamp(15.0, 24.0);
    });
  }

  Future<void> _handleContinue({
    required _KnowledgeStep step,
    required List<_KnowledgeStep> steps,
  }) async {
    final text = (_draftTexts[step.id] ?? step.initialText).trim();
    final validationMessage = _validateText(text);
    if (validationMessage != null) {
      setState(() {
        _validationMessage = validationMessage;
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _validationMessage = null;
      _draftTexts[step.id] = text;
    });

    try {
      await step.save(ref.read(clientProvider), text);
      ref.invalidate(jobKnowledgeSummaryProvider);
      ref.invalidate(jobKnowledgeDraftProvider);

      final currentIndex = steps.indexWhere(
        (candidate) => candidate.id == step.id,
      );
      if (mounted && currentIndex >= 0 && currentIndex < steps.length - 1) {
        setState(() {
          _selectedStepId = steps[currentIndex + 1].id;
        });
      }
    } catch (error) {
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

  String? _validateText(String text) {
    if (text.length < 100) {
      return 'Please add at least 100 characters before continuing.';
    }
    if (text.length > 60000) {
      return 'Please keep the text under 60,000 characters.';
    }
    return null;
  }
}

enum _KnowledgeStepId { curriculum, proposalStyle, opportunityPreference }

class _KnowledgeStep {
  const _KnowledgeStep({
    required this.id,
    required this.stepLabel,
    required this.navTitle,
    required this.title,
    required this.description,
    required this.inputLabel,
    required this.helper,
    required this.initialText,
    required this.isCompleted,
    required this.save,
  });

  final _KnowledgeStepId id;
  final String stepLabel;
  final String navTitle;
  final String title;
  final String description;
  final String inputLabel;
  final String helper;
  final String initialText;
  final bool isCompleted;
  final Future<Object?> Function(Client client, String text) save;
}

class _OnboardingStepChip extends StatelessWidget {
  const _OnboardingStepChip({
    required this.title,
    required this.isSelected,
    required this.isCompleted,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final bool isCompleted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = isSelected
        ? const Color(0xFF04130E)
        : Colors.white.withValues(alpha: isCompleted ? 0.92 : 0.76);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: isSelected
              ? colorScheme.primary
              : Colors.white.withValues(alpha: isCompleted ? 0.08 : 0.04),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : Colors.white.withValues(alpha: isCompleted ? 0.12 : 0.06),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isCompleted ? Icons.check_rounded : Icons.edit_outlined,
              size: 18,
              color: foregroundColor,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FontSizeControl extends StatelessWidget {
  const _FontSizeControl({
    required this.fontSize,
    required this.onDecrease,
    required this.onIncrease,
  });

  final double fontSize;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrease,
            visualDensity: VisualDensity.compact,
            tooltip: 'Decrease text size',
            icon: const Icon(Icons.remove_rounded),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Text size',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${fontSize.toStringAsFixed(0)} px',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onIncrease,
            visualDensity: VisualDensity.compact,
            tooltip: 'Increase text size',
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}

class _OnboardingErrorState extends ConsumerWidget {
  const _OnboardingErrorState({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 44,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Unable to load the onboarding state',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(jobKnowledgeSummaryProvider);
                    ref.invalidate(jobKnowledgeDraftProvider);
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
