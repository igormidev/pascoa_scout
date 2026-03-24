import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
import '../core/pascoa_result.dart';
import '../generated/protocol.dart';

class JobKnowledgeBundle {
  const JobKnowledgeBundle({
    required this.curriculum,
    required this.proposalStyle,
    required this.opportunityPreference,
  });

  final JobCurriculumProfile curriculum;
  final JobProposalStylePreference proposalStyle;
  final JobOpportunityPreference opportunityPreference;
}

class JobKnowledgeService {
  const JobKnowledgeService();

  Future<PascoaResult<JobKnowledgeSummary>> getSummary(Session session) async {
    try {
      final curriculum = await _findCurriculum(session);
      final proposalStyle = await _findProposalStyle(session);
      final opportunityPreference = await _findOpportunityPreference(session);

      return Success(
        JobKnowledgeSummary(
          hasCurriculum: curriculum != null,
          hasProposalStylePreference: proposalStyle != null,
          hasOpportunityPreference: opportunityPreference != null,
        ),
      );
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to load job knowledge summary',
          description:
              'The server could not determine which long-form knowledge texts are already stored.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<PascoaResult<JobCurriculumProfile>> saveCurriculum(
    Session session,
    String markdownText,
  ) async {
    return _saveSingletonText<JobCurriculumProfile>(
      session,
      markdownText: markdownText,
      findCurrent: _findCurriculum,
      create: (text, now, existingId) => JobCurriculumProfile(
        id: existingId,
        singletonKey: jobAutomationSingletonKey,
        markdownText: text,
        updatedAt: now,
      ),
      onInsert: (row) => JobCurriculumProfile.db.insertRow(session, row),
      onUpdate: (row) => JobCurriculumProfile.db.updateRow(session, row),
      unableMessage: 'Unable to save curriculum knowledge',
      unableDescription:
          'The curriculum text could not be stored for future AI scoring and proposal generation.',
    );
  }

  Future<PascoaResult<JobProposalStylePreference>> saveProposalStyle(
    Session session,
    String markdownText,
  ) async {
    return _saveSingletonText<JobProposalStylePreference>(
      session,
      markdownText: markdownText,
      findCurrent: _findProposalStyle,
      create: (text, now, existingId) => JobProposalStylePreference(
        id: existingId,
        singletonKey: jobAutomationSingletonKey,
        markdownText: text,
        updatedAt: now,
      ),
      onInsert: (row) => JobProposalStylePreference.db.insertRow(session, row),
      onUpdate: (row) => JobProposalStylePreference.db.updateRow(session, row),
      unableMessage: 'Unable to save proposal style preference',
      unableDescription:
          'The preference that defines how proposals should be written could not be stored.',
    );
  }

  Future<PascoaResult<JobOpportunityPreference>> saveOpportunityPreference(
    Session session,
    String markdownText,
  ) async {
    return _saveSingletonText<JobOpportunityPreference>(
      session,
      markdownText: markdownText,
      findCurrent: _findOpportunityPreference,
      create: (text, now, existingId) => JobOpportunityPreference(
        id: existingId,
        singletonKey: jobAutomationSingletonKey,
        markdownText: text,
        updatedAt: now,
      ),
      onInsert: (row) => JobOpportunityPreference.db.insertRow(session, row),
      onUpdate: (row) => JobOpportunityPreference.db.updateRow(session, row),
      unableMessage: 'Unable to save opportunity preference',
      unableDescription:
          'The preference that defines what makes a good job opportunity could not be stored.',
    );
  }

  Future<PascoaResult<JobKnowledgeBundle>> getKnowledgeBundle(
    Session session,
  ) async {
    try {
      final curriculum = await _findCurriculum(session);
      final proposalStyle = await _findProposalStyle(session);
      final opportunityPreference = await _findOpportunityPreference(session);

      if (curriculum == null ||
          proposalStyle == null ||
          opportunityPreference == null) {
        return Failure(
          PascoaException(
            message: 'Missing AI knowledge inputs',
            description:
                'Save the curriculum, proposal style preference, and good opportunity preference before running the AI automation loop.',
          ),
        );
      }

      return Success(
        JobKnowledgeBundle(
          curriculum: curriculum,
          proposalStyle: proposalStyle,
          opportunityPreference: opportunityPreference,
        ),
      );
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: 'Unable to load AI knowledge inputs',
          description:
              'The server could not load the stored long-form texts required by the AI pipeline.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<JobCurriculumProfile?> _findCurriculum(Session session) {
    return JobCurriculumProfile.db.findFirstRow(
      session,
      where: (table) => table.singletonKey.equals(jobAutomationSingletonKey),
    );
  }

  Future<JobProposalStylePreference?> _findProposalStyle(Session session) {
    return JobProposalStylePreference.db.findFirstRow(
      session,
      where: (table) => table.singletonKey.equals(jobAutomationSingletonKey),
    );
  }

  Future<JobOpportunityPreference?> _findOpportunityPreference(
    Session session,
  ) {
    return JobOpportunityPreference.db.findFirstRow(
      session,
      where: (table) => table.singletonKey.equals(jobAutomationSingletonKey),
    );
  }

  Future<PascoaResult<T>> _saveSingletonText<T extends TableRow<int?>>(
    Session session, {
    required String markdownText,
    required Future<T?> Function(Session session) findCurrent,
    required T Function(String text, DateTime now, int? existingId) create,
    required Future<T> Function(T row) onInsert,
    required Future<T> Function(T row) onUpdate,
    required String unableMessage,
    required String unableDescription,
  }) async {
    final validationError = _validateLongText(markdownText);
    if (validationError != null) {
      return Failure(validationError);
    }

    try {
      final current = await findCurrent(session);
      final now = DateTime.now().toUtc();
      final row = create(markdownText.trim(), now, current?.id);
      final persisted = current == null
          ? await onInsert(row)
          : await onUpdate(row);
      return Success(persisted);
    } catch (error, stackTrace) {
      return Failure(
        _buildException(
          message: unableMessage,
          description: unableDescription,
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  PascoaException? _validateLongText(String markdownText) {
    final trimmed = markdownText.trim();
    if (trimmed.length < knowledgeTextMinimumLength) {
      return PascoaException(
        message: 'Text is too short',
        description:
            'Each long-form knowledge field must contain at least $knowledgeTextMinimumLength characters.',
      );
    }

    if (trimmed.length > knowledgeTextMaximumLength) {
      return PascoaException(
        message: 'Text is too long',
        description:
            'Each long-form knowledge field can contain at most $knowledgeTextMaximumLength characters.',
      );
    }

    return null;
  }

  PascoaException _buildException({
    required String message,
    required String description,
    required Object error,
    required StackTrace stackTrace,
  }) {
    return PascoaException(
      message: message,
      description: description,
      error: error.toString(),
      stackTrace: stackTrace.toString(),
    );
  }
}
