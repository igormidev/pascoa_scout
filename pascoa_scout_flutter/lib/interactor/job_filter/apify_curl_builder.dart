import 'package:pascoa_scout/interactor/job_sync/job_sync_providers.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

const String _apifyToken = String.fromEnvironment('PASCOA_APIFY_TOKEN');

String? buildPollingCurlForFilter(JobFilter filter) {
  if (_apifyToken.isEmpty) {
    return null;
  }

  return buildUpworkApifyCurl(
    filterJson: filter.toJson(),
    paginationJson: buildJobSyncPagination().toJson(),
    apifyToken: _apifyToken,
  );
}
