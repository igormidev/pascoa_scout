import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';

class JobListageManualFetchDialog extends ConsumerStatefulWidget {
  const JobListageManualFetchDialog({super.key});

  @override
  ConsumerState<JobListageManualFetchDialog> createState() =>
      _JobListageManualFetchDialogState();
}

class _JobListageManualFetchDialogState
    extends ConsumerState<JobListageManualFetchDialog> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  bool _isSubmitting = false;
  String? _submissionError;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return PopScope(
      canPop: !_isSubmitting,
      child: AlertDialog(
        title: Text(l10n.jobListManualFetchDialogTitle),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.jobListManualFetchDialogDescription,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _urlController,
                  enabled: !_isSubmitting,
                  autofocus: true,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    labelText: l10n.jobListManualFetchFieldLabel,
                    hintText: l10n.jobListManualFetchFieldHint,
                  ),
                  validator: (value) => _validateRawUrl(value, l10n),
                  onFieldSubmitted: (_) => _submit(),
                ),
                if (_submissionError != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _submissionError!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onErrorContainer,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
            child: Text(l10n.jobListManualFetchCancelButton),
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
                      Text(l10n.jobListManualFetchSubmittingButton),
                    ],
                  )
                : Text(l10n.jobListManualFetchSubmitButton),
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

    setState(() {
      _isSubmitting = true;
      _submissionError = null;
    });

    try {
      final analysis = await ref
          .read(clientProvider)
          .jobAnalysis
          .manualFetch(rawUrl: _urlController.text.trim());
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(analysis);
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

String? _validateRawUrl(String? value, AppLocalizations l10n) {
  final normalizedValue = value?.trim() ?? '';
  if (normalizedValue.isEmpty) {
    return l10n.jobListManualFetchValidationRequired;
  }

  final uri = Uri.tryParse(normalizedValue);
  if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
    return l10n.jobListManualFetchValidationInvalid;
  }

  final normalizedHost = uri.host.toLowerCase();
  final isUpworkHost =
      normalizedHost == 'upwork.com' || normalizedHost.endsWith('.upwork.com');
  final isHttp = uri.scheme == 'https' || uri.scheme == 'http';
  final hasJobsSearchPath = uri.path.toLowerCase().contains('/nx/search/jobs');
  if (!isHttp || !isUpworkHost || !hasJobsSearchPath) {
    return l10n.jobListManualFetchValidationInvalid;
  }

  return null;
}
