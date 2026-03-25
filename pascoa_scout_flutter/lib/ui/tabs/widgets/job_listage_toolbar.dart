import 'package:flutter/material.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

class JobListageToolbar extends StatelessWidget {
  const JobListageToolbar({
    super.key,
    required this.searchController,
    required this.currentOrderBy,
    required this.onRefresh,
    required this.onSearchSubmitted,
    required this.onClearSearch,
    required this.onOpenFilters,
    required this.onOrderBySelected,
    required this.orderByLabelBuilder,
  });

  final TextEditingController searchController;
  final JobAnalysisOrderBy currentOrderBy;
  final VoidCallback onRefresh;
  final Future<void> Function() onSearchSubmitted;
  final VoidCallback onClearSearch;
  final Future<void> Function() onOpenFilters;
  final ValueChanged<JobAnalysisOrderBy> onOrderBySelected;
  final String Function(JobAnalysisOrderBy orderBy) orderByLabelBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 2,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText:
                                'Search job titles, descriptions, or client names',
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => onSearchSubmitted(),
                        ),
                      ),
                      ListenableBuilder(
                        listenable: searchController,
                        builder: (context, _) {
                          if (searchController.text.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return IconButton(
                            onPressed: onClearSearch,
                            icon: const Icon(Icons.close_rounded),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton.filledTonal(
              tooltip: 'Refresh current filters',
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: onOpenFilters,
              icon: const Icon(Icons.filter_alt_rounded),
              label: const Text('Filters'),
            ),
            const Spacer(),
            _OrderByMenu(
              current: currentOrderBy,
              onSelected: onOrderBySelected,
              orderByLabelBuilder: orderByLabelBuilder,
            ),
          ],
        ),
      ],
    );
  }
}

class _OrderByMenu extends StatelessWidget {
  const _OrderByMenu({
    required this.current,
    required this.onSelected,
    required this.orderByLabelBuilder,
  });

  final JobAnalysisOrderBy current;
  final ValueChanged<JobAnalysisOrderBy> onSelected;
  final String Function(JobAnalysisOrderBy orderBy) orderByLabelBuilder;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<JobAnalysisOrderBy>(
      onSelected: onSelected,
      itemBuilder: (context) => [
        for (final option in JobAnalysisOrderBy.values)
          PopupMenuItem(
            value: option,
            child: Text(orderByLabelBuilder(option)),
          ),
      ],
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.outline.withValues(alpha: 0.28),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.swap_vert_rounded),
            const SizedBox(width: 10),
            Text(orderByLabelBuilder(current)),
            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }
}
