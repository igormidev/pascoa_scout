import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/interactor/job_analysis_selection/selected_job_analysis_provider.dart';
import 'package:pascoa_scout/ui/tabs/job_scrapper_config_tab.dart';
import 'package:pascoa_scout/ui/tabs/widgets/job_analysis_detail_panel.dart';

class JobScrapperWorkspaceTab extends ConsumerWidget {
  const JobScrapperWorkspaceTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAnalysis = ref.watch(selectedJobAnalysisProvider);
    final hasSelection = selectedAnalysis != null;

    return Stack(
      children: [
        IgnorePointer(
          ignoring: hasSelection,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            opacity: hasSelection ? 0 : 1,
            child: const JobScrapperConfigTab(),
          ),
        ),
        IgnorePointer(
          ignoring: !hasSelection,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            opacity: hasSelection ? 1 : 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              offset: hasSelection ? Offset.zero : const Offset(0.0, 0.02),
              child: selectedAnalysis == null
                  ? const SizedBox.expand()
                  : JobAnalysisDetailPanel(
                      analysis: selectedAnalysis,
                      onBack: () => ref
                          .read(selectedJobAnalysisProvider.notifier)
                          .clear(),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
