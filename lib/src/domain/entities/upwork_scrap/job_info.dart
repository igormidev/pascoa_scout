import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_info.freezed.dart';
part 'job_info.g.dart';

@freezed
abstract class JobInfo with _$JobInfo {
  factory JobInfo({required String id}) = _JobInfo;

  factory JobInfo.fromJson(Map<String, dynamic> json) =>
      _$JobInfoFromJson(json);
}
