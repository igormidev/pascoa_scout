import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout/interactor/app_notification/app_notification_providers.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_proposal_milestones_section.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

class JobListageManualProposalDialog extends ConsumerStatefulWidget {
  const JobListageManualProposalDialog({super.key});

  @override
  ConsumerState<JobListageManualProposalDialog> createState() =>
      _JobListageManualProposalDialogState();
}

class _JobListageManualProposalDialogState
    extends ConsumerState<JobListageManualProposalDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  ManualJobProposalPriceKind _priceKind = ManualJobProposalPriceKind.fixed;
  bool _isSubmitting = false;
  String? _submissionError;
  ManualJobProposalResult? _result;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final result = _result;

    return PopScope(
      canPop: !_isSubmitting,
      child: AlertDialog(
        title: Text(l10n.jobManualProposalDialogTitle),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.jobManualProposalDialogDescription,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.72,
                      ),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    enabled: !_isSubmitting,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: l10n.jobManualProposalTitleLabel,
                    ),
                    validator: (value) => _validateRequiredText(
                      value,
                      l10n.jobManualProposalTitleRequired,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _descriptionController,
                    enabled: !_isSubmitting,
                    minLines: 5,
                    maxLines: 10,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      labelText: l10n.jobManualProposalDescriptionLabel,
                      alignLabelWithHint: true,
                    ),
                    validator: (value) => _validateRequiredText(
                      value,
                      l10n.jobManualProposalDescriptionRequired,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _ManualProposalPriceFields(
                    priceController: _priceController,
                    priceKind: _priceKind,
                    isSubmitting: _isSubmitting,
                    onPriceKindChanged: (priceKind) {
                      setState(() {
                        _priceKind = priceKind;
                      });
                    },
                    onSubmit: _submit,
                  ),
                  if (_submissionError != null) ...[
                    const SizedBox(height: 14),
                    _ManualProposalErrorCard(message: _submissionError!),
                  ],
                  if (result != null) ...[
                    const SizedBox(height: 22),
                    _ManualProposalResultView(result: result),
                  ],
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
            child: Text(l10n.jobManualProposalCloseButton),
          ),
          FilledButton(
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2.2),
                      ),
                      const SizedBox(width: 10),
                      Text(l10n.jobManualProposalGeneratingButton),
                    ],
                  )
                : Text(
                    result == null
                        ? l10n.jobManualProposalGenerateButton
                        : l10n.jobManualProposalRegenerateButton,
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_isSubmitting) {
      return;
    }

    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    final price = _parseManualProposalPrice(_priceController.text);
    if (price == null) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _submissionError = null;
    });

    try {
      final result = await ref
          .read(clientProvider)
          .jobAnalysis
          .generateManualProposal(
            request: ManualJobProposalRequest(
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              price: price,
              priceKind: _priceKind,
            ),
          );
      if (!mounted) {
        return;
      }
      setState(() {
        _result = result;
        _isSubmitting = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _submissionError = error.toString();
        _isSubmitting = false;
      });
    }
  }
}

class _ManualProposalPriceFields extends StatelessWidget {
  const _ManualProposalPriceFields({
    required this.priceController,
    required this.priceKind,
    required this.isSubmitting,
    required this.onPriceKindChanged,
    required this.onSubmit,
  });

  final TextEditingController priceController;
  final ManualJobProposalPriceKind priceKind;
  final bool isSubmitting;
  final ValueChanged<ManualJobProposalPriceKind> onPriceKindChanged;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<ManualJobProposalPriceKind>(
          segments: [
            ButtonSegment(
              value: ManualJobProposalPriceKind.fixed,
              icon: const Icon(Icons.payments_outlined),
              label: Text(l10n.jobManualProposalFixedPriceOption),
            ),
            ButtonSegment(
              value: ManualJobProposalPriceKind.hourly,
              icon: const Icon(Icons.schedule_rounded),
              label: Text(l10n.jobManualProposalHourlyOption),
            ),
          ],
          selected: {priceKind},
          onSelectionChanged: isSubmitting
              ? null
              : (selection) => onPriceKindChanged(selection.single),
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: priceController,
          enabled: !isSubmitting,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: l10n.jobManualProposalPriceLabel,
            prefixText: r'$ ',
          ),
          validator: (value) => _validateManualProposalPrice(value, l10n),
          onFieldSubmitted: (_) => onSubmit(),
        ),
      ],
    );
  }
}

class _ManualProposalResultView extends StatelessWidget {
  const _ManualProposalResultView({required this.result});

  final ManualJobProposalResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final milestones =
        result.milestones ?? const <ManualJobProposalMilestone>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ManualProposalCopySection(
          title: l10n.jobManualProposalCoverLetterTitle,
          text: result.aiGeneratedCoverLetterText,
          tooltip: l10n.jobAnalysisCopyCoverLetterTooltip,
          copiedMessage: l10n.jobAnalysisCoverLetterCopied,
        ),
        if (milestones.isNotEmpty) ...[
          const SizedBox(height: 22),
          JobAnalysisProposalMilestonesSection(
            milestones: milestones
                .map(
                  JobAnalysisProposalMilestoneData
                      .fromManualJobProposalMilestone,
                )
                .toList(growable: false),
          ),
        ],
      ],
    );
  }
}

class _ManualProposalCopySection extends StatelessWidget {
  const _ManualProposalCopySection({
    required this.title,
    required this.text,
    required this.tooltip,
    required this.copiedMessage,
  });

  final String title;
  final String text;
  final String tooltip;
  final String copiedMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            IconButton(
              tooltip: tooltip,
              onPressed: () =>
                  _copyManualProposalText(context, text, copiedMessage),
              icon: const Icon(Icons.content_copy_rounded),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SelectableText(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.5,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.82),
          ),
        ),
      ],
    );
  }
}

class _ManualProposalErrorCard extends StatelessWidget {
  const _ManualProposalErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        message,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onErrorContainer,
          height: 1.4,
        ),
      ),
    );
  }
}

String? _validateRequiredText(String? value, String errorMessage) {
  if ((value ?? '').trim().isEmpty) {
    return errorMessage;
  }

  return null;
}

String? _validateManualProposalPrice(String? value, AppLocalizations l10n) {
  final price = _parseManualProposalPrice(value);
  if (price == null) {
    return l10n.jobManualProposalPriceRequired;
  }

  if (price <= 0) {
    return l10n.jobManualProposalPricePositive;
  }

  return null;
}

double? _parseManualProposalPrice(String? value) {
  final normalizedValue = (value ?? '').trim().replaceAll(',', '');
  if (normalizedValue.isEmpty) {
    return null;
  }

  return double.tryParse(normalizedValue);
}

Future<void> _copyManualProposalText(
  BuildContext context,
  String text,
  String copiedMessage,
) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (!context.mounted) {
    return;
  }

  notifySnackbarWithContext(context, message: copiedMessage);
}
