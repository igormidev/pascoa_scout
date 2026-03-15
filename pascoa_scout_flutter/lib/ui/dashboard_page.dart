import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/interactor/job_filter/current_filter_state.dart';
import 'package:pascoa_scout/interactor/job_filter/job_filter_providers.dart';
import 'package:pascoa_scout/ui/tabs/job_listage_tab.dart';
import 'package:pascoa_scout/ui/tabs/job_scrapper_config_tab.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final didAlreadyCreatedAInitialFilter = ref.watch(
      currentFilterNotifier.select(
        (state) =>
            state.maybeWhen(withFilter: (filter) => true, orElse: () => false),
      ),
    );
    final double settingsInitialSide = 990.0;
    final double sizeAfterSelectedInitial = 600.0;

    return Scaffold(
      //
      body: Stack(
        children: [
          const _ConfigBackground(),
          LayoutBuilder(
            builder: (context, constraints) {
              final double initialPaddingWhenNoFilter =
                  (constraints.maxWidth - settingsInitialSide) / 2;
              return Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: didAlreadyCreatedAInitialFilter
                        ? 0
                        : initialPaddingWhenNoFilter,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    width: didAlreadyCreatedAInitialFilter
                        ? sizeAfterSelectedInitial
                        : settingsInitialSide,
                    child: JobScrapperConfigTab(),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: didAlreadyCreatedAInitialFilter
                        ? (constraints.maxWidth - sizeAfterSelectedInitial)
                        : 0,
                    child: didAlreadyCreatedAInitialFilter
                        ? Row(
                            children: [
                              SizedBox(width: 2, child: VerticalDivider()),
                              Expanded(child: JobListageTab()),
                            ],
                          )
                        : null,
                  ),
                ],
              );
            },
          ),
        ],
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
