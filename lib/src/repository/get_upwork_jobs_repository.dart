import 'package:pascoa_scout/src/entities/upwork_scrap/job_filter.dart';
import 'package:pascoa_scout/src/entities/upwork_scrap/job_info.dart';

abstract class IGetUpworkJobsRepository {
  Future<List<JobInfo>> getJobs({
    required JobFilter filter,
    required Pagination pagination,
  });
}
