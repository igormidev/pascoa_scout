import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/interactor/job_listage/job_listage_live_refresh_preferences.dart';
import 'package:pascoa_scout/interactor/job_sync/job_sync_providers.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';

class JobListLiveRefreshSettingCard extends ConsumerWidget {
  const JobListLiveRefreshSettingCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final preferences = ref.watch(jobListageLiveRefreshPreferencesProvider);
    final isLocked = ref.watch(
      jobSyncControllerProvider.select((state) => state.isLocked),
    );
    final controller = ref.read(
      jobListageLiveRefreshPreferencesProvider.notifier,
    );

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 220),
      opacity: isLocked ? 0.48 : 1.0,
      child: _LiveRefreshSettingSurface(
        title: l10n.jobListLiveRefreshSettingTitle,
        description: preferences.isEnabled
            ? l10n.jobListLiveRefreshSettingEnabledDescription(
                preferences.intervalSeconds,
              )
            : l10n.jobListLiveRefreshSettingDisabledDescription,
        toggleLabel: l10n.jobListLiveRefreshSettingToggle,
        isChecked: preferences.isEnabled,
        isLocked: isLocked,
        onToggleChanged: isLocked
            ? null
            : (isChecked) => unawaited(controller.setEnabled(isChecked)),
        value: preferences.intervalSeconds,
        onDecrease:
            isLocked ||
                !preferences.isEnabled ||
                preferences.intervalSeconds <= 10
            ? null
            : () => unawaited(
                controller.setIntervalSeconds(preferences.intervalSeconds - 10),
              ),
        onIncrease: isLocked || !preferences.isEnabled
            ? null
            : () => unawaited(
                controller.setIntervalSeconds(preferences.intervalSeconds + 10),
              ),
      ),
    );
  }
}

class _LiveRefreshSettingSurface extends StatelessWidget {
  const _LiveRefreshSettingSurface({
    required this.title,
    required this.description,
    required this.toggleLabel,
    required this.isChecked,
    required this.isLocked,
    required this.onToggleChanged,
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  });

  final String title;
  final String description;
  final String toggleLabel;
  final bool isChecked;
  final bool isLocked;
  final ValueChanged<bool>? onToggleChanged;
  final int value;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.0),
        color: Colors.white.withValues(alpha: 0.03),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.36),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final useHorizontalLayout = constraints.maxWidth >= 760.0;
          final copy = _LiveRefreshCopyBlock(
            title: title,
            description: description,
            isChecked: isChecked,
          );
          final controls = _LiveRefreshControls(
            toggleLabel: toggleLabel,
            isChecked: isChecked,
            isLocked: isLocked,
            onToggleChanged: onToggleChanged,
            value: value,
            onDecrease: onDecrease,
            onIncrease: onIncrease,
          );

          if (useHorizontalLayout) {
            return Row(
              children: [
                Expanded(child: copy),
                const SizedBox(width: 20.0),
                controls,
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [copy, const SizedBox(height: 14.0), controls],
          );
        },
      ),
    );
  }
}

class _LiveRefreshCopyBlock extends StatelessWidget {
  const _LiveRefreshCopyBlock({
    required this.title,
    required this.description,
    required this.isChecked,
  });

  final String title;
  final String description;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = isChecked
        ? theme.colorScheme.primary
        : Colors.white.withValues(alpha: 0.34);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor,
                boxShadow: [
                  if (isChecked)
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.35),
                      blurRadius: 16.0,
                      spreadRadius: 1.0,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Flexible(
              child: Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            height: 1.3,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _LiveRefreshControls extends StatelessWidget {
  const _LiveRefreshControls({
    required this.toggleLabel,
    required this.isChecked,
    required this.isLocked,
    required this.onToggleChanged,
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  });

  final String toggleLabel;
  final bool isChecked;
  final bool isLocked;
  final ValueChanged<bool>? onToggleChanged;
  final int value;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 10.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(toggleLabel),
            const SizedBox(width: 8.0),
            Switch.adaptive(
              value: isChecked,
              onChanged: onToggleChanged == null
                  ? null
                  : (nextValue) => onToggleChanged!(nextValue),
            ),
          ],
        ),
        _LiveRefreshStepper(
          value: value,
          enabled: isChecked && !isLocked,
          onDecrease: onDecrease,
          onIncrease: onIncrease,
        ),
      ],
    );
  }
}

class _LiveRefreshStepper extends StatelessWidget {
  const _LiveRefreshStepper({
    required this.value,
    required this.enabled,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int value;
  final bool enabled;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: enabled ? 1.0 : 0.42,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999.0),
          color: Colors.white.withValues(alpha: 0.055),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepperButton(icon: Icons.remove_rounded, onPressed: onDecrease),
            const SizedBox(width: 2.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 16.0,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    '$value',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 2.0),
            _StepperButton(icon: Icons.add_rounded, onPressed: onIncrease),
          ],
        ),
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: onPressed == null
              ? theme.disabledColor
              : theme.colorScheme.secondary,
        ),
        icon: Icon(icon),
      ),
    );
  }
}
