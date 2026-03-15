import 'package:flutter/material.dart';
import 'package:pascoa_scout/ui/dashboard_page.dart';

void main() {
  runApp(const PascoaScoutApp());
}

class PascoaScoutApp extends StatelessWidget {
  const PascoaScoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pascoa Scout',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 38, 255, 237),
        ),
      ),
      home: DashboardPage(),
    );
  }
}
