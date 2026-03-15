import 'package:flutter/material.dart';

class JobScrapperConfigTab extends StatelessWidget {
  const JobScrapperConfigTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(height: 48.0),
            Text(
              '🗿',
              style: TextStyle(fontSize: 160),
              textAlign: TextAlign.center,
            ),
            Text(
              'Pascoa Scout',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Configure your job scrapper settings here.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
