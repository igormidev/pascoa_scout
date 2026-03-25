part of '../job_scrapper_config_tab.dart';

class _JobScrapperConfigEditorView extends StatelessWidget {
  const _JobScrapperConfigEditorView({
    required this.formKey,
    required this.isDesktop,
    required this.isLocked,
    required this.queryController,
    required this.queryValidator,
    required this.showAdvancedFilters,
    required this.advancedSectionsView,
    required this.onDiscard,
    required this.onCopyCurl,
    required this.onSave,
  });

  final GlobalKey<FormState> formKey;
  final bool isDesktop;
  final bool isLocked;
  final TextEditingController queryController;
  final FormFieldValidator<String>? queryValidator;
  final bool showAdvancedFilters;
  final Widget advancedSectionsView;
  final VoidCallback onDiscard;
  final Future<void> Function() onCopyCurl;
  final Future<void> Function() onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: formKey,
      child: IgnorePointer(
        ignoring: isLocked,
        child: AnimatedOpacity(
          duration: 220.ms,
          opacity: isLocked ? 0.72 : 1.0,
          child: ListView(
            key: const ValueKey('filter-editor-view'),
            padding: const EdgeInsets.fromLTRB(20.0, 28.0, 20.0, 28.0),
            children: [
              _HeroCard(isDesktop: isDesktop)
                  .animate()
                  .fadeIn(duration: 320.ms)
                  .slideY(begin: -0.08, curve: Curves.easeOutCubic),
              const SizedBox(height: 20.0),
              _SectionCard(
                title: 'Search query',
                description:
                    'Start with the Upwork query you want Apify to scrape. The rest of the filters unlock after this field has content.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ValidatedTextField(
                      controller: queryController,
                      label: 'What jobs are you looking for?',
                      hintText:
                          'Examples: Flutter developer, AI automation, Dart backend',
                      prefixIcon: Icons.travel_explore_rounded,
                      textInputAction: TextInputAction.next,
                      validator: queryValidator,
                    ),
                    const SizedBox(height: 14.0),
                    Text(
                      'This query is the only mandatory field before the advanced filters appear.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.64),
                      ),
                    ),
                    if (isLocked) ...[
                      const SizedBox(height: 12.0),
                      const _CompactInfoCard(
                        icon: Icons.lock_clock_rounded,
                        message:
                            'Synchronization is running, so filter controls are temporarily locked.',
                      ),
                    ],
                  ],
                ),
              ).animate().fadeIn(delay: 70.ms).slideY(begin: 0.08),
              const SizedBox(height: 20.0),
              AnimatedSwitcher(
                duration: 320.ms,
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                child: showAdvancedFilters
                    ? advancedSectionsView
                    : const _LockedFiltersCard(key: ValueKey('locked-filters')),
              ),
              const SizedBox(height: 20.0),
              _SectionCard(
                title: 'Actions',
                description:
                    'Copy Apify cURL mirrors the exact polling request. Save stores the current filter in local preferences and Riverpod, and Discard restores the last saved snapshot.',
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final useColumn = constraints.maxWidth < 560.0;
                    final discardButton = OutlinedButton.icon(
                      onPressed: onDiscard,
                      icon: const Icon(Icons.restore_rounded),
                      label: const Text('Discard changes'),
                    );
                    final copyCurlButton = OutlinedButton.icon(
                      onPressed: () => unawaited(onCopyCurl()),
                      icon: const Icon(Icons.content_copy_rounded),
                      label: const Text('Copy Apify cURL'),
                    );
                    final saveButton = ElevatedButton.icon(
                      onPressed: () => unawaited(onSave()),
                      icon: const Icon(Icons.save_rounded),
                      label: const Text('Save filter'),
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        useColumn
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  discardButton,
                                  const SizedBox(height: 14.0),
                                  copyCurlButton,
                                  const SizedBox(height: 14.0),
                                  saveButton,
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(child: discardButton),
                                  const SizedBox(width: 14.0),
                                  Expanded(child: copyCurlButton),
                                  const SizedBox(width: 14.0),
                                  Expanded(child: saveButton),
                                ],
                              ),
                        const SizedBox(height: 12.0),
                        Text(
                          'Validation issues block saving and open a dialog before the filter reaches local state and preferences.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.64),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ).animate().fadeIn(delay: 140.ms).slideY(begin: 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
