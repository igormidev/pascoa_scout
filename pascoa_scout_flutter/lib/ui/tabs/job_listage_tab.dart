import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout/interactor/app_notification/app_notification_providers.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_card.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

const _jobAnalysisListPreferencesKey = 'job_analysis_list_preferences';

class JobListageTab extends ConsumerStatefulWidget {
  const JobListageTab({super.key});

  @override
  ConsumerState<JobListageTab> createState() => _JobListageTabState();
}

class _JobListageTabState extends ConsumerState<JobListageTab> {
  final _searchController = TextEditingController();
  _LocalJobAnalysisFilters _filters = const _LocalJobAnalysisFilters();
  JobAnalysisPagination? _pageData;
  Object? _loadError;
  bool _isLoading = true;
  final Set<int> _refreshingCards = <int>{};

  @override
  void initState() {
    super.initState();
    _filters = _restorePersistedFilters();
    _loadPage(resetReference: true);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Job matches', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'Search persisted analyses, inspect scores and AI-generated responses, and refresh only the rows that are still incomplete.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
          const SizedBox(height: 20),
          _buildToolbar(context),
          const SizedBox(height: 12),
          if (_buildAppliedFilterChips().isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _buildAppliedFilterChips(),
            ),
          const SizedBox(height: 18),
          Expanded(child: _buildBody(context)),
        ],
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Row(
      children: [
        IconButton.filledTonal(
          tooltip: 'Refresh current filters',
          onPressed: () => _loadPage(resetReference: true, page: 1),
          icon: const Icon(Icons.refresh_rounded),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText:
                            'Search job titles, descriptions, or client names',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _applySearch(),
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        _applySearch();
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: _openFiltersDialog,
          icon: const Icon(Icons.filter_alt_rounded),
          label: const Text('Filters'),
        ),
        const SizedBox(width: 12),
        _OrderByMenu(
          current: _filters.orderBy,
          onSelected: (orderBy) => unawaited(_updateOrderBy(orderBy)),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading && _pageData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_loadError != null && _pageData == null) {
      return Center(
        child: _StateCard(
          icon: Icons.error_outline_rounded,
          title: 'Unable to load job analyses',
          description: _loadError.toString(),
          actionLabel: 'Retry',
          onAction: () => _loadPage(resetReference: true),
        ),
      );
    }

    final pageData = _pageData;
    if (pageData == null || pageData.items.isEmpty) {
      return Center(
        child: _StateCard(
          icon: Icons.search_off_rounded,
          title: 'No job analyses match the current filters',
          description:
              'Try clearing some filters or refreshing the dataset to capture a new pagination reference.',
          actionLabel: 'Refresh',
          onAction: () => _loadPage(resetReference: true, page: 1),
        ),
      );
    }

    final metadata = pageData.paginationMetadata;
    final pageNumbers = _buildVisiblePages(
      metadata.currentPage,
      metadata.totalPages,
    );

    return ListView.builder(
      itemCount: pageData.items.length + 1,
      itemBuilder: (context, index) {
        if (index == pageData.items.length) {
          return Column(
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: metadata.hasPreviousPage
                        ? () => _loadPage(page: metadata.currentPage - 1)
                        : null,
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                  for (final page in pageNumbers)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text('$page'),
                        selected: page == metadata.currentPage,
                        onSelected: (_) => _loadPage(page: page),
                      ),
                    ),
                  IconButton(
                    onPressed: metadata.hasNextPage
                        ? () => _loadPage(page: metadata.currentPage + 1)
                        : null,
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (metadata.hasNextPage)
                Align(
                  child: OutlinedButton.icon(
                    onPressed: () => _loadPage(page: metadata.currentPage + 1),
                    icon: const Icon(Icons.expand_more_rounded),
                    label: const Text('Load more'),
                  ),
                ),
            ],
          );
        }

        final analysis = pageData.items[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: JobAnalysisCard(
            analysis: analysis,
            isRefreshing: _refreshingCards.contains(analysis.id),
            onRefresh: analysis.id == null ? null : _refreshCard,
          ),
        );
      },
    );
  }

  List<Widget> _buildAppliedFilterChips() {
    final chips = <Widget>[];
    if (_filters.searchTerm?.isNotEmpty ?? false) {
      chips.add(_AppliedFilterChip(label: 'Search: ${_filters.searchTerm}'));
    }
    if (_filters.analysisFilter != JobAnalysisFilterMode.all) {
      chips.add(
        _AppliedFilterChip(
          label: _analysisFilterLabel(_filters.analysisFilter),
        ),
      );
    }
    if (_filters.hasQuestions != null) {
      chips.add(
        _AppliedFilterChip(
          label: _filters.hasQuestions! ? 'Has questions' : 'No questions',
        ),
      );
    }
    if (_filters.useScoreRange) {
      chips.add(
        _AppliedFilterChip(
          label:
              'Score ${_filters.minimumScorePercentage}-${_filters.maximumScorePercentage}%',
        ),
      );
    }
    if (_filters.maxAgeJobInfoHours != null) {
      chips.add(
        _AppliedFilterChip(label: 'Job ≤ ${_filters.maxAgeJobInfoHours}h old'),
      );
    }
    if (_filters.maxAgeScoringHours != null) {
      chips.add(
        _AppliedFilterChip(
          label: 'Scoring ≤ ${_filters.maxAgeScoringHours}h old',
        ),
      );
    }
    if (_filters.maxAgeAiResponsesHours != null) {
      chips.add(
        _AppliedFilterChip(
          label: 'AI responses ≤ ${_filters.maxAgeAiResponsesHours}h old',
        ),
      );
    }
    chips.add(
      _AppliedFilterChip(label: _orderByLabel(context, _filters.orderBy)),
    );
    return chips;
  }

  List<int> _buildVisiblePages(int currentPage, int totalPages) {
    if (totalPages <= 5) {
      return [for (var page = 1; page <= totalPages; page++) page];
    }

    final start = (currentPage - 2).clamp(1, totalPages - 4);
    return [for (var page = start; page < start + 5; page++) page];
  }

  Future<void> _applySearch() async {
    setState(() {
      _filters = _filters.copyWith(searchTerm: _searchController.text.trim());
    });
    await _loadPage(resetReference: true, page: 1);
  }

  Future<void> _openFiltersDialog() async {
    final nextFilters = await showDialog<_LocalJobAnalysisFilters>(
      context: context,
      builder: (context) => _FiltersDialog(initialFilters: _filters),
    );
    if (!mounted || nextFilters == null) {
      return;
    }

    setState(() {
      _filters = nextFilters;
    });
    await _persistFilters(nextFilters);
    if (!mounted) {
      return;
    }
    await _loadPage(resetReference: true, page: 1);
  }

  Future<void> _updateOrderBy(JobAnalysisOrderBy orderBy) async {
    final nextFilters = _filters.copyWith(orderBy: orderBy);
    setState(() {
      _filters = nextFilters;
    });
    await _persistFilters(nextFilters);
    if (!mounted) {
      return;
    }
    await _loadPage(resetReference: true, page: 1);
  }

  Future<void> _loadPage({bool resetReference = false, int? page}) async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });

    try {
      final request = JobAnalysisListFilter(
        page: page ?? _pageData?.paginationMetadata.currentPage ?? 1,
        pageSize: 12,
        analysisFilter: _filters.analysisFilter,
        orderBy: _filters.orderBy,
        referencePaginationHourStamp: resetReference
            ? null
            : _pageData?.paginationMetadata.referencePaginationHourStamp,
        searchTerm: (_filters.searchTerm?.isNotEmpty ?? false)
            ? _filters.searchTerm
            : null,
        hasQuestions: _filters.hasQuestions,
        minimumScorePercentage: _filters.useScoreRange
            ? _filters.minimumScorePercentage
            : null,
        maximumScorePercentage: _filters.useScoreRange
            ? _filters.maximumScorePercentage
            : null,
        maxAgeJobInfoHours: _filters.maxAgeJobInfoHours,
        maxAgeScoringHours: _filters.maxAgeScoringHours,
        maxAgeAiResponsesHours: _filters.maxAgeAiResponsesHours,
      );

      final pageData = await ref
          .read(clientProvider)
          .jobAnalysis
          .getPage(filter: request);
      if (!mounted) {
        return;
      }
      setState(() {
        _pageData = pageData;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loadError = error;
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshCard(int id) async {
    setState(() {
      _refreshingCards.add(id);
    });
    try {
      final updated = await ref
          .read(clientProvider)
          .jobAnalysis
          .refreshCard(jobAnalysisStateId: id);
      if (!mounted || _pageData == null) {
        return;
      }

      setState(() {
        _pageData = _pageData!.copyWith(
          items: [
            for (final item in _pageData!.items)
              if (item.id == id) updated else item,
          ],
        );
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      notifySnackbarWithContext(
        context,
        message: error.toString(),
        tone: AppNotificationTone.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _refreshingCards.remove(id);
        });
      }
    }
  }

  Future<void> _persistFilters(_LocalJobAnalysisFilters filters) async {
    final preferences = ref.read(sharedPreferencesProvider);
    final didPersist = await preferences.setString(
      _jobAnalysisListPreferencesKey,
      jsonEncode(filters.toPersistenceMap()),
    );
    if (!didPersist) {
      debugPrint('Unable to persist the job analysis list preferences.');
    }
  }

  _LocalJobAnalysisFilters _restorePersistedFilters() {
    final preferences = ref.read(sharedPreferencesProvider);
    final persistedValue = preferences.getString(
      _jobAnalysisListPreferencesKey,
    );
    if (persistedValue == null || persistedValue.isEmpty) {
      return const _LocalJobAnalysisFilters();
    }

    try {
      final decodedValue = jsonDecode(persistedValue);
      if (decodedValue is! Map) {
        unawaited(preferences.remove(_jobAnalysisListPreferencesKey));
        return const _LocalJobAnalysisFilters();
      }

      return _LocalJobAnalysisFilters.fromPersistenceMap(
        Map<String, dynamic>.from(decodedValue),
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Failed to restore the saved job analysis list preferences: '
        '$error\n$stackTrace',
      );
      unawaited(preferences.remove(_jobAnalysisListPreferencesKey));
      return const _LocalJobAnalysisFilters();
    }
  }
}

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
                  if (value == null) return;
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

class _OrderByMenu extends StatelessWidget {
  const _OrderByMenu({required this.current, required this.onSelected});

  final JobAnalysisOrderBy current;
  final ValueChanged<JobAnalysisOrderBy> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<JobAnalysisOrderBy>(
      onSelected: onSelected,
      itemBuilder: (context) => [
        for (final option in JobAnalysisOrderBy.values)
          PopupMenuItem(
            value: option,
            child: Text(_orderByLabel(context, option)),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.outline.withValues(alpha: 0.28),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.swap_vert_rounded),
            const SizedBox(width: 10),
            Text(_orderByLabel(context, current)),
            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }
}

class _AppliedFilterChip extends StatelessWidget {
  const _AppliedFilterChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}

class _StateCard extends StatelessWidget {
  const _StateCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 44,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.72),
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(actionLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocalJobAnalysisFilters {
  const _LocalJobAnalysisFilters({
    this.searchTerm,
    this.analysisFilter = JobAnalysisFilterMode.all,
    this.orderBy = JobAnalysisOrderBy.highestScore,
    this.hasQuestions,
    this.useScoreRange = false,
    this.minimumScorePercentage = 0,
    this.maximumScorePercentage = 100,
    this.maxAgeJobInfoHours,
    this.maxAgeScoringHours,
    this.maxAgeAiResponsesHours,
  });

  final String? searchTerm;
  final JobAnalysisFilterMode analysisFilter;
  final JobAnalysisOrderBy orderBy;
  final bool? hasQuestions;
  final bool useScoreRange;
  final int minimumScorePercentage;
  final int maximumScorePercentage;
  final int? maxAgeJobInfoHours;
  final int? maxAgeScoringHours;
  final int? maxAgeAiResponsesHours;

  Map<String, Object?> toPersistenceMap() {
    return {
      'analysisFilter': analysisFilter.toJson(),
      'orderBy': orderBy.toJson(),
      'hasQuestions': hasQuestions,
      'useScoreRange': useScoreRange,
      'minimumScorePercentage': minimumScorePercentage,
      'maximumScorePercentage': maximumScorePercentage,
      'maxAgeJobInfoHours': maxAgeJobInfoHours,
      'maxAgeScoringHours': maxAgeScoringHours,
      'maxAgeAiResponsesHours': maxAgeAiResponsesHours,
    };
  }

  factory _LocalJobAnalysisFilters.fromPersistenceMap(
    Map<String, dynamic> json,
  ) {
    return _LocalJobAnalysisFilters(
      analysisFilter: _jobAnalysisFilterModeFromJsonValue(
        json['analysisFilter'],
      ),
      orderBy: _jobAnalysisOrderByFromJsonValue(json['orderBy']),
      hasQuestions: json['hasQuestions'] as bool?,
      useScoreRange: json['useScoreRange'] as bool? ?? false,
      minimumScorePercentage:
          (json['minimumScorePercentage'] as num?)?.round() ?? 0,
      maximumScorePercentage:
          (json['maximumScorePercentage'] as num?)?.round() ?? 100,
      maxAgeJobInfoHours: (json['maxAgeJobInfoHours'] as num?)?.round(),
      maxAgeScoringHours: (json['maxAgeScoringHours'] as num?)?.round(),
      maxAgeAiResponsesHours: (json['maxAgeAiResponsesHours'] as num?)?.round(),
    );
  }

  _LocalJobAnalysisFilters copyWith({
    String? searchTerm,
    JobAnalysisFilterMode? analysisFilter,
    JobAnalysisOrderBy? orderBy,
    bool? hasQuestions,
    bool clearHasQuestions = false,
    bool? useScoreRange,
    int? minimumScorePercentage,
    int? maximumScorePercentage,
    int? maxAgeJobInfoHours,
    bool clearMaxAgeJobInfoHours = false,
    int? maxAgeScoringHours,
    bool clearMaxAgeScoringHours = false,
    int? maxAgeAiResponsesHours,
    bool clearMaxAgeAiResponsesHours = false,
  }) {
    return _LocalJobAnalysisFilters(
      searchTerm: searchTerm ?? this.searchTerm,
      analysisFilter: analysisFilter ?? this.analysisFilter,
      orderBy: orderBy ?? this.orderBy,
      hasQuestions: clearHasQuestions
          ? null
          : (hasQuestions ?? this.hasQuestions),
      useScoreRange: useScoreRange ?? this.useScoreRange,
      minimumScorePercentage:
          minimumScorePercentage ?? this.minimumScorePercentage,
      maximumScorePercentage:
          maximumScorePercentage ?? this.maximumScorePercentage,
      maxAgeJobInfoHours: clearMaxAgeJobInfoHours
          ? null
          : (maxAgeJobInfoHours ?? this.maxAgeJobInfoHours),
      maxAgeScoringHours: clearMaxAgeScoringHours
          ? null
          : (maxAgeScoringHours ?? this.maxAgeScoringHours),
      maxAgeAiResponsesHours: clearMaxAgeAiResponsesHours
          ? null
          : (maxAgeAiResponsesHours ?? this.maxAgeAiResponsesHours),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _LocalJobAnalysisFilters &&
        other.searchTerm == searchTerm &&
        other.analysisFilter == analysisFilter &&
        other.orderBy == orderBy &&
        other.hasQuestions == hasQuestions &&
        other.useScoreRange == useScoreRange &&
        other.minimumScorePercentage == minimumScorePercentage &&
        other.maximumScorePercentage == maximumScorePercentage &&
        other.maxAgeJobInfoHours == maxAgeJobInfoHours &&
        other.maxAgeScoringHours == maxAgeScoringHours &&
        other.maxAgeAiResponsesHours == maxAgeAiResponsesHours;
  }

  @override
  int get hashCode => Object.hash(
    searchTerm,
    analysisFilter,
    orderBy,
    hasQuestions,
    useScoreRange,
    minimumScorePercentage,
    maximumScorePercentage,
    maxAgeJobInfoHours,
    maxAgeScoringHours,
    maxAgeAiResponsesHours,
  );
}

JobAnalysisFilterMode _jobAnalysisFilterModeFromJsonValue(Object? value) {
  if (value is String) {
    try {
      return JobAnalysisFilterMode.fromJson(value);
    } on ArgumentError {
      return JobAnalysisFilterMode.all;
    }
  }

  return JobAnalysisFilterMode.all;
}

JobAnalysisOrderBy _jobAnalysisOrderByFromJsonValue(Object? value) {
  if (value is String) {
    try {
      return JobAnalysisOrderBy.fromJson(value);
    } on ArgumentError {
      return JobAnalysisOrderBy.highestScore;
    }
  }

  return JobAnalysisOrderBy.highestScore;
}

String _analysisFilterLabel(JobAnalysisFilterMode mode) {
  return switch (mode) {
    JobAnalysisFilterMode.all => 'All',
    JobAnalysisFilterMode.withoutScore => 'Without score',
    JobAnalysisFilterMode.withScore => 'With at least score generated',
    JobAnalysisFilterMode.withoutProposal => 'Without AI answers generated',
    JobAnalysisFilterMode.withProposal => 'With AI answers generated',
    JobAnalysisFilterMode.completed => 'Completed',
  };
}

String _orderByLabel(BuildContext context, JobAnalysisOrderBy orderBy) {
  final l10n = AppLocalizations.of(context);

  return switch (orderBy) {
    JobAnalysisOrderBy.highestScore => l10n.jobListOrderByHighestScore,
    JobAnalysisOrderBy.highestHourlyRate =>
      l10n.jobListOrderByHighestHourlyRate,
    JobAnalysisOrderBy.lowestHourlyRate => l10n.jobListOrderByLowestHourlyRate,
    JobAnalysisOrderBy.highestFixedPrice =>
      l10n.jobListOrderByHighestFixedPrice,
    JobAnalysisOrderBy.lowestFixedPrice => l10n.jobListOrderByLowestFixedPrice,
    JobAnalysisOrderBy.newestRelativeDate =>
      l10n.jobListOrderByNewestRelativeDate,
    JobAnalysisOrderBy.newestAbsoluteDate =>
      l10n.jobListOrderByNewestAbsoluteDate,
    JobAnalysisOrderBy.mostRecentJobInfoCreatedAt =>
      l10n.jobListOrderByNewestPersistedJobs,
    JobAnalysisOrderBy.mostRecentScoringCreatedAt =>
      l10n.jobListOrderByNewestGeneratedScores,
    JobAnalysisOrderBy.mostRecentAiResponsesCreatedAt =>
      l10n.jobListOrderByNewestAiResponses,
    JobAnalysisOrderBy.highestClientHireRate =>
      l10n.jobListOrderByHighestClientHireRate,
    JobAnalysisOrderBy.highestClientAverageHourlyRate =>
      l10n.jobListOrderByHighestClientAverageHourlyRate,
    JobAnalysisOrderBy.highestClientNameConfidence =>
      l10n.jobListOrderByHighestClientNameConfidence,
    JobAnalysisOrderBy.highestClientRating =>
      l10n.jobListOrderByHighestClientRating,
    JobAnalysisOrderBy.highestClientTotalSpent =>
      l10n.jobListOrderByHighestClientTotalSpent,
  };
}
