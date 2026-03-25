import 'package:flutter/material.dart';

class AppNotificationAnimatedEntry extends StatelessWidget {
  const AppNotificationAnimatedEntry({
    super.key,
    required this.animation,
    required this.child,
    this.isRemoving = false,
  });

  final Animation<double> animation;
  final Widget child;
  final bool isRemoving;

  @override
  Widget build(BuildContext context) {
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
            child: child,
          ),
        ),
      ),
    );
  }
}
