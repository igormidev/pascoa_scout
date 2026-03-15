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
import '../endpoints/upwork_jobs_endpoint.dart' as _i2;
import 'package:pascoa_scout_server/src/generated/entities/upwork_scrap/job_filter.dart'
    as _i3;
import 'package:pascoa_scout_server/src/generated/entities/upwork_scrap/pagination.dart'
    as _i4;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i5;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i6;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'upworkJobs': _i2.UpworkJobsEndpoint()
        ..initialize(
          server,
          'upworkJobs',
          null,
        ),
    };
    connectors['upworkJobs'] = _i1.EndpointConnector(
      name: 'upworkJobs',
      endpoint: endpoints['upworkJobs']!,
      methodConnectors: {
        'getJobs': _i1.MethodConnector(
          name: 'getJobs',
          params: {
            'filter': _i1.ParameterDescription(
              name: 'filter',
              type: _i1.getType<_i3.JobFilter>(),
              nullable: false,
            ),
            'pagination': _i1.ParameterDescription(
              name: 'pagination',
              type: _i1.getType<_i4.Pagination?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['upworkJobs'] as _i2.UpworkJobsEndpoint).getJobs(
                    session,
                    filter: params['filter'],
                    pagination: params['pagination'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i5.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i6.Endpoints()
      ..initializeEndpoints(server);
  }
}
