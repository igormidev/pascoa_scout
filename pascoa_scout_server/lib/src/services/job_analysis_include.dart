import '../generated/protocol.dart';

JobAnalysisStateInclude buildJobAnalysisStateInclude() {
  return JobAnalysisState.include(
    jobInfo: JobInfo.include(
      questions: Question.includeList(
        orderBy: (table) => table.positionIndex,
      ),
    ),
    score: JobScore.include(),
    proposal: JobProposal.include(
      answers: JobProposalAnswerToQuestion.includeList(
        orderBy: (table) => table.relatedQuestionId,
        include: JobProposalAnswerToQuestion.include(
          relatedQuestion: Question.include(),
        ),
      ),
    ),
  );
}
