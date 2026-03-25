import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout/interactor/app_notification/app_notification_providers.dart';
import 'package:pascoa_scout/interactor/job_analysis_selection/selected_job_analysis_provider.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_listage_applied_filters.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_formatters.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_listage_results_view.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_listage_toolbar.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

part 'widgets/job_listage_filters_dialog.dart';

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
    final selectedAnalysis = ref.watch(selectedJobAnalysisProvider);
    final appliedFilterLabels = <String>[
      if (_filters.searchTerm?.isNotEmpty ?? false)
        'Search: ${_filters.searchTerm}',
      if (_filters.analysisFilter != JobAnalysisFilterMode.all)
        _analysisFilterLabel(_filters.analysisFilter),
      if (_filters.hasQuestions != null)
        _filters.hasQuestions! ? 'Has questions' : 'No questions',
      if (_filters.useScoreRange)
        'Score ${_filters.minimumScorePercentage}-${_filters.maximumScorePercentage}%',
      if (_filters.maxAgeJobInfoHours != null)
        'Job ≤ ${_filters.maxAgeJobInfoHours}h old',
      if (_filters.maxAgeScoringHours != null)
        'Scoring ≤ ${_filters.maxAgeScoringHours}h old',
      if (_filters.maxAgeAiResponsesHours != null)
        'AI responses ≤ ${_filters.maxAgeAiResponsesHours}h old',
      _orderByLabel(context, _filters.orderBy),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: JobListageResultsView(
        header: Padding(
          padding: const EdgeInsets.only(top: 28),
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
            ],
          ),
        ),
        toolbar: JobListageToolbar(
          searchController: _searchController,
          currentOrderBy: _filters.orderBy,
          onRefresh: () => _refreshList(resetReference: true, page: 1),
          onSearchSubmitted: _applySearch,
          onClearSearch: () {
            _searchController.clear();
            _applySearch();
          },
          onOpenFilters: _openFiltersDialog,
          onOrderBySelected: (orderBy) => unawaited(_updateOrderBy(orderBy)),
          orderByLabelBuilder: (orderBy) => _orderByLabel(context, orderBy),
        ),
        appliedFilters: JobListageAppliedFilters(labels: appliedFilterLabels),
        hasAppliedFilters: appliedFilterLabels.isNotEmpty,
        isLoading: _isLoading,
        loadError: _loadError,
        pageData: _pageData,
        visiblePagesBuilder: _buildVisiblePages,
        refreshingCards: _refreshingCards,
        selectedAnalysis: selectedAnalysis,
        onRetry: () => _refreshList(resetReference: true),
        onRefreshEmptyState: () => _refreshList(resetReference: true, page: 1),
        onLoadPage: (page) => _loadPage(page: page),
        onRefreshCard: _refreshCard,
        onSelectAnalysis: _selectAnalysis,
      ),
    );
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
    await _refreshList(resetReference: true, page: 1);
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
    await _refreshList(resetReference: true, page: 1);
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
    await _refreshList(resetReference: true, page: 1);
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
      ref
          .read(selectedJobAnalysisProvider.notifier)
          .syncWithVisibleItems(pageData.items);
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
      final updatedFuture = ref
          .read(clientProvider)
          .jobAnalysis
          .refreshCard(jobAnalysisStateId: id);
      final updated = await Future.wait<Object?>([
        updatedFuture,
        Future<void>.delayed(const Duration(milliseconds: 500)),
      ]).then((values) => values.first as JobAnalysisState);
      if (!mounted || _pageData == null) {
        return;
      }

      ref.read(selectedJobAnalysisProvider.notifier).update(updated);
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

  Future<void> _refreshList({bool resetReference = false, int? page}) async {
    _clearSelectedAnalysis();
    await _loadPage(resetReference: resetReference, page: page);
  }

  void _selectAnalysis(JobAnalysisState analysis) {
    final notifier = ref.read(selectedJobAnalysisProvider.notifier);
    final selectedAnalysis = ref.read(selectedJobAnalysisProvider);
    if (selectedAnalysis != null &&
        isSameJobAnalysis(selectedAnalysis, analysis)) {
      return;
    }

    notifier.select(analysis);
  }

  void _clearSelectedAnalysis() {
    ref.read(selectedJobAnalysisProvider.notifier).clear();
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
