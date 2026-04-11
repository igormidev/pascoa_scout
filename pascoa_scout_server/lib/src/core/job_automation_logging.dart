import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

enum AutomationLogScope {
  control,
  loop,
  sync,
  score,
  proposal,
  answers,
  milestones,
  error,
}

enum AutomationLogEvent {
  start,
  done,
  fail,
}

void logAutomation(Session session, String scope, String message) {
  _logAutomation(
    session,
    _scopeFromName(scope),
    AutomationLogEvent.start,
    message,
  );
}

void logAutomationStart(
  Session session,
  AutomationLogScope scope,
  String message,
) {
  _logAutomation(session, scope, AutomationLogEvent.start, message);
}

void logAutomationDone(
  Session session,
  AutomationLogScope scope,
  String message,
) {
  _logAutomation(session, scope, AutomationLogEvent.done, message);
}

void logAutomationFail(
  Session session,
  AutomationLogScope scope,
  String message,
) {
  _logAutomation(session, scope, AutomationLogEvent.fail, message);
}

void printAutomationLogLegend() {
  final lines = [
    'Automation log legend',
    _legendLine(AutomationLogScope.control, 'control, pause, resume'),
    _legendLine(AutomationLogScope.loop, 'step scheduling and loop handoff'),
    _legendLine(AutomationLogScope.sync, 'Upwork fetch and job upserts'),
    _legendLine(AutomationLogScope.score, 'AI compatibility score generation'),
    _legendLine(
      AutomationLogScope.proposal,
      'AI cover letter generation requests',
    ),
    _legendLine(AutomationLogScope.answers, 'proposal question answers'),
    _legendLine(AutomationLogScope.milestones, 'proposal milestones'),
    _legendLine(AutomationLogScope.error, 'automation failures'),
    'Icons: ${_iconFor(AutomationLogEvent.start)} started | ${_iconFor(AutomationLogEvent.done)} finished | ${_iconFor(AutomationLogEvent.fail)} failed',
  ];

  stdout.writeln('${lines.join('\n')}\n\n');
}

String formatAutomationAnalysisLabel(JobAnalysisState analysis) {
  final analysisId = analysis.id?.toString() ?? '?';
  final upworkId = analysis.jobInfo?.upworkId ?? 'unknown';
  final title = summarizeAutomationTitle(analysis.jobInfo?.title);
  return 'analysis=$analysisId upwork=$upworkId title="$title"';
}

String formatAutomationJobLabel(JobInfo job) {
  final jobId = job.id?.toString() ?? '?';
  return 'job=$jobId upwork=${job.upworkId} title="${summarizeAutomationTitle(job.title)}"';
}

String summarizeAutomationQuery(String query) {
  final normalized = query.trim().replaceAll(RegExp(r'\s+'), ' ');
  if (normalized.length <= 60) {
    return normalized;
  }

  return '${normalized.substring(0, 57)}...';
}

String summarizeAutomationTitle(String? title) {
  final normalized = title?.trim().replaceAll(RegExp(r'\s+'), ' ');
  if (normalized == null || normalized.isEmpty) {
    return 'unknown';
  }

  return normalized;
}

void _logAutomation(
  Session session,
  AutomationLogScope scope,
  AutomationLogEvent event,
  String message,
) {
  final normalizedMessage = message.trim().replaceAll(RegExp(r'\s+'), ' ');
  final line =
      '${_colorFor(scope)}[automation/${scope.name}] ${_iconFor(event)} $normalizedMessage${_resetColor()}\n\n';
  session.log(line);
}

AutomationLogScope _scopeFromName(String scope) {
  return AutomationLogScope.values.firstWhere(
    (value) => value.name == scope,
    orElse: () => AutomationLogScope.control,
  );
}

String _legendLine(AutomationLogScope scope, String description) {
  return '${_colorFor(scope)}[automation/${scope.name}]${_resetColor()} $description';
}

String _iconFor(AutomationLogEvent event) {
  return switch (event) {
    AutomationLogEvent.start => '▶',
    AutomationLogEvent.done => '✅',
    AutomationLogEvent.fail => '❌',
  };
}

String _colorFor(AutomationLogScope scope) {
  if (!stdout.supportsAnsiEscapes) {
    return '';
  }

  return switch (scope) {
    AutomationLogScope.control => '\x1B[96m',
    AutomationLogScope.loop => '\x1B[36m',
    AutomationLogScope.sync => '\x1B[92m',
    AutomationLogScope.score => '\x1B[93m',
    AutomationLogScope.proposal => '\x1B[95m',
    AutomationLogScope.answers => '\x1B[94m',
    AutomationLogScope.milestones => '\x1B[97m',
    AutomationLogScope.error => '\x1B[91m',
  };
}

String _resetColor() {
  if (!stdout.supportsAnsiEscapes) {
    return '';
  }

  return '\x1B[0m';
}
