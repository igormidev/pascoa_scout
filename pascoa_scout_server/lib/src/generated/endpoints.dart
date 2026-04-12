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
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/job_analysis_endpoint.dart' as _i2;
import '../endpoints/job_automation_endpoint.dart' as _i3;
import '../endpoints/job_knowledge_endpoint.dart' as _i4;
import '../endpoints/upwork_jobs_endpoint.dart' as _i5;
import 'package:pascoa_scout_server/src/generated/entities/job_analysis_list_filter.dart'
    as _i6;
import 'package:pascoa_scout_server/src/generated/entities/job_automation_settings_update.dart'
    as _i7;
import 'package:pascoa_scout_server/src/generated/entities/upwork_scrap/job_filter.dart'
    as _i8;
import 'package:pascoa_scout_server/src/generated/entities/upwork_scrap/pagination.dart'
    as _i9;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i10;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i11;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'jobAnalysis': _i2.JobAnalysisEndpoint()
        ..initialize(
          server,
          'jobAnalysis',
          null,
        ),
      'jobAutomation': _i3.JobAutomationEndpoint()
        ..initialize(
          server,
          'jobAutomation',
          null,
        ),
      'jobKnowledge': _i4.JobKnowledgeEndpoint()
        ..initialize(
          server,
          'jobKnowledge',
          null,
        ),
      'upworkJobs': _i5.UpworkJobsEndpoint()
        ..initialize(
          server,
          'upworkJobs',
          null,
        ),
    };
    connectors['jobAnalysis'] = _i1.EndpointConnector(
      name: 'jobAnalysis',
      endpoint: endpoints['jobAnalysis']!,
      methodConnectors: {
        'getPage': _i1.MethodConnector(
          name: 'getPage',
          params: {
            'filter': _i1.ParameterDescription(
              name: 'filter',
              type: _i1.getType<_i6.JobAnalysisListFilter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jobAnalysis'] as _i2.JobAnalysisEndpoint).getPage(
                    session,
                    filter: params['filter'],
                  ),
        ),
        'refreshCard': _i1.MethodConnector(
          name: 'refreshCard',
          params: {
            'jobAnalysisStateId': _i1.ParameterDescription(
              name: 'jobAnalysisStateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobAnalysis'] as _i2.JobAnalysisEndpoint)
                  .refreshCard(
                    session,
                    jobAnalysisStateId: params['jobAnalysisStateId'],
                  ),
        ),
        'markJobViewed': _i1.MethodConnector(
          name: 'markJobViewed',
          params: {
            'jobAnalysisStateId': _i1.ParameterDescription(
              name: 'jobAnalysisStateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobAnalysis'] as _i2.JobAnalysisEndpoint)
                  .markJobViewed(
                    session,
                    jobAnalysisStateId: params['jobAnalysisStateId'],
                  ),
        ),
        'forceSync': _i1.MethodStreamConnector(
          name: 'forceSync',
          params: {
            'jobAnalysisStateId': _i1.ParameterDescription(
              name: 'jobAnalysisStateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['jobAnalysis'] as _i2.JobAnalysisEndpoint)
                  .forceSync(
                    session,
                    jobAnalysisStateId: params['jobAnalysisStateId'],
                  ),
        ),
      },
    );
    connectors['jobAutomation'] = _i1.EndpointConnector(
      name: 'jobAutomation',
      endpoint: endpoints['jobAutomation']!,
      methodConnectors: {
        'getOverview': _i1.MethodConnector(
          name: 'getOverview',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jobAutomation'] as _i3.JobAutomationEndpoint)
                      .getOverview(session),
        ),
        'updateSettings': _i1.MethodConnector(
          name: 'updateSettings',
          params: {
            'update': _i1.ParameterDescription(
              name: 'update',
              type: _i1.getType<_i7.JobAutomationSettingsUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jobAutomation'] as _i3.JobAutomationEndpoint)
                      .updateSettings(
                        session,
                        update: params['update'],
                      ),
        ),
        'setJobFetchingPaused': _i1.MethodConnector(
          name: 'setJobFetchingPaused',
          params: {
            'isPaused': _i1.ParameterDescription(
              name: 'isPaused',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jobAutomation'] as _i3.JobAutomationEndpoint)
                      .setJobFetchingPaused(
                        session,
                        isPaused: params['isPaused'],
                      ),
        ),
        'watchOverview': _i1.MethodStreamConnector(
          name: 'watchOverview',
          params: {},
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['jobAutomation'] as _i3.JobAutomationEndpoint)
                  .watchOverview(session),
        ),
      },
    );
    connectors['jobKnowledge'] = _i1.EndpointConnector(
      name: 'jobKnowledge',
      endpoint: endpoints['jobKnowledge']!,
      methodConnectors: {
        'getSummary': _i1.MethodConnector(
          name: 'getSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobKnowledge'] as _i4.JobKnowledgeEndpoint)
                  .getSummary(session),
        ),
        'getDraft': _i1.MethodConnector(
          name: 'getDraft',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobKnowledge'] as _i4.JobKnowledgeEndpoint)
                  .getDraft(session),
        ),
        'saveCurriculum': _i1.MethodConnector(
          name: 'saveCurriculum',
          params: {
            'markdownText': _i1.ParameterDescription(
              name: 'markdownText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobKnowledge'] as _i4.JobKnowledgeEndpoint)
                  .saveCurriculum(
                    session,
                    markdownText: params['markdownText'],
                  ),
        ),
        'saveProposalStylePreference': _i1.MethodConnector(
          name: 'saveProposalStylePreference',
          params: {
            'markdownText': _i1.ParameterDescription(
              name: 'markdownText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobKnowledge'] as _i4.JobKnowledgeEndpoint)
                  .saveProposalStylePreference(
                    session,
                    markdownText: params['markdownText'],
                  ),
        ),
        'saveOpportunityPreference': _i1.MethodConnector(
          name: 'saveOpportunityPreference',
          params: {
            'markdownText': _i1.ParameterDescription(
              name: 'markdownText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobKnowledge'] as _i4.JobKnowledgeEndpoint)
                  .saveOpportunityPreference(
                    session,
                    markdownText: params['markdownText'],
                  ),
        ),
      },
    );
    connectors['upworkJobs'] = _i1.EndpointConnector(
      name: 'upworkJobs',
      endpoint: endpoints['upworkJobs']!,
      methodConnectors: {
        'getJobs': _i1.MethodConnector(
          name: 'getJobs',
          params: {
            'filter': _i1.ParameterDescription(
              name: 'filter',
              type: _i1.getType<_i8.JobFilter>(),
              nullable: false,
            ),
            'pagination': _i1.ParameterDescription(
              name: 'pagination',
              type: _i1.getType<_i9.Pagination?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['upworkJobs'] as _i5.UpworkJobsEndpoint).getJobs(
                    session,
                    filter: params['filter'],
                    pagination: params['pagination'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i10.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i11.Endpoints()
      ..initializeEndpoints(server);
  }
}
