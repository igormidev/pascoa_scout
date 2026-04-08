import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

void logAutomation(Session session, String scope, String message) {
  session.log('[automation/$scope] $message');
}

String formatAutomationAnalysisLabel(JobAnalysisState analysis) {
  final analysisId = analysis.id?.toString() ?? '?';
  final upworkId = analysis.jobInfo?.upworkId ?? 'unknown';
  return 'analysis=$analysisId upwork=$upworkId';
}

String summarizeAutomationQuery(String query) {
  final normalized = query.trim().replaceAll(RegExp(r'\s+'), ' ');
  if (normalized.length <= 60) {
    return normalized;
  }

  return '${normalized.substring(0, 57)}...';
}
