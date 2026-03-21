import 'package:dio/dio.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart'
    show buildUpworkApifyRequestBody, buildUpworkApifyRunUri;
import 'package:pascoa_scout_server/src/core/pascoa_result.dart';
import 'package:result_dart/result_dart.dart';

import '../adapters/upwork_scrap_apify_mapper.dart';
import '../generated/protocol.dart';

abstract class IGetUpworkJobsRepository {
  Future<PascoaResult<List<JobInfo>>> getJobs({
    required JobFilter filter,
    required Pagination pagination,
  });
}

class GetUpworkJobRepositoryApifyImpl implements IGetUpworkJobsRepository {
  GetUpworkJobRepositoryApifyImpl({
    required this.apifyToken,
    Dio? dio,
  }) : dio = dio ?? Dio();

  final Dio dio;
  final String apifyToken;

  @override
  Future<PascoaResult<List<JobInfo>>> getJobs({
    required JobFilter filter,
    required Pagination pagination,
  }) async {
    final requestBody = buildUpworkApifyRequestBody(
      filterJson: filter.toJson(),
      paginationJson: pagination.toJson(),
    );

    try {
      final response = await dio.post<dynamic>(
        buildUpworkApifyRunUri().toString(),
        data: requestBody,
        options: Options(
          headers: <String, dynamic>{'Authorization': 'Bearer $apifyToken'},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      final responseData = response.data;
      if (responseData is! List) {
        return Failure(
          PascoaException(
            message: 'Unexpected response from Apify',
            description:
                'Expected a list of jobs but received ${responseData.runtimeType}.',
            error: responseData.toString(),
          ),
        );
      }

      final jobs = <JobInfo>[];
      for (final item in responseData) {
        if (item is! Map) {
          return Failure(
            PascoaException(
              message: 'Unexpected job payload from Apify',
              description: 'A job item was not returned as an object.',
              error: item.runtimeType.toString(),
            ),
          );
        }

        jobs.add(jobInfoFromApify(Map<String, dynamic>.from(item)));
      }

      return Success(jobs);
    } on DioException catch (error, stackTrace) {
      return Failure(
        PascoaException(
          message: 'Failed to fetch Upwork jobs from Apify',
          description:
              'Apify request failed'
              '${error.response?.statusCode != null ? ' with HTTP ${error.response?.statusCode}' : ''}.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    } catch (error, stackTrace) {
      return Failure(
        PascoaException(
          message: 'Failed to parse Upwork jobs',
          description:
              'An unexpected error happened while requesting or mapping jobs from Apify.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
  }
}
