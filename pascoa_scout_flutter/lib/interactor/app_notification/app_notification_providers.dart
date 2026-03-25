import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appNotificationControllerProvider =
    NotifierProvider<AppNotificationController, List<AppNotificationEntry>>(
      AppNotificationController.new,
    );

enum AppNotificationTone { success, info, error }

@immutable
class AppNotificationEntry {
  const AppNotificationEntry({
    required this.id,
    required this.message,
    required this.tone,
    required this.createdAt,
  });

  final String id;
  final String message;
  final AppNotificationTone tone;
  final DateTime createdAt;
}

class AppNotificationController extends Notifier<List<AppNotificationEntry>> {
  final Map<String, Timer> _timers = <String, Timer>{};
  int _counter = 0;

  @override
  List<AppNotificationEntry> build() {
    ref.onDispose(_dispose);
    return const <AppNotificationEntry>[];
  }

  void notifySnackbar({
    required String message,
    AppNotificationTone tone = AppNotificationTone.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    final trimmedMessage = message.trim();
    if (trimmedMessage.isEmpty) {
      return;
    }

    final id =
        'app-notification-${DateTime.now().microsecondsSinceEpoch}-${_counter++}';
    final entry = AppNotificationEntry(
      id: id,
      message: trimmedMessage,
      tone: tone,
      createdAt: DateTime.now(),
    );

    state = <AppNotificationEntry>[...state, entry];
    _timers[id] = Timer(duration, () => dismiss(id));
  }

  void dismiss(String id) {
    _timers.remove(id)?.cancel();
    state = <AppNotificationEntry>[
      for (final entry in state)
        if (entry.id != id) entry,
    ];
  }

  void clear() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    state = const <AppNotificationEntry>[];
  }

  void _dispose() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
  }
}

extension AppNotificationRefExtension on Ref {
  void notifySnackbar(
    String message, {
    AppNotificationTone tone = AppNotificationTone.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    read(
      appNotificationControllerProvider.notifier,
    ).notifySnackbar(message: message, tone: tone, duration: duration);
  }
}

extension AppNotificationWidgetRefExtension on WidgetRef {
  void notifySnackbar(
    String message, {
    AppNotificationTone tone = AppNotificationTone.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    read(
      appNotificationControllerProvider.notifier,
    ).notifySnackbar(message: message, tone: tone, duration: duration);
  }
}

void notifySnackbarWithContext(
  BuildContext context, {
  required String message,
  AppNotificationTone tone = AppNotificationTone.success,
  Duration duration = const Duration(seconds: 3),
}) {
  ProviderScope.containerOf(context, listen: false)
      .read(appNotificationControllerProvider.notifier)
      .notifySnackbar(message: message, tone: tone, duration: duration);
}
