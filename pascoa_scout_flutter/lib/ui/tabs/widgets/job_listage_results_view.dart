import 'package:flutter/material.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_card.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

class JobListageResultsView extends StatelessWidget {
  const JobListageResultsView({
    super.key,
    required this.isLoading,
    required this.loadError,
    required this.pageData,
    required this.visiblePagesBuilder,
    required this.refreshingCards,
    required this.onRetry,
    required this.onRefreshEmptyState,
    required this.onLoadPage,
    required this.onRefreshCard,
  });

  final bool isLoading;
  final Object? loadError;
  final JobAnalysisPagination? pageData;
  final List<int> Function(int currentPage, int totalPages) visiblePagesBuilder;
  final Set<int> refreshingCards;
  final VoidCallback onRetry;
  final VoidCallback onRefreshEmptyState;
  final ValueChanged<int> onLoadPage;
  final Future<void> Function(int id) onRefreshCard;

  @override
  Widget build(BuildContext context) {
    if (isLoading && pageData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (loadError != null && pageData == null) {
      return Center(
        child: _StateCard(
          icon: Icons.error_outline_rounded,
          title: 'Unable to load job analyses',
          description: loadError.toString(),
          actionLabel: 'Retry',
          onAction: onRetry,
        ),
      );
    }

    final data = pageData;
    if (data == null || data.items.isEmpty) {
      return Center(
        child: _StateCard(
          icon: Icons.search_off_rounded,
          title: 'No job analyses match the current filters',
          description:
              'Try clearing some filters or refreshing the dataset to capture a new pagination reference.',
          actionLabel: 'Refresh',
          onAction: onRefreshEmptyState,
        ),
      );
    }

    final metadata = data.paginationMetadata;
    final pageNumbers = visiblePagesBuilder(
      metadata.currentPage,
      metadata.totalPages,
    );

    return ListView.builder(
      itemCount: data.items.length + 1,
      itemBuilder: (context, index) {
        if (index == data.items.length) {
          return Column(
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: metadata.hasPreviousPage
                        ? () => onLoadPage(metadata.currentPage - 1)
                        : null,
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                  for (final page in pageNumbers)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text('$page'),
                        selected: page == metadata.currentPage,
                        onSelected: (_) => onLoadPage(page),
                      ),
                    ),
                  IconButton(
                    onPressed: metadata.hasNextPage
                        ? () => onLoadPage(metadata.currentPage + 1)
                        : null,
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (metadata.hasNextPage)
                Align(
                  child: OutlinedButton.icon(
                    onPressed: () => onLoadPage(metadata.currentPage + 1),
                    icon: const Icon(Icons.expand_more_rounded),
                    label: const Text('Load more'),
                  ),
                ),
            ],
          );
        }

        final analysis = data.items[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: JobAnalysisCard(
            analysis: analysis,
            isRefreshing: refreshingCards.contains(analysis.id),
            onRefresh: analysis.id == null ? null : onRefreshCard,
          ),
        );
      },
    );
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
