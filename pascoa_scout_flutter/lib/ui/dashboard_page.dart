import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/interactor/job_filter/current_filter_state.dart';
import 'package:pascoa_scout/interactor/job_filter/job_filter_providers.dart';
import 'package:pascoa_scout/interactor/job_knowledge/job_knowledge_providers.dart';
import 'package:pascoa_scout/ui/job_knowledge_onboarding_flow.dart';
import 'package:pascoa_scout/ui/tabs/job_listage_tab.dart';
import 'package:pascoa_scout/ui/tabs/job_scrapper_workspace_tab.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  static const double _centeredConfigMaxWidth = 990.0;
  static const double _splitConfigMaxWidth = 600.0;
  static const double _paneGap = 24.0;
  static const double _splitLayoutMinWidth = 1100.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final knowledgeSummaryAsync = ref.watch(jobKnowledgeSummaryProvider);
    final hasSavedFilter = ref.watch(
      currentFilterNotifier.select(
        (state) =>
            state.maybeWhen(withFilter: (filter) => true, orElse: () => false),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          const _ConfigBackground(),
          SafeArea(
            child: knowledgeSummaryAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 44,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Unable to load app state',
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            error.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton.icon(
                            onPressed: () =>
                                ref.invalidate(jobKnowledgeSummaryProvider),
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              data: (summary) {
                final needsOnboarding =
                    !summary.hasCurriculum ||
                    !summary.hasProposalStylePreference ||
                    !summary.hasOpportunityPreference;
                if (needsOnboarding) {
                  return const JobKnowledgeOnboardingFlow();
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isSplitLayout =
                        hasSavedFilter &&
                        constraints.maxWidth >= _splitLayoutMinWidth;
                    final splitConfigWidth = (constraints.maxWidth * 0.42)
                        .clamp(460.0, _splitConfigMaxWidth)
                        .toDouble();

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 420),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        final slideAnimation = Tween<Offset>(
                          begin: const Offset(0.0, 0.03),
                          end: Offset.zero,
                        ).animate(animation);

                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: slideAnimation,
                            child: child,
                          ),
                        );
                      },
                      child: isSplitLayout
                          ? _SplitDashboardLayout(
                              key: const ValueKey('dashboard-split-layout'),
                              configWidth: splitConfigWidth,
                            )
                          : _StackedDashboardLayout(
                              key: ValueKey(
                                hasSavedFilter
                                    ? 'dashboard-stacked-layout'
                                    : 'dashboard-centered-layout',
                              ),
                              showJobs: hasSavedFilter,
                              centerConfig: !hasSavedFilter,
                            ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SplitDashboardLayout extends StatelessWidget {
  const _SplitDashboardLayout({super.key, required this.configWidth});

  final double configWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: configWidth, child: const JobScrapperWorkspaceTab()),

        SizedBox(
          width: DashboardPage._paneGap,
          child: Center(
            child: Container(
              width: 1.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              color: theme.colorScheme.outline.withValues(alpha: 0.18),
            ),
          ),
        ),
        const Expanded(child: JobListageTab()),
      ],
    );
  }
}

class _StackedDashboardLayout extends StatelessWidget {
  const _StackedDashboardLayout({
    super.key,
    required this.showJobs,
    required this.centerConfig,
  });

  final bool showJobs;
  final bool centerConfig;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: showJobs ? 5 : 1,
          child: Align(
            alignment: centerConfig ? Alignment.topCenter : Alignment.topLeft,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: DashboardPage._centeredConfigMaxWidth,
              ),
              child: const JobScrapperWorkspaceTab(),
            ),
          ),
        ),
        if (showJobs) ...[
          const SizedBox(height: DashboardPage._paneGap),
          const Expanded(flex: 6, child: JobListageTab()),
        ],
      ],
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
