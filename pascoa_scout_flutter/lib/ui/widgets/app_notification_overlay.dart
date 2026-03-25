import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../interactor/app_notification/app_notification_providers.dart';

class AppNotificationOverlay extends ConsumerStatefulWidget {
  const AppNotificationOverlay({super.key});

  @override
  ConsumerState<AppNotificationOverlay> createState() =>
      _AppNotificationOverlayState();
}

class _AppNotificationOverlayState
    extends ConsumerState<AppNotificationOverlay> {
  static const _animationDuration = Duration(milliseconds: 260);

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<AppNotificationEntry> _entries = <AppNotificationEntry>[];
  ProviderSubscription<List<AppNotificationEntry>>? _subscription;

  @override
  void initState() {
    super.initState();
    _entries.addAll(ref.read(appNotificationControllerProvider));
    _subscription = ref.listenManual<List<AppNotificationEntry>>(
      appNotificationControllerProvider,
      (previous, next) => _syncEntries(next),
    );
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: AnimatedList(
                key: _listKey,
                shrinkWrap: true,
                initialItemCount: _entries.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index, animation) {
                  return _buildAnimatedEntry(_entries[index], animation);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _syncEntries(List<AppNotificationEntry> nextEntries) {
    final nextIds = nextEntries.map((entry) => entry.id).toSet();

    for (var index = _entries.length - 1; index >= 0; index--) {
      final currentEntry = _entries[index];
      if (nextIds.contains(currentEntry.id)) {
        continue;
      }

      final removedEntry = _entries.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) =>
            _buildAnimatedEntry(removedEntry, animation, isRemoving: true),
        duration: _animationDuration,
      );
    }

    for (var index = 0; index < nextEntries.length; index++) {
      final nextEntry = nextEntries[index];
      final existingIndex = _entries.indexWhere(
        (entry) => entry.id == nextEntry.id,
      );

      if (existingIndex == -1) {
        _entries.insert(index, nextEntry);
        _listKey.currentState?.insertItem(index, duration: _animationDuration);
        continue;
      }

      _entries[existingIndex] = nextEntry;
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildAnimatedEntry(
    AppNotificationEntry entry,
    Animation<double> animation, {
    bool isRemoving = false,
  }) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return SizeTransition(
      sizeFactor: curvedAnimation,
      axisAlignment: 1,
      child: FadeTransition(
        opacity: curvedAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.24),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: Padding(
            padding: EdgeInsets.only(bottom: isRemoving ? 0 : 10),
            child: AppNotificationCard(entry: entry),
          ),
        ),
      ),
    );
  }
}

class AppNotificationCard extends StatelessWidget {
  const AppNotificationCard({super.key, required this.entry});

  final AppNotificationEntry entry;

  @override
  Widget build(BuildContext context) {
    final palette = _paletteFor(entry.tone);
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: palette.backgroundColor,
        elevation: 14,
        shadowColor: Colors.black.withValues(alpha: 0.24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: palette.borderColor),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(palette.icon, color: palette.iconColor, size: 20),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    entry.message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: palette.textColor,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _AppNotificationPalette _paletteFor(AppNotificationTone tone) {
    return switch (tone) {
      AppNotificationTone.success => const _AppNotificationPalette(
        icon: Icons.check_circle_rounded,
        backgroundColor: Color(0xFF143328),
        borderColor: Color(0x565EE9B5),
        iconColor: Color(0xFF5EE9B5),
        textColor: Color(0xFFE2FFF4),
      ),
      AppNotificationTone.info => const _AppNotificationPalette(
        icon: Icons.info_rounded,
        backgroundColor: Color(0xFF102A30),
        borderColor: Color(0x566EE7F9),
        iconColor: Color(0xFF6EE7F9),
        textColor: Color(0xFFE8FCFF),
      ),
      AppNotificationTone.error => const _AppNotificationPalette(
        icon: Icons.error_outline_rounded,
        backgroundColor: Color(0xFF34191C),
        borderColor: Color(0x52FF7B72),
        iconColor: Color(0xFFFFB4AC),
        textColor: Color(0xFFFFDAD6),
      ),
    };
  }
}

class _AppNotificationPalette {
  const _AppNotificationPalette({
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
}
