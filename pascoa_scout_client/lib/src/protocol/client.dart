/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:pascoa_scout_client/src/protocol/entities/job_analysis_pagination.dart'
    as _i3;
import 'package:pascoa_scout_client/src/protocol/entities/job_analysis_list_filter.dart'
    as _i4;
import 'package:pascoa_scout_client/src/protocol/entities/job_analysis_state.dart'
    as _i5;
import 'package:pascoa_scout_client/src/protocol/entities/job_analysis_force_sync_progress.dart'
    as _i6;
import 'package:pascoa_scout_client/src/protocol/entities/job_automation_overview.dart'
    as _i7;
import 'package:pascoa_scout_client/src/protocol/entities/job_automation_settings_update.dart'
    as _i8;
import 'package:pascoa_scout_client/src/protocol/entities/job_knowledge_summary.dart'
    as _i9;
import 'package:pascoa_scout_client/src/protocol/entities/job_knowledge_draft.dart'
    as _i10;
import 'package:pascoa_scout_client/src/protocol/entities/job_curriculum_profile.dart'
    as _i11;
import 'package:pascoa_scout_client/src/protocol/entities/job_proposal_style_preference.dart'
    as _i12;
import 'package:pascoa_scout_client/src/protocol/entities/job_opportunity_preference.dart'
    as _i13;
import 'package:pascoa_scout_client/src/protocol/entities/upwork_scrap/job_info.dart'
    as _i14;
import 'package:pascoa_scout_client/src/protocol/entities/upwork_scrap/job_filter.dart'
    as _i15;
import 'package:pascoa_scout_client/src/protocol/entities/upwork_scrap/pagination.dart'
    as _i16;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i17;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i18;
import 'protocol.dart' as _i19;

/// {@category Endpoint}
class EndpointJobAnalysis extends _i1.EndpointRef {
  EndpointJobAnalysis(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jobAnalysis';

  _i2.Future<_i3.JobAnalysisPagination> getPage({
    required _i4.JobAnalysisListFilter filter,
  }) => caller.callServerEndpoint<_i3.JobAnalysisPagination>(
    'jobAnalysis',
    'getPage',
    {'filter': filter},
  );

  _i2.Future<_i5.JobAnalysisState> refreshCard({
    required int jobAnalysisStateId,
  }) => caller.callServerEndpoint<_i5.JobAnalysisState>(
    'jobAnalysis',
    'refreshCard',
    {'jobAnalysisStateId': jobAnalysisStateId},
  );

  _i2.Future<_i5.JobAnalysisState> markJobViewed({
    required int jobAnalysisStateId,
  }) => caller.callServerEndpoint<_i5.JobAnalysisState>(
    'jobAnalysis',
    'markJobViewed',
    {'jobAnalysisStateId': jobAnalysisStateId},
  );

  _i2.Future<_i5.JobAnalysisState> manualFetch({required String rawUrl}) =>
      caller.callServerEndpoint<_i5.JobAnalysisState>(
        'jobAnalysis',
        'manualFetch',
        {'rawUrl': rawUrl},
      );

  _i2.Stream<_i6.JobAnalysisForceSyncProgress> forceSync({
    required int jobAnalysisStateId,
  }) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i6.JobAnalysisForceSyncProgress>,
        _i6.JobAnalysisForceSyncProgress
      >(
        'jobAnalysis',
        'forceSync',
        {'jobAnalysisStateId': jobAnalysisStateId},
        {},
      );
}

/// {@category Endpoint}
class EndpointJobAutomation extends _i1.EndpointRef {
  EndpointJobAutomation(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jobAutomation';

  _i2.Future<_i7.JobAutomationOverview> getOverview() =>
      caller.callServerEndpoint<_i7.JobAutomationOverview>(
        'jobAutomation',
        'getOverview',
        {},
      );

  _i2.Stream<_i7.JobAutomationOverview> watchOverview() =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i7.JobAutomationOverview>,
        _i7.JobAutomationOverview
      >(
        'jobAutomation',
        'watchOverview',
        {},
        {},
      );

  _i2.Future<_i7.JobAutomationOverview> updateSettings({
    required _i8.JobAutomationSettingsUpdate update,
  }) => caller.callServerEndpoint<_i7.JobAutomationOverview>(
    'jobAutomation',
    'updateSettings',
    {'update': update},
  );

  _i2.Future<_i7.JobAutomationOverview> setJobFetchingPaused({
    required bool isPaused,
  }) => caller.callServerEndpoint<_i7.JobAutomationOverview>(
    'jobAutomation',
    'setJobFetchingPaused',
    {'isPaused': isPaused},
  );
}

/// {@category Endpoint}
class EndpointJobKnowledge extends _i1.EndpointRef {
  EndpointJobKnowledge(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jobKnowledge';

  _i2.Future<_i9.JobKnowledgeSummary> getSummary() =>
      caller.callServerEndpoint<_i9.JobKnowledgeSummary>(
        'jobKnowledge',
        'getSummary',
        {},
      );

  _i2.Future<_i10.JobKnowledgeDraft> getDraft() =>
      caller.callServerEndpoint<_i10.JobKnowledgeDraft>(
        'jobKnowledge',
        'getDraft',
        {},
      );

  _i2.Future<_i11.JobCurriculumProfile> saveCurriculum({
    required String markdownText,
  }) => caller.callServerEndpoint<_i11.JobCurriculumProfile>(
    'jobKnowledge',
    'saveCurriculum',
    {'markdownText': markdownText},
  );

  _i2.Future<_i12.JobProposalStylePreference> saveProposalStylePreference({
    required String markdownText,
  }) => caller.callServerEndpoint<_i12.JobProposalStylePreference>(
    'jobKnowledge',
    'saveProposalStylePreference',
    {'markdownText': markdownText},
  );

  _i2.Future<_i13.JobOpportunityPreference> saveOpportunityPreference({
    required String markdownText,
  }) => caller.callServerEndpoint<_i13.JobOpportunityPreference>(
    'jobKnowledge',
    'saveOpportunityPreference',
    {'markdownText': markdownText},
  );
}

/// {@category Endpoint}
class EndpointUpworkJobs extends _i1.EndpointRef {
  EndpointUpworkJobs(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'upworkJobs';

  _i2.Future<List<_i14.JobInfo>> getJobs({
    required _i15.JobFilter filter,
    required _i16.Pagination? pagination,
  }) => caller.callServerEndpoint<List<_i14.JobInfo>>(
    'upworkJobs',
    'getJobs',
    {
      'filter': filter,
      'pagination': pagination,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i17.Caller(client);
    serverpod_auth_core = _i18.Caller(client);
  }

  late final _i17.Caller serverpod_auth_idp;

  late final _i18.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i19.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    jobAnalysis = EndpointJobAnalysis(this);
    jobAutomation = EndpointJobAutomation(this);
    jobKnowledge = EndpointJobKnowledge(this);
    upworkJobs = EndpointUpworkJobs(this);
    modules = Modules(this);
  }

  late final EndpointJobAnalysis jobAnalysis;

  late final EndpointJobAutomation jobAutomation;

  late final EndpointJobKnowledge jobKnowledge;

  late final EndpointUpworkJobs upworkJobs;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'jobAnalysis': jobAnalysis,
    'jobAutomation': jobAutomation,
    'jobKnowledge': jobKnowledge,
    'upworkJobs': upworkJobs,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
