const String jobAutomationSingletonKey = 'default';
const String jobAutomationOverviewChannel = 'job-automation-overview';

const String jobAutomationSyncFutureCallName = 'jobAutomationSyncFutureCall';
const String jobAutomationScoreFutureCallName = 'jobAutomationScoreFutureCall';
const String jobAutomationProposalFutureCallName =
    'jobAutomationProposalFutureCall';

const String jobAutomationSyncFutureCallIdentifier =
    'job-automation-sync-future-call';
const String jobAutomationScoreFutureCallIdentifier =
    'job-automation-score-future-call';
const String jobAutomationProposalFutureCallIdentifier =
    'job-automation-proposal-future-call';

const int maxConcurrentAiExecutions = 2;
const int defaultScoreBatchSize = 20;
const int defaultProposalBatchSize = 20;
const int defaultUpworkSyncResultsPerPage = 20;
const int defaultProposalMinimumScorePercentage = 70;
const int defaultLoopDelayMinutes = 5;
const String defaultCodexModel = 'gpt-5.4';
const String defaultCodexMiniModel = 'gpt-5.4-mini';

const int knowledgeTextMinimumLength = 100;
const int knowledgeTextMaximumLength = 60000;

const String codexRunsDirectoryName = '.codex_runs';
