import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pascoa_scout/interactor/job_filter/current_filter_state.dart';
import 'package:pascoa_scout/interactor/job_filter/job_filter_providers.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

class JobScrapperConfigTab extends ConsumerStatefulWidget {
  const JobScrapperConfigTab({super.key});

  @override
  ConsumerState<JobScrapperConfigTab> createState() =>
      _JobScrapperConfigTabState();
}

class _JobScrapperConfigTabState extends ConsumerState<JobScrapperConfigTab> {
  final _formKey = GlobalKey<FormState>();
  final _queryController = TextEditingController();
  final _fixedMinController = TextEditingController();
  final _fixedMaxController = TextEditingController();
  final _hourlyMinController = TextEditingController();
  final _hourlyMaxController = TextEditingController();
  final _jobAgeValueController = TextEditingController();

  Set<ExperienceLevel> _selectedExperienceLevels = <ExperienceLevel>{};
  Set<ClientHistory> _selectedClientHistories = <ClientHistory>{};
  Set<JobType> _selectedJobTypes = <JobType>{};
  Set<Country> _selectedCountries = <Country>{};
  Set<Region> _selectedRegions = <Region>{};
  Set<SubRegion> _selectedSubRegions = <SubRegion>{};

  bool _paymentVerified = false;
  bool _enableFixedPriceRange = false;
  bool _enableHourlyRateRange = false;
  bool _enableJobAgeFilter = false;

  JobAgeUnit? _jobAgeUnit;
  List<_CustomFilterDraft> _customFilterDrafts = <_CustomFilterDraft>[];

  @override
  void initState() {
    super.initState();
    _queryController.addListener(_handleQueryChanged);
    _restoreFromState(ref.read(currentFilterNotifier));
  }

  @override
  void dispose() {
    _queryController.removeListener(_handleQueryChanged);
    _queryController.dispose();
    _fixedMinController.dispose();
    _fixedMaxController.dispose();
    _hourlyMinController.dispose();
    _hourlyMaxController.dispose();
    _jobAgeValueController.dispose();

    for (final draft in _customFilterDrafts) {
      draft.dispose();
    }

    super.dispose();
  }

  bool get _showAdvancedFilters => _queryController.text.trim().isNotEmpty;

  void _handleQueryChanged() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  JobFilter _emptyFilter() => JobFilter(searchQueryTerm: '');

  JobFilter _filterFromState(CurrentFiltersState state) {
    return state.when(none: _emptyFilter, withFilter: (jobFilter) => jobFilter);
  }

  void _restoreFromState(CurrentFiltersState state) {
    final filter = _filterFromState(state);
    final previousDrafts = _customFilterDrafts;

    _queryController.text = filter.searchQueryTerm;
    _selectedExperienceLevels = {...?filter.experienceLevel};
    _selectedClientHistories = {...?filter.clientHistory};
    _selectedJobTypes = {...?filter.jobType};
    _paymentVerified = filter.paymentVerified;

    _enableFixedPriceRange = filter.fixedPriceRange != null;
    _fixedMinController.text = filter.fixedPriceRange?.min.toString() ?? '';
    _fixedMaxController.text = filter.fixedPriceRange?.max.toString() ?? '';

    _enableHourlyRateRange = filter.hourlyRateRange != null;
    _hourlyMinController.text = filter.hourlyRateRange?.min.toString() ?? '';
    _hourlyMaxController.text = filter.hourlyRateRange?.max.toString() ?? '';

    _selectedCountries = {...?filter.countries};
    _selectedRegions = {...?filter.regions};
    _selectedSubRegions = {...?filter.subRegions};

    _enableJobAgeFilter = filter.jobAgeFilter != null;
    _jobAgeUnit = filter.jobAgeFilter?.unit;
    _jobAgeValueController.text = filter.jobAgeFilter?.value.toString() ?? '';

    _customFilterDrafts = [
      for (final customFilter in filter.customFilters ?? const <CustomFilter>[])
        _CustomFilterDraft.fromFilter(customFilter),
    ];

    for (final draft in previousDrafts) {
      draft.dispose();
    }

    if (!mounted) {
      return;
    }

    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.reset();
    });
  }

  Future<void> _selectMultiOptions<T>({
    required String title,
    required String description,
    required List<T> options,
    required Set<T> selected,
    required String Function(T value) labelBuilder,
    required ValueChanged<Set<T>> onSelected,
  }) async {
    final result = await showModalBottomSheet<Set<T>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _MultiSelectSheet<T>(
          title: title,
          description: description,
          options: options,
          initiallySelected: selected,
          labelBuilder: labelBuilder,
        );
      },
    );

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      onSelected(result);
    });
  }

  Future<void> _handleSave() async {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      if (!mounted) {
        return;
      }

      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Complete the warnings',
        desc:
            'The filter still has invalid or empty required fields. Fix the highlighted inputs before saving.',
        btnOkText: 'Review form',
        btnOkOnPress: () {},
      ).show();
      return;
    }

    ref.read(currentFilterNotifier.notifier).saveFilter(_buildFilter());

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Current filter state updated locally.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
    );
  }

  void _handleDiscard() {
    FocusScope.of(context).unfocus();
    _restoreFromState(ref.read(currentFilterNotifier));
  }

  JobFilter _buildFilter() {
    final fixedMin = int.tryParse(_fixedMinController.text.trim());
    final fixedMax = int.tryParse(_fixedMaxController.text.trim());
    final hourlyMin = int.tryParse(_hourlyMinController.text.trim());
    final hourlyMax = int.tryParse(_hourlyMaxController.text.trim());
    final jobAgeValue = int.tryParse(_jobAgeValueController.text.trim());

    return JobFilter(
      searchQueryTerm: _queryController.text.trim(),
      experienceLevel: _nullableList(_selectedExperienceLevels),
      clientHistory: _nullableList(_selectedClientHistories),
      jobType: _nullableList(_selectedJobTypes),
      paymentVerified: _paymentVerified,
      fixedPriceRange:
          _enableFixedPriceRange && fixedMin != null && fixedMax != null
          ? MinMax(min: fixedMin, max: fixedMax)
          : null,
      hourlyRateRange:
          _enableHourlyRateRange && hourlyMin != null && hourlyMax != null
          ? MinMax(min: hourlyMin, max: hourlyMax)
          : null,
      countries: _nullableList(_selectedCountries),
      regions: _nullableList(_selectedRegions),
      subRegions: _nullableList(_selectedSubRegions),
      jobAgeFilter:
          _enableJobAgeFilter && jobAgeValue != null && _jobAgeUnit != null
          ? MaximumJobAge(unit: _jobAgeUnit!, value: jobAgeValue)
          : null,
      customFilters: _customFilterDrafts.isEmpty
          ? null
          : [for (final draft in _customFilterDrafts) draft.toFilter()],
    );
  }

  List<T>? _nullableList<T>(Set<T> values) {
    if (values.isEmpty) {
      return null;
    }

    return values.toList();
  }

  void _toggleSelection<T>(Set<T> currentValues, T value) {
    setState(() {
      if (currentValues.contains(value)) {
        currentValues.remove(value);
      } else {
        currentValues.add(value);
      }
    });
  }

  void _addCustomFilter() {
    setState(() {
      _customFilterDrafts = [
        ..._customFilterDrafts,
        _CustomFilterDraft.empty(),
      ];
    });
  }

  void _removeCustomFilter(_CustomFilterDraft draft) {
    draft.dispose();
    setState(() {
      _customFilterDrafts = _customFilterDrafts
          .where((candidate) => candidate != draft)
          .toList();
    });
  }

  String? Function(String?) _requiredTextValidator(String label) {
    return FormBuilderValidators.compose([
      (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required.';
        }

        return null;
      },
    ]);
  }

  String? Function(String?) _positiveIntegerValidator({
    required String label,
    required bool enabled,
    TextEditingController? minController,
    TextEditingController? maxController,
  }) {
    return FormBuilderValidators.compose([
      (value) {
        if (!enabled) {
          return null;
        }

        if (value == null || value.trim().isEmpty) {
          return '$label is required.';
        }

        final parsedValue = int.tryParse(value.trim());
        if (parsedValue == null) {
          return '$label must be a whole number.';
        }

        if (parsedValue <= 0) {
          return '$label must be greater than zero.';
        }

        return null;
      },
      (value) {
        if (!enabled) {
          return null;
        }

        final minValue = int.tryParse(minController?.text.trim() ?? '');
        final maxValue = int.tryParse(maxController?.text.trim() ?? '');
        if (minValue != null && maxValue != null && minValue > maxValue) {
          return 'Minimum cannot be greater than maximum.';
        }

        return null;
      },
    ]);
  }

  String? _requiredSelectionValidator<T>({
    required T? value,
    required bool enabled,
    required String label,
  }) {
    if (!enabled) {
      return null;
    }

    if (value == null) {
      return '$label is required.';
    }

    return null;
  }

  String? _customFilterValuesValidator(String? value) {
    final normalizedValues = _normalizeCustomFilterValues(value);
    if (normalizedValues.isEmpty) {
      return 'Add at least one custom value.';
    }

    return null;
  }

  List<String> _normalizeCustomFilterValues(String? value) {
    return (value ?? '')
        .split(',')
        .map((entry) => entry.trim())
        .where((entry) => entry.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 860.0;

    return Stack(
      children: [
        const Positioned.fill(child: _ConfigBackground()),
        SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 990.0),
              child: Form(
                key: _formKey,
                child: ListView(
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
                            controller: _queryController,
                            label: 'What jobs are you looking for?',
                            hintText:
                                'Examples: Flutter developer, AI automation, Dart backend',
                            prefixIcon: Icons.travel_explore_rounded,
                            textInputAction: TextInputAction.next,
                            validator: _requiredTextValidator('Search query'),
                          ),
                          const SizedBox(height: 14.0),
                          Text(
                            'This query is the only mandatory field before the advanced filters appear.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.64),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 70.ms).slideY(begin: 0.08),
                    const SizedBox(height: 20.0),
                    AnimatedSwitcher(
                      duration: 320.ms,
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: _showAdvancedFilters
                          ? _AdvancedFiltersView(
                              key: const ValueKey('advanced-filters'),
                              sections: _buildAdvancedSections(isDesktop),
                            )
                          : const _LockedFiltersCard(
                              key: ValueKey('locked-filters'),
                            ),
                    ),
                    const SizedBox(height: 20.0),
                    _SectionCard(
                      title: 'Actions',
                      description:
                          'Save only updates the local `CurrentFiltersState` for now. Discard restores the last saved provider snapshot.',
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final useColumn = constraints.maxWidth < 560.0;
                          final buttons = [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _handleDiscard,
                                icon: const Icon(Icons.restore_rounded),
                                label: const Text('Discard changes'),
                              ),
                            ),
                            SizedBox(
                              width: useColumn ? 0.0 : 14.0,
                              height: useColumn ? 14.0 : 0.0,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _handleSave,
                                icon: const Icon(Icons.save_rounded),
                                label: const Text('Save filter'),
                              ),
                            ),
                          ];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              useColumn
                                  ? Column(children: buttons)
                                  : Row(children: buttons),
                              const SizedBox(height: 12.0),
                              Text(
                                'Validation issues will block saving and open a dialog so nothing incomplete slips into state.',
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
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAdvancedSections(bool isDesktop) {
    final sections = <Widget>[
      _SectionCard(
        title: 'Core filters',
        description:
            'Use quick radial picks for the most common Upwork job characteristics.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SelectionPills<ExperienceLevel>(
              label: 'Experience level',
              description: 'Pick one or more seniority bands.',
              options: ExperienceLevel.values,
              selected: _selectedExperienceLevels,
              labelBuilder: _experienceLevelLabel,
              onTap: (value) =>
                  _toggleSelection(_selectedExperienceLevels, value),
            ),
            const SizedBox(height: 18.0),
            _SelectionPills<ClientHistory>(
              label: 'Client history',
              description:
                  'Filter clients by how many hires they already made.',
              options: ClientHistory.values,
              selected: _selectedClientHistories,
              labelBuilder: _clientHistoryLabel,
              onTap: (value) =>
                  _toggleSelection(_selectedClientHistories, value),
            ),
            const SizedBox(height: 18.0),
            _SelectionPills<JobType>(
              label: 'Job type',
              description: 'Keep fixed-price, hourly, or both.',
              options: JobType.values,
              selected: _selectedJobTypes,
              labelBuilder: _jobTypeLabel,
              onTap: (value) => _toggleSelection(_selectedJobTypes, value),
            ),
          ],
        ),
      ),
      _SectionCard(
        title: 'Budget and timing',
        description:
            'Turn on only the numeric filters you want to enforce, then complete the required fields inside each card.',
        child: Column(
          children: [
            _BooleanToggleCard(
              title: 'Only payment verified clients',
              description:
                  'Hide jobs from clients that have not verified their payment method.',
              value: _paymentVerified,
              onChanged: (value) {
                setState(() {
                  _paymentVerified = value;
                });
              },
              icon: Icons.verified_user_rounded,
            ),
            const SizedBox(height: 14.0),
            _OptionalFilterCard(
              title: 'Fixed-price budget range',
              description:
                  'Enable this when you want to keep only jobs within a fixed-price budget interval.',
              enabled: _enableFixedPriceRange,
              icon: Icons.sell_rounded,
              onChanged: (value) {
                setState(() {
                  _enableFixedPriceRange = value;
                });
              },
              child: _RangeFields(
                minField: _ValidatedTextField(
                  controller: _fixedMinController,
                  label: 'Minimum budget',
                  hintText: '100',
                  prefixText: '\$ ',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _positiveIntegerValidator(
                    label: 'Minimum budget',
                    enabled: _enableFixedPriceRange,
                    minController: _fixedMinController,
                    maxController: _fixedMaxController,
                  ),
                ),
                maxField: _ValidatedTextField(
                  controller: _fixedMaxController,
                  label: 'Maximum budget',
                  hintText: '800',
                  prefixText: '\$ ',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _positiveIntegerValidator(
                    label: 'Maximum budget',
                    enabled: _enableFixedPriceRange,
                    minController: _fixedMinController,
                    maxController: _fixedMaxController,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            _OptionalFilterCard(
              title: 'Hourly rate range',
              description:
                  'Enable this when you want to limit hourly jobs to a specific pay interval.',
              enabled: _enableHourlyRateRange,
              icon: Icons.timer_rounded,
              onChanged: (value) {
                setState(() {
                  _enableHourlyRateRange = value;
                });
              },
              child: _RangeFields(
                minField: _ValidatedTextField(
                  controller: _hourlyMinController,
                  label: 'Minimum hourly rate',
                  hintText: '20',
                  prefixText: '\$ ',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _positiveIntegerValidator(
                    label: 'Minimum hourly rate',
                    enabled: _enableHourlyRateRange,
                    minController: _hourlyMinController,
                    maxController: _hourlyMaxController,
                  ),
                ),
                maxField: _ValidatedTextField(
                  controller: _hourlyMaxController,
                  label: 'Maximum hourly rate',
                  hintText: '60',
                  prefixText: '\$ ',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _positiveIntegerValidator(
                    label: 'Maximum hourly rate',
                    enabled: _enableHourlyRateRange,
                    minController: _hourlyMinController,
                    maxController: _hourlyMaxController,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            _OptionalFilterCard(
              title: 'Maximum job age',
              description:
                  'Discard older postings by setting how fresh the job needs to be.',
              enabled: _enableJobAgeFilter,
              icon: Icons.schedule_rounded,
              onChanged: (value) {
                setState(() {
                  _enableJobAgeFilter = value;
                });
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final useColumn = constraints.maxWidth < 620.0;
                  final fields = [
                    Expanded(
                      child: _ValidatedTextField(
                        controller: _jobAgeValueController,
                        label: 'Age value',
                        hintText: '24',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: _positiveIntegerValidator(
                          label: 'Age value',
                          enabled: _enableJobAgeFilter,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: useColumn ? 0.0 : 14.0,
                      height: useColumn ? 14.0 : 0.0,
                    ),
                    Expanded(
                      child: _ValidatedDropdownField<JobAgeUnit>(
                        value: _jobAgeUnit,
                        label: 'Age unit',
                        hintText: 'Choose unit',
                        values: JobAgeUnit.values,
                        labelBuilder: _jobAgeUnitLabel,
                        validator: (value) => _requiredSelectionValidator(
                          value: value,
                          enabled: _enableJobAgeFilter,
                          label: 'Age unit',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _jobAgeUnit = value;
                          });
                        },
                      ),
                    ),
                  ];

                  return useColumn
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: fields,
                        )
                      : Row(children: fields);
                },
              ),
            ),
          ],
        ),
      ),
      _SectionCard(
        title: 'Location filters',
        description:
            'Combine region picks with deeper lists for sub-regions and specific client countries.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SelectionPills<Region>(
              label: 'Regions',
              description: 'Quick-pick broad geographies.',
              options: Region.values,
              selected: _selectedRegions,
              labelBuilder: _regionLabel,
              onTap: (value) => _toggleSelection(_selectedRegions, value),
            ),
            const SizedBox(height: 18.0),
            _SelectionSummaryField(
              label: 'Sub-regions',
              description:
                  'Select more precise geographies such as Western Europe or South America.',
              icon: Icons.public_rounded,
              valuePreview: _selectionPreview(
                values: _selectedSubRegions.toList(),
                labelBuilder: _subRegionLabel,
              ),
              chips: [
                for (final subRegion in _selectedSubRegions.take(4))
                  _SummaryChip(label: _subRegionLabel(subRegion)),
                if (_selectedSubRegions.length > 4)
                  _SummaryChip(
                    label: '+${_selectedSubRegions.length - 4} more',
                  ),
              ],
              onTap: () {
                _selectMultiOptions<SubRegion>(
                  title: 'Select sub-regions',
                  description: 'Choose as many sub-regions as you need.',
                  options: SubRegion.values,
                  selected: _selectedSubRegions,
                  labelBuilder: _subRegionLabel,
                  onSelected: (value) {
                    _selectedSubRegions = value;
                  },
                );
              },
            ),
            const SizedBox(height: 14.0),
            _SelectionSummaryField(
              label: 'Countries',
              description:
                  'Open the list and pick exact client locations when broad regions are not enough.',
              icon: Icons.flag_circle_rounded,
              valuePreview: _selectionPreview(
                values: _selectedCountries.toList(),
                labelBuilder: _countryLabel,
              ),
              chips: [
                for (final country in _selectedCountries.take(4))
                  _SummaryChip(label: _countryLabel(country)),
                if (_selectedCountries.length > 4)
                  _SummaryChip(label: '+${_selectedCountries.length - 4} more'),
              ],
              onTap: () {
                _selectMultiOptions<Country>(
                  title: 'Select countries',
                  description: 'Choose client countries for the job search.',
                  options: Country.values,
                  selected: _selectedCountries,
                  labelBuilder: _countryLabel,
                  onSelected: (value) {
                    _selectedCountries = value;
                  },
                );
              },
            ),
          ],
        ),
      ),
      _SectionCard(
        title: 'Custom filters',
        description:
            'Add advanced property rules for title, description, dates, tags, allowed countries, and more.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_customFilterDrafts.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0),
                  color: Colors.white.withValues(alpha: 0.03),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.tune_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Use custom filters when the built-in fields are not enough. Each rule needs a property, an operator, and one or more comma-separated values.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.76),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            for (final draft in _customFilterDrafts) ...[
              const SizedBox(height: 14.0),
              _CustomFilterCard(
                draft: draft,
                onRemove: () => _removeCustomFilter(draft),
                propertyLabelBuilder: _availablePropertyLabel,
                operatorLabelBuilder: _availableOperatorLabel,
                onChanged: () {
                  setState(() {});
                },
                valuesValidator: _customFilterValuesValidator,
                propertyValidator: (value) => _requiredSelectionValidator(
                  value: value,
                  enabled: true,
                  label: 'Property',
                ),
                operatorValidator: (value) => _requiredSelectionValidator(
                  value: value,
                  enabled: true,
                  label: 'Operator',
                ),
              ),
            ],
            const SizedBox(height: 16.0),
            OutlinedButton.icon(
              onPressed: _addCustomFilter,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add custom filter'),
            ),
          ],
        ),
      ),
    ];

    return [
      for (var index = 0; index < sections.length; index++) ...[
        sections[index]
            .animate(delay: Duration(milliseconds: 70 * index))
            .fadeIn(duration: 280.ms)
            .slideY(begin: 0.12, curve: Curves.easeOutCubic),
        if (index != sections.length - 1) const SizedBox(height: 18.0),
      ],
    ];
  }

  String _selectionPreview<T>({
    required List<T> values,
    required String Function(T value) labelBuilder,
  }) {
    if (values.isEmpty) {
      return 'Nothing selected yet';
    }

    final preview = values.take(3).map(labelBuilder).join(', ');
    if (values.length <= 3) {
      return preview;
    }

    return '$preview +${values.length - 3} more';
  }

  String _experienceLevelLabel(ExperienceLevel value) {
    return switch (value) {
      ExperienceLevel.entryLevel => 'Entry level',
      ExperienceLevel.intermediate => 'Intermediate',
      ExperienceLevel.expert => 'Expert',
    };
  }

  String _clientHistoryLabel(ClientHistory value) {
    return switch (value) {
      ClientHistory.noHires => 'No hires yet',
      ClientHistory.oneTonNineHires => '1 to 9 hires',
      ClientHistory.tenPlusHires => '10+ hires',
    };
  }

  String _jobTypeLabel(JobType value) {
    return switch (value) {
      JobType.fixed => 'Fixed price',
      JobType.hourly => 'Hourly',
    };
  }

  String _regionLabel(Region value) => _humanizeEnumName(value.name);

  String _subRegionLabel(SubRegion value) => _humanizeEnumName(value.name);

  String _countryLabel(Country value) => _humanizeEnumName(value.name);

  String _jobAgeUnitLabel(JobAgeUnit value) {
    return switch (value) {
      JobAgeUnit.minutes => 'Minutes',
      JobAgeUnit.hours => 'Hours',
      JobAgeUnit.days => 'Days',
      JobAgeUnit.weeks => 'Weeks',
    };
  }

  String _availablePropertyLabel(AvailableProperties value) {
    return switch (value) {
      AvailableProperties.title => 'Title',
      AvailableProperties.description => 'Description',
      AvailableProperties.jobType => 'Job type',
      AvailableProperties.experienceLevel => 'Experience level',
      AvailableProperties.budget => 'Budget',
      AvailableProperties.tags => 'Tags',
      AvailableProperties.relativeDate => 'Relative date',
      AvailableProperties.absoluteDate => 'Absolute date',
      AvailableProperties.paymentVerified => 'Payment verified',
      AvailableProperties.clientLocation => 'Client location',
      AvailableProperties.allowedApplicantCountries =>
        'Allowed applicant countries',
    };
  }

  String _availableOperatorLabel(AvailableOperators value) {
    return switch (value) {
      AvailableOperators.includes => 'Includes',
      AvailableOperators.equals => 'Equals',
      AvailableOperators.notIncludes => 'Does not include',
      AvailableOperators.notEquals => 'Does not equal',
    };
  }

  String _humanizeEnumName(String name) {
    final buffer = StringBuffer();

    for (var index = 0; index < name.length; index++) {
      final char = name[index];
      final isUppercase =
          char.toUpperCase() == char && char.toLowerCase() != char;
      final isDigit = int.tryParse(char) != null;

      if (index > 0 && (isUppercase || isDigit)) {
        buffer.write(' ');
      }

      buffer.write(char);
    }

    final words = buffer.toString().split(' ');
    return words
        .map((word) {
          if (word.isEmpty) {
            return word;
          }

          return '${word[0].toUpperCase()}${word.substring(1)}';
        })
        .join(' ');
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF16342B), Color(0xFF0C1814), Color(0xFF0A2428)],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 36.0,
            offset: const Offset(0.0, 20.0),
          ),
        ],
      ),
      child: isDesktop
          ? Row(
              children: [
                const Expanded(child: _HeroCopy()),
                const SizedBox(width: 24.0),
                _HeroBadge(theme: theme),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HeroCopy(),
                const SizedBox(height: 18.0),
                _HeroBadge(theme: theme),
              ],
            ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999.0),
            color: Colors.white.withValues(alpha: 0.08),
          ),
          child: const Text(
            'Upwork scouting configuration',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 18.0),
        Text(
          'Shape the exact jobs you want Apify to fetch.',
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 12.0),
        Text(
          'Start with your search query, then layer in geography, budget, job freshness, and custom rules without leaving the same screen.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.78),
          ),
        ),
      ],
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260.0,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        color: Colors.white.withValues(alpha: 0.06),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.hub_rounded,
            size: 34.0,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(height: 18.0),
          Text('Local filter state', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8.0),
          Text(
            'Save persists the form into Riverpod now, so the scraper execution flow can plug into the same state later.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 6.0),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.72),
              ),
            ),
            const SizedBox(height: 18.0),
            child,
          ],
        ),
      ),
    );
  }
}

class _LockedFiltersCard extends StatelessWidget {
  const _LockedFiltersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        color: Colors.white.withValues(alpha: 0.03),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(
                context,
              ).colorScheme.secondary.withValues(alpha: 0.12),
            ),
            child: Icon(
              Icons.lock_open_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Advanced filters are waiting',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Enter a non-empty search query above and the rest of the filter form will animate into view below it.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.12);
  }
}

class _AdvancedFiltersView extends StatelessWidget {
  const _AdvancedFiltersView({super.key, required this.sections});

  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections,
    );
  }
}

class _SelectionPills<T> extends StatelessWidget {
  const _SelectionPills({
    required this.label,
    required this.description,
    required this.options,
    required this.selected,
    required this.labelBuilder,
    required this.onTap,
  });

  final String label;
  final String description;
  final List<T> options;
  final Set<T> selected;
  final String Function(T value) labelBuilder;
  final ValueChanged<T> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleMedium),
        const SizedBox(height: 4.0),
        Text(
          description,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.66),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            for (final option in options)
              _SelectablePill(
                label: labelBuilder(option),
                selected: selected.contains(option),
                onTap: () => onTap(option),
              ),
          ],
        ),
      ],
    );
  }
}

class _SelectablePill extends StatelessWidget {
  const _SelectablePill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999.0),
        onTap: onTap,
        child: AnimatedContainer(
          duration: 220.ms,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999.0),
            color: selected
                ? theme.colorScheme.primary.withValues(alpha: 0.18)
                : Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: 220.ms,
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? theme.colorScheme.primary
                        : Colors.white.withValues(alpha: 0.42),
                    width: 1.6,
                  ),
                ),
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 12.0,
                        color: Color(0xFF03110D),
                      )
                    : null,
              ),
              const SizedBox(width: 10.0),
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? theme.colorScheme.primary
                      : Colors.white.withValues(alpha: 0.88),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BooleanToggleCard extends StatelessWidget {
  const _BooleanToggleCard({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
    required this.icon,
  });

  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: 220.ms,
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: value
            ? theme.colorScheme.primary.withValues(alpha: 0.08)
            : Colors.white.withValues(alpha: 0.03),
        border: Border.all(
          color: value
              ? theme.colorScheme.primary.withValues(alpha: 0.6)
              : theme.colorScheme.outline.withValues(alpha: 0.42),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.0),
        onTap: () => onChanged(!value),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
              child: Icon(icon, color: theme.colorScheme.secondary),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.68),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Checkbox(
              value: value,
              onChanged: (checked) => onChanged(checked ?? false),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionalFilterCard extends StatelessWidget {
  const _OptionalFilterCard({
    required this.title,
    required this.description,
    required this.enabled,
    required this.onChanged,
    required this.child,
    required this.icon,
  });

  final String title;
  final String description;
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final Widget child;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 220.ms,
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: enabled
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.03),
        border: Border.all(
          color: enabled
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.38)
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.38),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(18.0),
            onTap: () => onChanged(!enabled),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.68),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12.0),
                Checkbox(
                  value: enabled,
                  onChanged: (checked) => onChanged(checked ?? false),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: 260.ms,
            child: enabled
                ? Padding(
                    key: const ValueKey('enabled-fields'),
                    padding: const EdgeInsets.only(top: 16.0),
                    child: child,
                  ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.08)
                : const SizedBox.shrink(key: ValueKey('disabled-fields')),
          ),
        ],
      ),
    );
  }
}

class _RangeFields extends StatelessWidget {
  const _RangeFields({required this.minField, required this.maxField});

  final Widget minField;
  final Widget maxField;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useColumn = constraints.maxWidth < 620.0;
        final children = [
          Expanded(child: minField),
          SizedBox(
            width: useColumn ? 0.0 : 14.0,
            height: useColumn ? 14.0 : 0.0,
          ),
          Expanded(child: maxField),
        ];

        return useColumn
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              )
            : Row(children: children);
      },
    );
  }
}

class _SelectionSummaryField extends StatelessWidget {
  const _SelectionSummaryField({
    required this.label,
    required this.description,
    required this.valuePreview,
    required this.chips,
    required this.onTap,
    required this.icon,
  });

  final String label;
  final String description;
  final String valuePreview;
  final List<Widget> chips;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24.0),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Colors.white.withValues(alpha: 0.03),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.38),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                    child: Icon(icon, color: theme.colorScheme.secondary),
                  ),
                  const SizedBox(width: 14.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(label, style: theme.textTheme.titleMedium),
                        const SizedBox(height: 4.0),
                        Text(
                          description,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.68),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
              const SizedBox(height: 14.0),
              Text(
                valuePreview,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.84),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (chips.isNotEmpty) ...[
                const SizedBox(height: 12.0),
                Wrap(spacing: 8.0, runSpacing: 8.0, children: chips),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999.0),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _ValidatedTextField extends StatefulWidget {
  const _ValidatedTextField({
    required this.controller,
    required this.label,
    required this.validator,
    this.hintText,
    this.prefixIcon,
    this.prefixText,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final IconData? prefixIcon;
  final String? prefixText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;

  @override
  State<_ValidatedTextField> createState() => _ValidatedTextFieldState();
}

class _ValidatedTextFieldState extends State<_ValidatedTextField> {
  final _fieldKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    final errorText = _fieldKey.currentState?.errorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          key: _fieldKey,
          controller: widget.controller,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          textInputAction: widget.textInputAction,
          onChanged: (_) {
            if (mounted) {
              setState(() {});
            }
          },
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            prefixText: widget.prefixText,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon),
            errorStyle: const TextStyle(fontSize: 0.0, height: 0.0),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8.0),
          _CompactErrorCard(message: errorText),
        ],
      ],
    );
  }
}

class _ValidatedDropdownField<T> extends StatefulWidget {
  const _ValidatedDropdownField({
    required this.value,
    required this.label,
    required this.values,
    required this.labelBuilder,
    required this.onChanged,
    required this.validator,
    this.hintText,
  });

  final T? value;
  final String label;
  final String? hintText;
  final List<T> values;
  final String Function(T value) labelBuilder;
  final ValueChanged<T?> onChanged;
  final FormFieldValidator<T>? validator;

  @override
  State<_ValidatedDropdownField<T>> createState() =>
      _ValidatedDropdownFieldState<T>();
}

class _ValidatedDropdownFieldState<T>
    extends State<_ValidatedDropdownField<T>> {
  final _fieldKey = GlobalKey<FormFieldState<T>>();
  late final ValueNotifier<T?> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<T?>(widget.value);
  }

  @override
  void didUpdateWidget(covariant _ValidatedDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _valueNotifier.value = widget.value;
    }
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorText = _fieldKey.currentState?.errorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField2<T>(
          key: _fieldKey,
          isExpanded: true,
          valueListenable: _valueNotifier,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            errorStyle: const TextStyle(fontSize: 0.0, height: 0.0),
          ),
          items: [
            for (final value in widget.values)
              DropdownItem<T>(
                value: value,
                child: Text(widget.labelBuilder(value)),
              ),
          ],
          onChanged: (value) {
            widget.onChanged(value);
            if (mounted) {
              setState(() {});
            }
          },
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.expand_more_rounded,
              color: theme.colorScheme.primary,
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 280.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: theme.colorScheme.surface,
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.42),
              ),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8.0),
          _CompactErrorCard(message: errorText),
        ],
      ],
    );
  }
}

class _CompactErrorCard extends StatelessWidget {
  const _CompactErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: const Color(0xFF4A1517),
        border: Border.all(
          color: const Color(0xFFFF7B72).withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 16.0,
            color: Color(0xFFFFB4AC),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 12.0,
                height: 1.2,
                color: Color(0xFFFFDAD6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomFilterCard extends StatelessWidget {
  const _CustomFilterCard({
    required this.draft,
    required this.onRemove,
    required this.propertyLabelBuilder,
    required this.operatorLabelBuilder,
    required this.onChanged,
    required this.valuesValidator,
    required this.propertyValidator,
    required this.operatorValidator,
  });

  final _CustomFilterDraft draft;
  final VoidCallback onRemove;
  final String Function(AvailableProperties value) propertyLabelBuilder;
  final String Function(AvailableOperators value) operatorLabelBuilder;
  final VoidCallback onChanged;
  final String? Function(String? value) valuesValidator;
  final FormFieldValidator<AvailableProperties> propertyValidator;
  final FormFieldValidator<AvailableOperators> operatorValidator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final useColumn = constraints.maxWidth < 720.0;

          final propertyField = Expanded(
            child: _ValidatedDropdownField<AvailableProperties>(
              value: draft.property,
              label: 'Property',
              hintText: 'Choose a property',
              values: AvailableProperties.values,
              labelBuilder: propertyLabelBuilder,
              validator: propertyValidator,
              onChanged: (value) {
                draft.property = value;
                onChanged();
              },
            ),
          );

          final operatorField = Expanded(
            child: _ValidatedDropdownField<AvailableOperators>(
              value: draft.operator,
              label: 'Operator',
              hintText: 'Choose an operator',
              values: AvailableOperators.values,
              labelBuilder: operatorLabelBuilder,
              validator: operatorValidator,
              onChanged: (value) {
                draft.operator = value;
                onChanged();
              },
            ),
          );

          final valuesField = Expanded(
            child: _ValidatedTextField(
              controller: draft.valuesController,
              label: 'Values',
              hintText: 'Comma-separated values',
              prefixIcon: Icons.filter_alt_rounded,
              validator: valuesValidator,
            ),
          );

          if (useColumn) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Custom rule',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: onRemove,
                      icon: const Icon(Icons.delete_outline_rounded),
                      tooltip: 'Remove rule',
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                propertyField,
                const SizedBox(height: 12.0),
                operatorField,
                const SizedBox(height: 12.0),
                valuesField,
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Custom rule',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete_outline_rounded),
                    tooltip: 'Remove rule',
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  propertyField,
                  const SizedBox(width: 12.0),
                  operatorField,
                  const SizedBox(width: 12.0),
                  valuesField,
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MultiSelectSheet<T> extends StatefulWidget {
  const _MultiSelectSheet({
    required this.title,
    required this.description,
    required this.options,
    required this.initiallySelected,
    required this.labelBuilder,
  });

  final String title;
  final String description;
  final List<T> options;
  final Set<T> initiallySelected;
  final String Function(T value) labelBuilder;

  @override
  State<_MultiSelectSheet<T>> createState() => _MultiSelectSheetState<T>();
}

class _MultiSelectSheetState<T> extends State<_MultiSelectSheet<T>> {
  late final TextEditingController _searchController;
  late Set<T> _selected;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selected = {...widget.initiallySelected};
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredOptions = widget.options.where((option) {
      final query = _searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        return true;
      }

      return widget.labelBuilder(option).toLowerCase().contains(query);
    }).toList();

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12.0, 48.0, 12.0, 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: const Color(0xFF0E1C18),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.34),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 12.0, 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: theme.textTheme.titleLarge),
                        const SizedBox(height: 6.0),
                        Text(
                          widget.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.72),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _searchController,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  labelText: 'Search options',
                  hintText: 'Type to filter the list',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    '${_selected.length} selected',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.72),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selected.clear();
                      });
                    },
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                itemCount: filteredOptions.length,
                itemBuilder: (context, index) {
                  final option = filteredOptions[index];
                  final isSelected = _selected.contains(option);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selected.remove(option);
                            } else {
                              _selected.add(option);
                            }
                          });
                        },
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 14.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: isSelected
                                ? theme.colorScheme.primary.withValues(
                                    alpha: 0.12,
                                  )
                                : Colors.white.withValues(alpha: 0.03),
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary.withValues(
                                      alpha: 0.6,
                                    )
                                  : theme.colorScheme.outline.withValues(
                                      alpha: 0.34,
                                    ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: isSelected,
                                onChanged: (checked) {
                                  setState(() {
                                    if (checked ?? false) {
                                      _selected.add(option);
                                    } else {
                                      _selected.remove(option);
                                    }
                                  });
                                },
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Text(
                                  widget.labelBuilder(option),
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(_selected),
                      child: const Text('Apply selection'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfigBackground extends StatelessWidget {
  const _ConfigBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF071411), Color(0xFF091815), Color(0xFF04100D)],
        ),
      ),
      child: Stack(
        children: const [
          _GlowOrb(
            size: 320.0,
            color: Color(0xFF0E7C67),
            top: -80.0,
            left: -70.0,
          ),
          _GlowOrb(
            size: 260.0,
            color: Color(0xFF156F8F),
            top: 120.0,
            right: -40.0,
          ),
          _GlowOrb(
            size: 220.0,
            color: Color(0xFF2A8F57),
            bottom: -40.0,
            left: 40.0,
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.size,
    required this.color,
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  final double size;
  final Color color;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;

  final double _blur = 90.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.16),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.18),
                blurRadius: _blur,
                spreadRadius: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomFilterDraft {
  _CustomFilterDraft({
    this.property,
    this.operator,
    required this.valuesController,
  });

  factory _CustomFilterDraft.empty() {
    return _CustomFilterDraft(valuesController: TextEditingController());
  }

  factory _CustomFilterDraft.fromFilter(CustomFilter filter) {
    return _CustomFilterDraft(
      property: filter.properties,
      operator: filter.operators,
      valuesController: TextEditingController(text: filter.values.join(', ')),
    );
  }

  AvailableProperties? property;
  AvailableOperators? operator;
  final TextEditingController valuesController;

  CustomFilter toFilter() {
    return CustomFilter(
      properties: property!,
      operators: operator!,
      values: valuesController.text
          .split(',')
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList(),
    );
  }

  void dispose() {
    valuesController.dispose();
  }
}
