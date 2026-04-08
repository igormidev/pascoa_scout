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
import 'entities/job_analysis_filter_mode.dart' as _i2;
import 'entities/job_analysis_list_filter.dart' as _i3;
import 'entities/job_analysis_order_by.dart' as _i4;
import 'entities/job_analysis_pagination.dart' as _i5;
import 'entities/job_analysis_state.dart' as _i6;
import 'entities/job_automation_ai_model.dart' as _i7;
import 'entities/job_automation_ai_thinking_effort.dart' as _i8;
import 'entities/job_automation_overview.dart' as _i9;
import 'entities/job_automation_runtime.dart' as _i10;
import 'entities/job_automation_settings.dart' as _i11;
import 'entities/job_automation_settings_update.dart' as _i12;
import 'entities/job_automation_step.dart' as _i13;
import 'entities/job_curriculum_profile.dart' as _i14;
import 'entities/job_knowledge_draft.dart' as _i15;
import 'entities/job_knowledge_summary.dart' as _i16;
import 'entities/job_opportunity_preference.dart' as _i17;
import 'entities/job_proposal.dart' as _i18;
import 'entities/job_proposal_answer_to_question.dart' as _i19;
import 'entities/job_proposal_milestone.dart' as _i20;
import 'entities/job_proposal_style_preference.dart' as _i21;
import 'entities/job_score.dart' as _i22;
import 'entities/others/pagination_metadata.dart' as _i23;
import 'entities/others/pascoa_exception.dart' as _i24;
import 'entities/upwork_scrap/available_operators.dart' as _i25;
import 'entities/upwork_scrap/available_properties.dart' as _i26;
import 'entities/upwork_scrap/client_history.dart' as _i27;
import 'entities/upwork_scrap/client_location.dart' as _i28;
import 'entities/upwork_scrap/country.dart' as _i29;
import 'entities/upwork_scrap/custom_filter.dart' as _i30;
import 'entities/upwork_scrap/experience_level.dart' as _i31;
import 'entities/upwork_scrap/job_age_unit.dart' as _i32;
import 'entities/upwork_scrap/job_filter.dart' as _i33;
import 'entities/upwork_scrap/job_info.dart' as _i34;
import 'entities/upwork_scrap/job_type.dart' as _i35;
import 'entities/upwork_scrap/maximum_job_age.dart' as _i36;
import 'entities/upwork_scrap/min_max.dart' as _i37;
import 'entities/upwork_scrap/pagination.dart' as _i38;
import 'entities/upwork_scrap/payment_verified_status.dart' as _i39;
import 'entities/upwork_scrap/question.dart' as _i40;
import 'entities/upwork_scrap/region.dart' as _i41;
import 'entities/upwork_scrap/search_sort_order.dart' as _i42;
import 'entities/upwork_scrap/sub_region.dart' as _i43;
import 'package:pascoa_scout_client/src/protocol/entities/upwork_scrap/job_info.dart'
    as _i44;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i45;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i46;
export 'entities/job_analysis_filter_mode.dart';
export 'entities/job_analysis_list_filter.dart';
export 'entities/job_analysis_order_by.dart';
export 'entities/job_analysis_pagination.dart';
export 'entities/job_analysis_state.dart';
export 'entities/job_automation_ai_model.dart';
export 'entities/job_automation_ai_thinking_effort.dart';
export 'entities/job_automation_overview.dart';
export 'entities/job_automation_runtime.dart';
export 'entities/job_automation_settings.dart';
export 'entities/job_automation_settings_update.dart';
export 'entities/job_automation_step.dart';
export 'entities/job_curriculum_profile.dart';
export 'entities/job_knowledge_draft.dart';
export 'entities/job_knowledge_summary.dart';
export 'entities/job_opportunity_preference.dart';
export 'entities/job_proposal.dart';
export 'entities/job_proposal_answer_to_question.dart';
export 'entities/job_proposal_milestone.dart';
export 'entities/job_proposal_style_preference.dart';
export 'entities/job_score.dart';
export 'entities/others/pagination_metadata.dart';
export 'entities/others/pascoa_exception.dart';
export 'entities/upwork_scrap/available_operators.dart';
export 'entities/upwork_scrap/available_properties.dart';
export 'entities/upwork_scrap/client_history.dart';
export 'entities/upwork_scrap/client_location.dart';
export 'entities/upwork_scrap/country.dart';
export 'entities/upwork_scrap/custom_filter.dart';
export 'entities/upwork_scrap/experience_level.dart';
export 'entities/upwork_scrap/job_age_unit.dart';
export 'entities/upwork_scrap/job_filter.dart';
export 'entities/upwork_scrap/job_info.dart';
export 'entities/upwork_scrap/job_type.dart';
export 'entities/upwork_scrap/maximum_job_age.dart';
export 'entities/upwork_scrap/min_max.dart';
export 'entities/upwork_scrap/pagination.dart';
export 'entities/upwork_scrap/payment_verified_status.dart';
export 'entities/upwork_scrap/question.dart';
export 'entities/upwork_scrap/region.dart';
export 'entities/upwork_scrap/search_sort_order.dart';
export 'entities/upwork_scrap/sub_region.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.JobAnalysisFilterMode) {
      return _i2.JobAnalysisFilterMode.fromJson(data) as T;
    }
    if (t == _i3.JobAnalysisListFilter) {
      return _i3.JobAnalysisListFilter.fromJson(data) as T;
    }
    if (t == _i4.JobAnalysisOrderBy) {
      return _i4.JobAnalysisOrderBy.fromJson(data) as T;
    }
    if (t == _i5.JobAnalysisPagination) {
      return _i5.JobAnalysisPagination.fromJson(data) as T;
    }
    if (t == _i6.JobAnalysisState) {
      return _i6.JobAnalysisState.fromJson(data) as T;
    }
    if (t == _i7.JobAutomationAiModel) {
      return _i7.JobAutomationAiModel.fromJson(data) as T;
    }
    if (t == _i8.JobAutomationAiThinkingEffort) {
      return _i8.JobAutomationAiThinkingEffort.fromJson(data) as T;
    }
    if (t == _i9.JobAutomationOverview) {
      return _i9.JobAutomationOverview.fromJson(data) as T;
    }
    if (t == _i10.JobAutomationRuntime) {
      return _i10.JobAutomationRuntime.fromJson(data) as T;
    }
    if (t == _i11.JobAutomationSettings) {
      return _i11.JobAutomationSettings.fromJson(data) as T;
    }
    if (t == _i12.JobAutomationSettingsUpdate) {
      return _i12.JobAutomationSettingsUpdate.fromJson(data) as T;
    }
    if (t == _i13.JobAutomationStep) {
      return _i13.JobAutomationStep.fromJson(data) as T;
    }
    if (t == _i14.JobCurriculumProfile) {
      return _i14.JobCurriculumProfile.fromJson(data) as T;
    }
    if (t == _i15.JobKnowledgeDraft) {
      return _i15.JobKnowledgeDraft.fromJson(data) as T;
    }
    if (t == _i16.JobKnowledgeSummary) {
      return _i16.JobKnowledgeSummary.fromJson(data) as T;
    }
    if (t == _i17.JobOpportunityPreference) {
      return _i17.JobOpportunityPreference.fromJson(data) as T;
    }
    if (t == _i18.JobProposal) {
      return _i18.JobProposal.fromJson(data) as T;
    }
    if (t == _i19.JobProposalAnswerToQuestion) {
      return _i19.JobProposalAnswerToQuestion.fromJson(data) as T;
    }
    if (t == _i20.JobProposalMilestone) {
      return _i20.JobProposalMilestone.fromJson(data) as T;
    }
    if (t == _i21.JobProposalStylePreference) {
      return _i21.JobProposalStylePreference.fromJson(data) as T;
    }
    if (t == _i22.JobScore) {
      return _i22.JobScore.fromJson(data) as T;
    }
    if (t == _i23.PaginationMetadata) {
      return _i23.PaginationMetadata.fromJson(data) as T;
    }
    if (t == _i24.PascoaException) {
      return _i24.PascoaException.fromJson(data) as T;
    }
    if (t == _i25.AvailableOperators) {
      return _i25.AvailableOperators.fromJson(data) as T;
    }
    if (t == _i26.AvailableProperties) {
      return _i26.AvailableProperties.fromJson(data) as T;
    }
    if (t == _i27.ClientHistory) {
      return _i27.ClientHistory.fromJson(data) as T;
    }
    if (t == _i28.ClientLocation) {
      return _i28.ClientLocation.fromJson(data) as T;
    }
    if (t == _i29.Country) {
      return _i29.Country.fromJson(data) as T;
    }
    if (t == _i30.CustomFilter) {
      return _i30.CustomFilter.fromJson(data) as T;
    }
    if (t == _i31.ExperienceLevel) {
      return _i31.ExperienceLevel.fromJson(data) as T;
    }
    if (t == _i32.JobAgeUnit) {
      return _i32.JobAgeUnit.fromJson(data) as T;
    }
    if (t == _i33.JobFilter) {
      return _i33.JobFilter.fromJson(data) as T;
    }
    if (t == _i34.JobInfo) {
      return _i34.JobInfo.fromJson(data) as T;
    }
    if (t == _i35.JobType) {
      return _i35.JobType.fromJson(data) as T;
    }
    if (t == _i36.MaximumJobAge) {
      return _i36.MaximumJobAge.fromJson(data) as T;
    }
    if (t == _i37.MinMax) {
      return _i37.MinMax.fromJson(data) as T;
    }
    if (t == _i38.Pagination) {
      return _i38.Pagination.fromJson(data) as T;
    }
    if (t == _i39.PaymentVerifiedStatus) {
      return _i39.PaymentVerifiedStatus.fromJson(data) as T;
    }
    if (t == _i40.Question) {
      return _i40.Question.fromJson(data) as T;
    }
    if (t == _i41.Region) {
      return _i41.Region.fromJson(data) as T;
    }
    if (t == _i42.SearchSortOrder) {
      return _i42.SearchSortOrder.fromJson(data) as T;
    }
    if (t == _i43.SubRegion) {
      return _i43.SubRegion.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.JobAnalysisFilterMode?>()) {
      return (data != null ? _i2.JobAnalysisFilterMode.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i3.JobAnalysisListFilter?>()) {
      return (data != null ? _i3.JobAnalysisListFilter.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.JobAnalysisOrderBy?>()) {
      return (data != null ? _i4.JobAnalysisOrderBy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.JobAnalysisPagination?>()) {
      return (data != null ? _i5.JobAnalysisPagination.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.JobAnalysisState?>()) {
      return (data != null ? _i6.JobAnalysisState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.JobAutomationAiModel?>()) {
      return (data != null ? _i7.JobAutomationAiModel.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.JobAutomationAiThinkingEffort?>()) {
      return (data != null
              ? _i8.JobAutomationAiThinkingEffort.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.JobAutomationOverview?>()) {
      return (data != null ? _i9.JobAutomationOverview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.JobAutomationRuntime?>()) {
      return (data != null ? _i10.JobAutomationRuntime.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.JobAutomationSettings?>()) {
      return (data != null ? _i11.JobAutomationSettings.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.JobAutomationSettingsUpdate?>()) {
      return (data != null
              ? _i12.JobAutomationSettingsUpdate.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i13.JobAutomationStep?>()) {
      return (data != null ? _i13.JobAutomationStep.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.JobCurriculumProfile?>()) {
      return (data != null ? _i14.JobCurriculumProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.JobKnowledgeDraft?>()) {
      return (data != null ? _i15.JobKnowledgeDraft.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.JobKnowledgeSummary?>()) {
      return (data != null ? _i16.JobKnowledgeSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.JobOpportunityPreference?>()) {
      return (data != null
              ? _i17.JobOpportunityPreference.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.JobProposal?>()) {
      return (data != null ? _i18.JobProposal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.JobProposalAnswerToQuestion?>()) {
      return (data != null
              ? _i19.JobProposalAnswerToQuestion.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.JobProposalMilestone?>()) {
      return (data != null ? _i20.JobProposalMilestone.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.JobProposalStylePreference?>()) {
      return (data != null
              ? _i21.JobProposalStylePreference.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i22.JobScore?>()) {
      return (data != null ? _i22.JobScore.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.PaginationMetadata?>()) {
      return (data != null ? _i23.PaginationMetadata.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.PascoaException?>()) {
      return (data != null ? _i24.PascoaException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.AvailableOperators?>()) {
      return (data != null ? _i25.AvailableOperators.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.AvailableProperties?>()) {
      return (data != null ? _i26.AvailableProperties.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.ClientHistory?>()) {
      return (data != null ? _i27.ClientHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.ClientLocation?>()) {
      return (data != null ? _i28.ClientLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.Country?>()) {
      return (data != null ? _i29.Country.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.CustomFilter?>()) {
      return (data != null ? _i30.CustomFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.ExperienceLevel?>()) {
      return (data != null ? _i31.ExperienceLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.JobAgeUnit?>()) {
      return (data != null ? _i32.JobAgeUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.JobFilter?>()) {
      return (data != null ? _i33.JobFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.JobInfo?>()) {
      return (data != null ? _i34.JobInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.JobType?>()) {
      return (data != null ? _i35.JobType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.MaximumJobAge?>()) {
      return (data != null ? _i36.MaximumJobAge.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.MinMax?>()) {
      return (data != null ? _i37.MinMax.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.Pagination?>()) {
      return (data != null ? _i38.Pagination.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.PaymentVerifiedStatus?>()) {
      return (data != null ? _i39.PaymentVerifiedStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.Question?>()) {
      return (data != null ? _i40.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.Region?>()) {
      return (data != null ? _i41.Region.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.SearchSortOrder?>()) {
      return (data != null ? _i42.SearchSortOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.SubRegion?>()) {
      return (data != null ? _i43.SubRegion.fromJson(data) : null) as T;
    }
    if (t == List<_i6.JobAnalysisState>) {
      return (data as List)
              .map((e) => deserialize<_i6.JobAnalysisState>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.JobProposalAnswerToQuestion>) {
      return (data as List)
              .map((e) => deserialize<_i19.JobProposalAnswerToQuestion>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i19.JobProposalAnswerToQuestion>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) => deserialize<_i19.JobProposalAnswerToQuestion>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i20.JobProposalMilestone>) {
      return (data as List)
              .map((e) => deserialize<_i20.JobProposalMilestone>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i20.JobProposalMilestone>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i20.JobProposalMilestone>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i31.ExperienceLevel>) {
      return (data as List)
              .map((e) => deserialize<_i31.ExperienceLevel>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i31.ExperienceLevel>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i31.ExperienceLevel>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i27.ClientHistory>) {
      return (data as List)
              .map((e) => deserialize<_i27.ClientHistory>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i27.ClientHistory>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i27.ClientHistory>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i35.JobType>) {
      return (data as List).map((e) => deserialize<_i35.JobType>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i35.JobType>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i35.JobType>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i29.Country>) {
      return (data as List).map((e) => deserialize<_i29.Country>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i29.Country>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i29.Country>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i41.Region>) {
      return (data as List).map((e) => deserialize<_i41.Region>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i41.Region>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i41.Region>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i43.SubRegion>) {
      return (data as List).map((e) => deserialize<_i43.SubRegion>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i43.SubRegion>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i43.SubRegion>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i30.CustomFilter>) {
      return (data as List)
              .map((e) => deserialize<_i30.CustomFilter>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i30.CustomFilter>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i30.CustomFilter>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i40.Question>) {
      return (data as List).map((e) => deserialize<_i40.Question>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i40.Question>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i40.Question>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i44.JobInfo>) {
      return (data as List).map((e) => deserialize<_i44.JobInfo>(e)).toList()
          as T;
    }
    try {
      return _i45.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i46.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.JobAnalysisFilterMode => 'JobAnalysisFilterMode',
      _i3.JobAnalysisListFilter => 'JobAnalysisListFilter',
      _i4.JobAnalysisOrderBy => 'JobAnalysisOrderBy',
      _i5.JobAnalysisPagination => 'JobAnalysisPagination',
      _i6.JobAnalysisState => 'JobAnalysisState',
      _i7.JobAutomationAiModel => 'JobAutomationAiModel',
      _i8.JobAutomationAiThinkingEffort => 'JobAutomationAiThinkingEffort',
      _i9.JobAutomationOverview => 'JobAutomationOverview',
      _i10.JobAutomationRuntime => 'JobAutomationRuntime',
      _i11.JobAutomationSettings => 'JobAutomationSettings',
      _i12.JobAutomationSettingsUpdate => 'JobAutomationSettingsUpdate',
      _i13.JobAutomationStep => 'JobAutomationStep',
      _i14.JobCurriculumProfile => 'JobCurriculumProfile',
      _i15.JobKnowledgeDraft => 'JobKnowledgeDraft',
      _i16.JobKnowledgeSummary => 'JobKnowledgeSummary',
      _i17.JobOpportunityPreference => 'JobOpportunityPreference',
      _i18.JobProposal => 'JobProposal',
      _i19.JobProposalAnswerToQuestion => 'JobProposalAnswerToQuestion',
      _i20.JobProposalMilestone => 'JobProposalMilestone',
      _i21.JobProposalStylePreference => 'JobProposalStylePreference',
      _i22.JobScore => 'JobScore',
      _i23.PaginationMetadata => 'PaginationMetadata',
      _i24.PascoaException => 'PascoaException',
      _i25.AvailableOperators => 'AvailableOperators',
      _i26.AvailableProperties => 'AvailableProperties',
      _i27.ClientHistory => 'ClientHistory',
      _i28.ClientLocation => 'ClientLocation',
      _i29.Country => 'Country',
      _i30.CustomFilter => 'CustomFilter',
      _i31.ExperienceLevel => 'ExperienceLevel',
      _i32.JobAgeUnit => 'JobAgeUnit',
      _i33.JobFilter => 'JobFilter',
      _i34.JobInfo => 'JobInfo',
      _i35.JobType => 'JobType',
      _i36.MaximumJobAge => 'MaximumJobAge',
      _i37.MinMax => 'MinMax',
      _i38.Pagination => 'Pagination',
      _i39.PaymentVerifiedStatus => 'PaymentVerifiedStatus',
      _i40.Question => 'Question',
      _i41.Region => 'Region',
      _i42.SearchSortOrder => 'SearchSortOrder',
      _i43.SubRegion => 'SubRegion',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'pascoa_scout.',
        '',
      );
    }

    switch (data) {
      case _i2.JobAnalysisFilterMode():
        return 'JobAnalysisFilterMode';
      case _i3.JobAnalysisListFilter():
        return 'JobAnalysisListFilter';
      case _i4.JobAnalysisOrderBy():
        return 'JobAnalysisOrderBy';
      case _i5.JobAnalysisPagination():
        return 'JobAnalysisPagination';
      case _i6.JobAnalysisState():
        return 'JobAnalysisState';
      case _i7.JobAutomationAiModel():
        return 'JobAutomationAiModel';
      case _i8.JobAutomationAiThinkingEffort():
        return 'JobAutomationAiThinkingEffort';
      case _i9.JobAutomationOverview():
        return 'JobAutomationOverview';
      case _i10.JobAutomationRuntime():
        return 'JobAutomationRuntime';
      case _i11.JobAutomationSettings():
        return 'JobAutomationSettings';
      case _i12.JobAutomationSettingsUpdate():
        return 'JobAutomationSettingsUpdate';
      case _i13.JobAutomationStep():
        return 'JobAutomationStep';
      case _i14.JobCurriculumProfile():
        return 'JobCurriculumProfile';
      case _i15.JobKnowledgeDraft():
        return 'JobKnowledgeDraft';
      case _i16.JobKnowledgeSummary():
        return 'JobKnowledgeSummary';
      case _i17.JobOpportunityPreference():
        return 'JobOpportunityPreference';
      case _i18.JobProposal():
        return 'JobProposal';
      case _i19.JobProposalAnswerToQuestion():
        return 'JobProposalAnswerToQuestion';
      case _i20.JobProposalMilestone():
        return 'JobProposalMilestone';
      case _i21.JobProposalStylePreference():
        return 'JobProposalStylePreference';
      case _i22.JobScore():
        return 'JobScore';
      case _i23.PaginationMetadata():
        return 'PaginationMetadata';
      case _i24.PascoaException():
        return 'PascoaException';
      case _i25.AvailableOperators():
        return 'AvailableOperators';
      case _i26.AvailableProperties():
        return 'AvailableProperties';
      case _i27.ClientHistory():
        return 'ClientHistory';
      case _i28.ClientLocation():
        return 'ClientLocation';
      case _i29.Country():
        return 'Country';
      case _i30.CustomFilter():
        return 'CustomFilter';
      case _i31.ExperienceLevel():
        return 'ExperienceLevel';
      case _i32.JobAgeUnit():
        return 'JobAgeUnit';
      case _i33.JobFilter():
        return 'JobFilter';
      case _i34.JobInfo():
        return 'JobInfo';
      case _i35.JobType():
        return 'JobType';
      case _i36.MaximumJobAge():
        return 'MaximumJobAge';
      case _i37.MinMax():
        return 'MinMax';
      case _i38.Pagination():
        return 'Pagination';
      case _i39.PaymentVerifiedStatus():
        return 'PaymentVerifiedStatus';
      case _i40.Question():
        return 'Question';
      case _i41.Region():
        return 'Region';
      case _i42.SearchSortOrder():
        return 'SearchSortOrder';
      case _i43.SubRegion():
        return 'SubRegion';
    }
    className = _i45.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i46.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'JobAnalysisFilterMode') {
      return deserialize<_i2.JobAnalysisFilterMode>(data['data']);
    }
    if (dataClassName == 'JobAnalysisListFilter') {
      return deserialize<_i3.JobAnalysisListFilter>(data['data']);
    }
    if (dataClassName == 'JobAnalysisOrderBy') {
      return deserialize<_i4.JobAnalysisOrderBy>(data['data']);
    }
    if (dataClassName == 'JobAnalysisPagination') {
      return deserialize<_i5.JobAnalysisPagination>(data['data']);
    }
    if (dataClassName == 'JobAnalysisState') {
      return deserialize<_i6.JobAnalysisState>(data['data']);
    }
    if (dataClassName == 'JobAutomationAiModel') {
      return deserialize<_i7.JobAutomationAiModel>(data['data']);
    }
    if (dataClassName == 'JobAutomationAiThinkingEffort') {
      return deserialize<_i8.JobAutomationAiThinkingEffort>(data['data']);
    }
    if (dataClassName == 'JobAutomationOverview') {
      return deserialize<_i9.JobAutomationOverview>(data['data']);
    }
    if (dataClassName == 'JobAutomationRuntime') {
      return deserialize<_i10.JobAutomationRuntime>(data['data']);
    }
    if (dataClassName == 'JobAutomationSettings') {
      return deserialize<_i11.JobAutomationSettings>(data['data']);
    }
    if (dataClassName == 'JobAutomationSettingsUpdate') {
      return deserialize<_i12.JobAutomationSettingsUpdate>(data['data']);
    }
    if (dataClassName == 'JobAutomationStep') {
      return deserialize<_i13.JobAutomationStep>(data['data']);
    }
    if (dataClassName == 'JobCurriculumProfile') {
      return deserialize<_i14.JobCurriculumProfile>(data['data']);
    }
    if (dataClassName == 'JobKnowledgeDraft') {
      return deserialize<_i15.JobKnowledgeDraft>(data['data']);
    }
    if (dataClassName == 'JobKnowledgeSummary') {
      return deserialize<_i16.JobKnowledgeSummary>(data['data']);
    }
    if (dataClassName == 'JobOpportunityPreference') {
      return deserialize<_i17.JobOpportunityPreference>(data['data']);
    }
    if (dataClassName == 'JobProposal') {
      return deserialize<_i18.JobProposal>(data['data']);
    }
    if (dataClassName == 'JobProposalAnswerToQuestion') {
      return deserialize<_i19.JobProposalAnswerToQuestion>(data['data']);
    }
    if (dataClassName == 'JobProposalMilestone') {
      return deserialize<_i20.JobProposalMilestone>(data['data']);
    }
    if (dataClassName == 'JobProposalStylePreference') {
      return deserialize<_i21.JobProposalStylePreference>(data['data']);
    }
    if (dataClassName == 'JobScore') {
      return deserialize<_i22.JobScore>(data['data']);
    }
    if (dataClassName == 'PaginationMetadata') {
      return deserialize<_i23.PaginationMetadata>(data['data']);
    }
    if (dataClassName == 'PascoaException') {
      return deserialize<_i24.PascoaException>(data['data']);
    }
    if (dataClassName == 'AvailableOperators') {
      return deserialize<_i25.AvailableOperators>(data['data']);
    }
    if (dataClassName == 'AvailableProperties') {
      return deserialize<_i26.AvailableProperties>(data['data']);
    }
    if (dataClassName == 'ClientHistory') {
      return deserialize<_i27.ClientHistory>(data['data']);
    }
    if (dataClassName == 'ClientLocation') {
      return deserialize<_i28.ClientLocation>(data['data']);
    }
    if (dataClassName == 'Country') {
      return deserialize<_i29.Country>(data['data']);
    }
    if (dataClassName == 'CustomFilter') {
      return deserialize<_i30.CustomFilter>(data['data']);
    }
    if (dataClassName == 'ExperienceLevel') {
      return deserialize<_i31.ExperienceLevel>(data['data']);
    }
    if (dataClassName == 'JobAgeUnit') {
      return deserialize<_i32.JobAgeUnit>(data['data']);
    }
    if (dataClassName == 'JobFilter') {
      return deserialize<_i33.JobFilter>(data['data']);
    }
    if (dataClassName == 'JobInfo') {
      return deserialize<_i34.JobInfo>(data['data']);
    }
    if (dataClassName == 'JobType') {
      return deserialize<_i35.JobType>(data['data']);
    }
    if (dataClassName == 'MaximumJobAge') {
      return deserialize<_i36.MaximumJobAge>(data['data']);
    }
    if (dataClassName == 'MinMax') {
      return deserialize<_i37.MinMax>(data['data']);
    }
    if (dataClassName == 'Pagination') {
      return deserialize<_i38.Pagination>(data['data']);
    }
    if (dataClassName == 'PaymentVerifiedStatus') {
      return deserialize<_i39.PaymentVerifiedStatus>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_i40.Question>(data['data']);
    }
    if (dataClassName == 'Region') {
      return deserialize<_i41.Region>(data['data']);
    }
    if (dataClassName == 'SearchSortOrder') {
      return deserialize<_i42.SearchSortOrder>(data['data']);
    }
    if (dataClassName == 'SubRegion') {
      return deserialize<_i43.SubRegion>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i45.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i46.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i45.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i46.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
