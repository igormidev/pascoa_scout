part of '../job_scrapper_config_tab.dart';

class _JobScrapperAdvancedSectionsView extends StatelessWidget {
  const _JobScrapperAdvancedSectionsView({required this.state});

  final _JobScrapperConfigTabState state;

  @override
  Widget build(BuildContext context) {
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
              selected: state._selectedExperienceLevels,
              labelBuilder: state._experienceLevelLabel,
              onTap: (value) => state._toggleSelection(
                state._selectedExperienceLevels,
                value,
              ),
            ),
            const SizedBox(height: 18.0),
            _SelectionPills<ClientHistory>(
              label: 'Client history',
              description:
                  'Filter clients by how many hires they already made.',
              options: ClientHistory.values,
              selected: state._selectedClientHistories,
              labelBuilder: state._clientHistoryLabel,
              onTap: (value) =>
                  state._toggleSelection(state._selectedClientHistories, value),
            ),
            const SizedBox(height: 18.0),
            _SelectionPills<JobType>(
              label: 'Job type',
              description: 'Keep fixed-price, hourly, or both.',
              options: JobType.values,
              selected: state._selectedJobTypes,
              labelBuilder: state._jobTypeLabel,
              onTap: (value) =>
                  state._toggleSelection(state._selectedJobTypes, value),
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
              value: state._paymentVerified,
              onChanged: (value) {
                state._update(() {
                  state._paymentVerified = value;
                });
              },
              icon: Icons.verified_user_rounded,
            ),
            const SizedBox(height: 14.0),
            _OptionalFilterCard(
              title: 'Fixed-price budget range',
              description:
                  'Enable this when you want to keep only jobs within a fixed-price budget interval.',
              enabled: state._enableFixedPriceRange,
              icon: Icons.sell_rounded,
              onChanged: (value) {
                state._update(() {
                  state._enableFixedPriceRange = value;
                });
              },
              child: _RangeFields(
                minField: _ValidatedTextField(
                  controller: state._fixedMinController,
                  label: 'Minimum budget',
                  hintText: '100',
                  prefixText: '\$ ',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: state._positiveIntegerValidator(
                    label: 'Minimum budget',
                    enabled: state._enableFixedPriceRange,
                    minController: state._fixedMinController,
                    maxController: state._fixedMaxController,
                  ),
                ),
                maxField: _ValidatedTextField(
                  controller: state._fixedMaxController,
                  label: 'Maximum budget',
                  hintText: '800',
                  prefixText: '\$ ',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: state._positiveIntegerValidator(
                    label: 'Maximum budget',
                    enabled: state._enableFixedPriceRange,
                    minController: state._fixedMinController,
                    maxController: state._fixedMaxController,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            _OptionalFilterCard(
              title: 'Hourly rate range',
              description:
                  'Enable this when you want to limit hourly jobs to a specific pay interval.',
              enabled: state._enableHourlyRateRange,
              icon: Icons.timer_rounded,
              onChanged: (value) {
                state._update(() {
                  state._enableHourlyRateRange = value;
                });
              },
              child: _RangeFields(
                minField: _ValidatedTextField(
                  controller: state._hourlyMinController,
                  label: 'Minimum hourly rate',
                  hintText: '20',
                  prefixText: '\$ ',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: state._positiveIntegerValidator(
                    label: 'Minimum hourly rate',
                    enabled: state._enableHourlyRateRange,
                    minController: state._hourlyMinController,
                    maxController: state._hourlyMaxController,
                  ),
                ),
                maxField: _ValidatedTextField(
                  controller: state._hourlyMaxController,
                  label: 'Maximum hourly rate',
                  hintText: '60',
                  prefixText: '\$ ',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: state._positiveIntegerValidator(
                    label: 'Maximum hourly rate',
                    enabled: state._enableHourlyRateRange,
                    minController: state._hourlyMinController,
                    maxController: state._hourlyMaxController,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            _OptionalFilterCard(
              title: 'Maximum job age',
              description:
                  'Discard older postings by setting how fresh the job needs to be.',
              enabled: state._enableJobAgeFilter,
              icon: Icons.schedule_rounded,
              onChanged: (value) {
                state._update(() {
                  state._enableJobAgeFilter = value;
                });
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final useColumn = constraints.maxWidth < 620.0;
                  final ageValueField = _ValidatedTextField(
                    controller: state._jobAgeValueController,
                    label: 'Age value',
                    hintText: '24',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: state._positiveIntegerValidator(
                      label: 'Age value',
                      enabled: state._enableJobAgeFilter,
                    ),
                  );
                  final ageUnitField = _ValidatedDropdownField<JobAgeUnit>(
                    value: state._jobAgeUnit,
                    label: 'Age unit',
                    hintText: 'Choose unit',
                    values: JobAgeUnit.values,
                    labelBuilder: state._jobAgeUnitLabel,
                    validator: (value) => state._requiredSelectionValidator(
                      value: value,
                      enabled: state._enableJobAgeFilter,
                      label: 'Age unit',
                    ),
                    onChanged: (value) {
                      state._update(() {
                        state._jobAgeUnit = value;
                      });
                    },
                  );

                  return useColumn
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ageValueField,
                            const SizedBox(height: 14.0),
                            ageUnitField,
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(child: ageValueField),
                            const SizedBox(width: 14.0),
                            Expanded(child: ageUnitField),
                          ],
                        );
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
              selected: state._selectedRegions,
              labelBuilder: state._regionLabel,
              onTap: (value) =>
                  state._toggleSelection(state._selectedRegions, value),
            ),
            const SizedBox(height: 18.0),
            _SelectionSummaryField(
              label: 'Sub-regions',
              description:
                  'Select more precise geographies such as Western Europe or South America.',
              icon: Icons.public_rounded,
              valuePreview: state._selectionPreview(
                values: state._selectedSubRegions.toList(),
                labelBuilder: state._subRegionLabel,
              ),
              chips: [
                for (final subRegion in state._selectedSubRegions.take(4))
                  _SummaryChip(label: state._subRegionLabel(subRegion)),
                if (state._selectedSubRegions.length > 4)
                  _SummaryChip(
                    label: '+${state._selectedSubRegions.length - 4} more',
                  ),
              ],
              onTap: () {
                state._selectMultiOptions<SubRegion>(
                  title: 'Select sub-regions',
                  description: 'Choose as many sub-regions as you need.',
                  options: SubRegion.values,
                  selected: state._selectedSubRegions,
                  labelBuilder: state._subRegionLabel,
                  onSelected: (value) {
                    state._selectedSubRegions = value;
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
              valuePreview: state._selectionPreview(
                values: state._selectedCountries.toList(),
                labelBuilder: state._countryLabel,
              ),
              chips: [
                for (final country in state._selectedCountries.take(4))
                  _SummaryChip(label: state._countryLabel(country)),
                if (state._selectedCountries.length > 4)
                  _SummaryChip(
                    label: '+${state._selectedCountries.length - 4} more',
                  ),
              ],
              onTap: () {
                state._selectMultiOptions<Country>(
                  title: 'Select countries',
                  description: 'Choose client countries for the job search.',
                  options: Country.values,
                  selected: state._selectedCountries,
                  labelBuilder: state._countryLabel,
                  onSelected: (value) {
                    state._selectedCountries = value;
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
            if (state._customFilterDrafts.isEmpty)
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
            for (final draft in state._customFilterDrafts) ...[
              const SizedBox(height: 14.0),
              _CustomFilterCard(
                draft: draft,
                onRemove: () => state._removeCustomFilter(draft),
                propertyLabelBuilder: state._availablePropertyLabel,
                operatorLabelBuilder: state._availableOperatorLabel,
                onChanged: () {
                  state._update(() {});
                },
                valuesValidator: state._customFilterValuesValidator,
                propertyValidator: (value) => state._requiredSelectionValidator(
                  value: value,
                  enabled: true,
                  label: 'Property',
                ),
                operatorValidator: (value) => state._requiredSelectionValidator(
                  value: value,
                  enabled: true,
                  label: 'Operator',
                ),
              ),
            ],
            const SizedBox(height: 16.0),
            OutlinedButton.icon(
              onPressed: state._addCustomFilter,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add custom filter'),
            ),
          ],
        ),
      ),
    ];

    return _AdvancedFiltersView(
      key: const ValueKey('advanced-filters'),
      sections: [
        for (var index = 0; index < sections.length; index++) ...[
          sections[index]
              .animate(delay: Duration(milliseconds: 70 * index))
              .fadeIn(duration: 280.ms)
              .slideY(begin: 0.12, curve: Curves.easeOutCubic),
          if (index != sections.length - 1) const SizedBox(height: 18.0),
        ],
      ],
    );
  }
}
