import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/job_automation_logging.dart';
import '../core/pascoa_result.dart';
import '../generated/protocol.dart';
import 'job_analysis_query_service.dart';
import 'job_upwork_sync_service.dart';

class JobAnalysisManualFetchService {
  static const _manualFetchResultsPerPage = 10;

  const JobAnalysisManualFetchService({
    JobUpworkSyncService? syncService,
    JobAnalysisQueryService? queryService,
  }) : _syncService = syncService ?? const JobUpworkSyncService(),
       _queryService = queryService ?? const JobAnalysisQueryService();

  final JobUpworkSyncService _syncService;
  final JobAnalysisQueryService _queryService;

  Future<PascoaResult<JobAnalysisState>> manualFetch(
    Session session, {
    required String rawUrl,
  }) async {
    final normalizedRawUrl = rawUrl.trim();
    final validationError = _validateRawUrl(normalizedRawUrl);
    if (validationError != null) {
      return Failure(validationError);
    }

    logAutomationStart(
      session,
      AutomationLogScope.control,
      'manual fetch started | rawUrl="${summarizeAutomationRawUrl(normalizedRawUrl)}"',
    );

    final syncResult = await _syncService.syncLatestJobsDetailed(
      session,
      filter: JobFilter(searchQueryTerm: '', rawUrl: normalizedRawUrl),
      resultsPerPage: _manualFetchResultsPerPage,
    );

    return syncResult.fold(
      (summary) async {
        final primaryJobAnalysisStateId = summary.primaryJobAnalysisStateId;
        if (summary.processedCount == 0 || primaryJobAnalysisStateId == null) {
          final error = PascoaException(
            message: 'No jobs were found for this Upwork link',
            description:
                'The provided Upwork search URL returned no jobs to persist.',
          );
          logAutomationFail(
            session,
            AutomationLogScope.control,
            'manual fetch failed | ${error.message}',
          );
          return Failure(error);
        }

        final analysisResult = await _queryService.getById(
          session,
          jobAnalysisStateId: primaryJobAnalysisStateId,
        );

        return analysisResult.fold(
          (analysis) {
            logAutomationDone(
              session,
              AutomationLogScope.control,
              'manual fetch finished | jobs=${summary.processedCount} analysis=$primaryJobAnalysisStateId',
            );
            return Success(analysis);
          },
          (error) {
            logAutomationFail(
              session,
              AutomationLogScope.control,
              'manual fetch failed | ${error.message}',
            );
            return Failure(error);
          },
        );
      },
      (error) async {
        logAutomationFail(
          session,
          AutomationLogScope.control,
          'manual fetch failed | ${error.message}',
        );
        return Failure(error);
      },
    );
  }

  PascoaException? _validateRawUrl(String rawUrl) {
    if (rawUrl.isEmpty) {
      return PascoaException(
        message: 'The Upwork link is required',
        description:
            'Paste the Upwork search link that should be fetched manually.',
      );
    }

    final uri = Uri.tryParse(rawUrl);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      return PascoaException(
        message: 'The Upwork link is invalid',
        description:
            'Use a full Upwork HTTPS link that includes the search path.',
      );
    }

    final isHttp = uri.scheme == 'https' || uri.scheme == 'http';
    final normalizedHost = uri.host.toLowerCase();
    final isUpworkHost =
        normalizedHost == 'upwork.com' ||
        normalizedHost.endsWith('.upwork.com');
    final hasJobsSearchPath = uri.path.toLowerCase().contains(
      '/nx/search/jobs',
    );
    if (!isHttp || !isUpworkHost || !hasJobsSearchPath) {
      return PascoaException(
        message: 'The Upwork link must be a search URL',
        description:
            'Use an Upwork URL from upwork.com that contains "nx/search/jobs".',
      );
    }

    return null;
  }
}
