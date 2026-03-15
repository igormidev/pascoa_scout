import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

part 'current_filter_state.freezed.dart';
part 'current_filter_state.g.dart';

@freezed
abstract class CurrentFiltersState with _$CurrentFiltersState {
  factory CurrentFiltersState.none() = _CurrentFiltersStateNone;
  factory CurrentFiltersState.withFilter({required JobFilter jobFilter}) =
      _CurrentFiltersStateWithFilter;

  factory CurrentFiltersState.fromJson(Map<String, dynamic> json) =>
      _$CurrentFiltersStateFromJson(json);
}
