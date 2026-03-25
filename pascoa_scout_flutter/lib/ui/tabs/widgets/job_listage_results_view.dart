import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_card.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

const _jobListageToolbarExtent = 118.0;
const _jobListagePaginationSpacerHeight = 92.0;

class JobListageResultsView extends StatefulWidget {
  const JobListageResultsView({
    super.key,
    required this.header,
    required this.toolbar,
    required this.appliedFilters,
    required this.hasAppliedFilters,
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

  final Widget header;
  final Widget toolbar;
  final Widget appliedFilters;
  final bool hasAppliedFilters;
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
  State<JobListageResultsView> createState() => _JobListageResultsViewState();
}

class _JobListageResultsViewState extends State<JobListageResultsView> {
  bool _showPaginationPill = true;

  bool get _hasPagination {
    final metadata = widget.pageData?.paginationMetadata;
    if (metadata == null) {
      return false;
    }

    return metadata.totalPages > 1;
  }

  bool _handleUserScroll(UserScrollNotification notification) {
    final shouldShow = switch (notification.direction) {
      ScrollDirection.forward => true,
      ScrollDirection.reverse => false,
      ScrollDirection.idle => notification.metrics.pixels <= 0,
    };

    if (shouldShow != _showPaginationPill) {
      setState(() {
        _showPaginationPill = shouldShow;
      });
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.pageData;
    final metadata = data?.paginationMetadata;
    final hasPagination = _hasPagination;
    final pageNumbers = metadata == null
        ? const <int>[]
        : widget.visiblePagesBuilder(metadata.currentPage, metadata.totalPages);

    return Stack(
      children: [
        NotificationListener<UserScrollNotification>(
          onNotification: _handleUserScroll,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: widget.header),
              SliverPersistentHeader(
                floating: true,
                delegate: _JobListageFloatingToolbarDelegate(
                  child: widget.toolbar,
                ),
              ),
              if (widget.hasAppliedFilters) ...[
                SliverToBoxAdapter(child: widget.appliedFilters),
                const SliverToBoxAdapter(child: SizedBox(height: 18)),
              ] else
                const SliverToBoxAdapter(child: SizedBox(height: 18)),
              if (widget.isLoading && data == null)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (widget.loadError != null && data == null)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: _StateCard(
                      icon: Icons.error_outline_rounded,
                      title: 'Unable to load job analyses',
                      description: widget.loadError.toString(),
                      actionLabel: 'Retry',
                      onAction: widget.onRetry,
                    ),
                  ),
                )
              else if (data == null || data.items.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: _StateCard(
                      icon: Icons.search_off_rounded,
                      title: 'No job analyses match the current filters',
                      description:
                          'Try clearing some filters or refreshing the dataset to capture a new pagination reference.',
                      actionLabel: 'Refresh',
                      onAction: widget.onRefreshEmptyState,
                    ),
                  ),
                )
              else
                SliverList.builder(
                  itemCount: data.items.length + 1,
                  itemBuilder: (context, index) {
                    if (index == data.items.length) {
                      return SizedBox(
                        height: hasPagination
                            ? _jobListagePaginationSpacerHeight
                            : 24,
                      );
                    }

                    final analysis = data.items[index];
                    final isLastCard = index == data.items.length - 1;

                    return Padding(
                      padding: EdgeInsets.only(bottom: isLastCard ? 0 : 16),
                      child: JobAnalysisCard(
                        analysis: analysis,
                        isRefreshing: widget.refreshingCards.contains(
                          analysis.id,
                        ),
                        onRefresh: analysis.id == null
                            ? null
                            : widget.onRefreshCard,
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
        if (hasPagination && metadata != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              ignoring: !_showPaginationPill,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Center(
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      offset: _showPaginationPill
                          ? Offset.zero
                          : const Offset(0, 1.25),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        opacity: _showPaginationPill ? 1 : 0,
                        child: _PaginationPill(
                          currentPage: metadata.currentPage,
                          hasNextPage: metadata.hasNextPage,
                          hasPreviousPage: metadata.hasPreviousPage,
                          onLoadPage: widget.onLoadPage,
                          pageNumbers: pageNumbers,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _JobListageFloatingToolbarDelegate
    extends SliverPersistentHeaderDelegate {
  const _JobListageFloatingToolbarDelegate({required this.child});

  final Widget child;

  @override
  double get minExtent => _jobListageToolbarExtent;

  @override
  double get maxExtent => _jobListageToolbarExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(alignment: Alignment.topCenter, child: child),
    );
  }

  @override
  bool shouldRebuild(covariant _JobListageFloatingToolbarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}

class _PaginationPill extends StatelessWidget {
  const _PaginationPill({
    required this.currentPage,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.onLoadPage,
    required this.pageNumbers,
  });

  final int currentPage;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final ValueChanged<int> onLoadPage;
  final List<int> pageNumbers;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 58, maxHeight: 58),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: colorScheme.surface.withValues(alpha: 0.96),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.22),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PaginationArrowButton(
                icon: Icons.chevron_left_rounded,
                isEnabled: hasPreviousPage,
                onTap: () => onLoadPage(currentPage - 1),
              ),
              const SizedBox(width: 6),
              for (final page in pageNumbers) ...[
                _PaginationPageButton(
                  isSelected: page == currentPage,
                  label: '$page',
                  onTap: () => onLoadPage(page),
                ),
                if (page != pageNumbers.last) const SizedBox(width: 6),
              ],
              const SizedBox(width: 6),
              _PaginationArrowButton(
                icon: Icons.chevron_right_rounded,
                isEnabled: hasNextPage,
                onTap: () => onLoadPage(currentPage + 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaginationArrowButton extends StatelessWidget {
  const _PaginationArrowButton({
    required this.icon,
    required this.isEnabled,
    required this.onTap,
  });

  final IconData icon;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: isEnabled ? onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isEnabled
                ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.68)
                : colorScheme.surfaceContainerHighest.withValues(alpha: 0.24),
          ),
          child: Icon(
            icon,
            color: isEnabled
                ? colorScheme.onSurface
                : colorScheme.onSurface.withValues(alpha: 0.32),
          ),
        ),
      ),
    );
  }
}

class _PaginationPageButton extends StatelessWidget {
  const _PaginationPageButton({
    required this.isSelected,
    required this.label,
    required this.onTap,
  });

  final bool isSelected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: isSelected ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.18)
                : Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.86),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
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
