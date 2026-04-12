import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/job_analysis_force_sync_service.dart';
import '../services/job_analysis_query_service.dart';

class JobAnalysisEndpoint extends Endpoint {
  JobAnalysisEndpoint({
    JobAnalysisQueryService? service,
    JobAnalysisForceSyncService? forceSyncService,
  }) : _service = service ?? const JobAnalysisQueryService(),
       _forceSyncService =
           forceSyncService ?? const JobAnalysisForceSyncService();

  final JobAnalysisQueryService _service;
  final JobAnalysisForceSyncService _forceSyncService;

  Future<JobAnalysisPagination> getPage(
    Session session, {
    required JobAnalysisListFilter filter,
  }) async {
    final result = await _service.getPage(session, filter);
    return result.fold((page) => page, (error) => throw error);
  }

  Future<JobAnalysisState> refreshCard(
    Session session, {
    required int jobAnalysisStateId,
  }) async {
    final result = await _service.getById(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
    );
    return result.fold((row) => row, (error) => throw error);
  }

  Future<JobAnalysisState> markJobViewed(
    Session session, {
    required int jobAnalysisStateId,
  }) async {
    final result = await _service.markJobViewed(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
    );
    return result.fold((row) => row, (error) => throw error);
  }

  Stream<JobAnalysisForceSyncProgress> forceSync(
    Session session, {
    required int jobAnalysisStateId,
  }) {
    final controller = StreamController<JobAnalysisForceSyncProgress>();

    unawaited(
      () async {
        try {
          await _forceSyncService.forceSync(
            session,
            jobAnalysisStateId: jobAnalysisStateId,
            onProgress: (progress) async {
              if (!controller.isClosed) {
                controller.add(progress);
              }
            },
          );
        } finally {
          if (!controller.isClosed) {
            await controller.close();
          }
        }
      }(),
    );

    return controller.stream;
  }
}
