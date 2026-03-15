import 'package:serverpod/serverpod.dart';

import '../adapters/upwork_scrap_apify_mapper.dart';
import '../generated/protocol.dart';
import '../repository/get_upwork_jobs_repository.dart';

class UpworkJobsEndpoint extends Endpoint {
  UpworkJobsEndpoint({
    IGetUpworkJobsRepository? repository,
  }) : _repository = repository;

  final IGetUpworkJobsRepository? _repository;

  Future<List<JobInfo>> getJobs(
    Session session, {
    required JobFilter filter,
    required Pagination? pagination,
  }) async {
    final apifyToken = Serverpod.instance.getPassword('apifyToken');
    if (apifyToken == null || apifyToken.isEmpty) {
      throw PascoaException(
        message: 'Missing Apify token',
        description:
            'Add apifyToken to pascoa_scout_server/config/passwords.yaml before calling this endpoint.',
      );
    }

    final repository =
        _repository ?? GetUpworkJobRepositoryApifyImpl(apifyToken: apifyToken);

    final result = await repository.getJobs(
      filter: filter,
      pagination: pagination ?? buildInitialPagination(),
    );

    return result.fold(
      (jobs) => jobs,
      (error) => throw error,
    );
  }
}
