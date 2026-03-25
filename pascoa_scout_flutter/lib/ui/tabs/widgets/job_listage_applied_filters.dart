import 'package:flutter/material.dart';

class JobListageAppliedFilters extends StatelessWidget {
  const JobListageAppliedFilters({super.key, required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final label in labels) _JobListageAppliedFilterChip(label: label),
      ],
    );
  }
}

class _JobListageAppliedFilterChip extends StatelessWidget {
  const _JobListageAppliedFilterChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}
