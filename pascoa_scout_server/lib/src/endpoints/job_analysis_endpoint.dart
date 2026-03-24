import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/job_analysis_query_service.dart';

class JobAnalysisEndpoint extends Endpoint {
  JobAnalysisEndpoint({
    JobAnalysisQueryService? service,
  }) : _service = service ?? const JobAnalysisQueryService();

  final JobAnalysisQueryService _service;

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
}
