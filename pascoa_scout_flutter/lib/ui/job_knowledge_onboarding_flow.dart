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
  final _controller = TextEditingController();
  bool _isSaving = false;
  String? _validationMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(jobKnowledgeSummaryProvider);
    return summaryAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _OnboardingErrorState(error: error),
      data: (summary) {
        final step = _buildNextStep(summary);
        if (step == null) {
          return const SizedBox.shrink();
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.stepLabel,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        step.title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        step.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.78),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          maxLength: 60000,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            labelText: step.inputLabel,
                            alignLabelWithHint: true,
                            helperText:
                                'Minimum 100 characters. Maximum 60,000 characters.',
                            errorText: _validationMessage,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              step.helper,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.68),
                                  ),
                            ),
                          ),
                          const SizedBox(width: 18),
                          ElevatedButton.icon(
                            onPressed: _isSaving
                                ? null
                                : () => _handleContinue(step),
                            icon: _isSaving
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFF03110D),
                                    ),
                                  )
                                : const Icon(Icons.arrow_forward_rounded),
                            label: Text(_isSaving ? 'Saving…' : 'Continue'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _KnowledgeStep? _buildNextStep(JobKnowledgeSummary summary) {
    if (!summary.hasCurriculum) {
      return _KnowledgeStep(
        stepLabel: 'Step 1 of 3',
        title: 'Curriculum',
        description:
            'Paste a digitalized version of your curriculum in markdown-like plain text. This gives the AI grounded context about your skills, experience, and positioning.',
        inputLabel: 'Curriculum text',
        helper:
            'Focus on skills, years of experience, niche strengths, and proof points.',
        save: (client, text) =>
            client.jobKnowledge.saveCurriculum(markdownText: text),
      );
    }
    if (!summary.hasProposalStylePreference) {
      return _KnowledgeStep(
        stepLabel: 'Step 2 of 3',
        title: 'How you like proposals to be answered',
        description:
            'Describe how you usually write proposals: tone, structure, level of detail, how direct you are, what you avoid, and what you want highlighted.',
        inputLabel: 'Proposal style preference',
        helper:
            'Explain voice, pacing, what strong openings look like, and what should never appear.',
        save: (client, text) =>
            client.jobKnowledge.saveProposalStylePreference(markdownText: text),
      );
    }
    if (!summary.hasOpportunityPreference) {
      return _KnowledgeStep(
        stepLabel: 'Step 3 of 3',
        title: 'What you consider a good job opportunity',
        description:
            'Describe what makes a job worth your time and connections, plus the red flags that should lower the AI score even when the filter matches.',
        inputLabel: 'Good opportunity preference',
        helper:
            'Include budget expectations, client quality signals, risk flags, and the kinds of projects you want more of.',
        save: (client, text) =>
            client.jobKnowledge.saveOpportunityPreference(markdownText: text),
      );
    }
    return null;
  }

  Future<void> _handleContinue(_KnowledgeStep step) async {
    final text = _controller.text.trim();
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
    });

    try {
      await step.save(ref.read(clientProvider), text);
      _controller.clear();
      ref.invalidate(jobKnowledgeSummaryProvider);
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

class _KnowledgeStep {
  const _KnowledgeStep({
    required this.stepLabel,
    required this.title,
    required this.description,
    required this.inputLabel,
    required this.helper,
    required this.save,
  });

  final String stepLabel;
  final String title;
  final String description;
  final String inputLabel;
  final String helper;
  final Future<Object?> Function(Client client, String text) save;
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
                  onPressed: () => ref.invalidate(jobKnowledgeSummaryProvider),
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
