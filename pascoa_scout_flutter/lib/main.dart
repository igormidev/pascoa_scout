import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/l10n/generated/app_localizations.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout/ui/dashboard_page.dart';
import 'package:pascoa_scout/ui/widgets/app_notification_overlay.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final Client client = Client(
    'http://localhost:8080/',
    connectionTimeout: Duration(minutes: 2),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  final pref = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(client),
        sharedPreferencesProvider.overrideWithValue(pref),
      ],
      child: const PascoaScoutApp(),
    ),
  );
}

class PascoaScoutApp extends StatelessWidget {
  const PascoaScoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xFF12D39A),
        ).copyWith(
          primary: const Color(0xFF3CE9B2),
          secondary: const Color(0xFF6EE7F9),
          surface: const Color(0xFF13231E),
          surfaceContainerHighest: const Color(0xFF1A2F28),
          outline: const Color(0xFF44685C),
        );

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(22.0),
      borderSide: BorderSide(
        color: colorScheme.outline.withValues(alpha: 0.44),
      ),
    );

    return MaterialApp(
      title: 'Pascoa Scout',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFF071411),
        cardColor: colorScheme.surface,
        textTheme: ThemeData.dark().textTheme.copyWith(
          headlineLarge: const TextStyle(
            fontSize: 38.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.1,
          ),
          headlineMedium: const TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
          ),
          titleLarge: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: const TextStyle(fontSize: 15.0, height: 1.45),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF10201B),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 18.0,
          ),
          border: outlineBorder,
          enabledBorder: outlineBorder,
          focusedBorder: outlineBorder.copyWith(
            borderSide: BorderSide(color: colorScheme.primary, width: 1.6),
          ),
          errorBorder: outlineBorder.copyWith(
            borderSide: const BorderSide(color: Color(0xFFFF7B72), width: 1.4),
          ),
          focusedErrorBorder: outlineBorder.copyWith(
            borderSide: const BorderSide(color: Color(0xFFFF7B72), width: 1.8),
          ),
          labelStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.88),
            fontWeight: FontWeight.w600,
          ),
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.42)),
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: BorderSide(color: colorScheme.outline, width: 1.3),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.primary;
            }
            return colorScheme.surfaceContainerHighest;
          }),
          checkColor: const WidgetStatePropertyAll(Color(0xFF04110D)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: const Color(0xFF02120D),
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 18.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            textStyle: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 18.0,
            ),
            side: BorderSide(color: colorScheme.outline),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            textStyle: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: colorScheme.surface.withValues(alpha: 0.94),
          elevation: 0.0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
            side: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.32),
            ),
          ),
        ),
      ),
      builder: (context, child) {
        return Stack(
          children: [
            ...(child != null ? [child] : const <Widget>[]),
            const AppNotificationOverlay(),
          ],
        );
      },
      home: const DashboardPage(),
    );
  }
}
