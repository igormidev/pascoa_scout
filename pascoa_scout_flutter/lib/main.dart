import 'package:flutter/material.dart';

void main() {
  runApp(const PascoaScoutApp());
}

class PascoaScoutApp extends StatelessWidget {
  const PascoaScoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pascoa Scout',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
      ),
      home: const Scaffold(body: Center(child: Text('Pascoa Scout'))),
    );
  }
}
