import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/job_knowledge_service.dart';

class JobKnowledgeEndpoint extends Endpoint {
  JobKnowledgeEndpoint({
    JobKnowledgeService? service,
  }) : _service = service ?? const JobKnowledgeService();

  final JobKnowledgeService _service;

  Future<JobKnowledgeSummary> getSummary(Session session) async {
    final result = await _service.getSummary(session);
    return result.fold((summary) => summary, (error) => throw error);
  }

  Future<JobKnowledgeDraft> getDraft(Session session) async {
    final result = await _service.getDraft(session);
    return result.fold((draft) => draft, (error) => throw error);
  }

  Future<JobCurriculumProfile> saveCurriculum(
    Session session, {
    required String markdownText,
  }) async {
    final result = await _service.saveCurriculum(session, markdownText);
    return result.fold((row) => row, (error) => throw error);
  }

  Future<JobProposalStylePreference> saveProposalStylePreference(
    Session session, {
    required String markdownText,
  }) async {
    final result = await _service.saveProposalStyle(session, markdownText);
    return result.fold((row) => row, (error) => throw error);
  }

  Future<JobOpportunityPreference> saveOpportunityPreference(
    Session session, {
    required String markdownText,
  }) async {
    final result = await _service.saveOpportunityPreference(
      session,
      markdownText,
    );
    return result.fold((row) => row, (error) => throw error);
  }
}
