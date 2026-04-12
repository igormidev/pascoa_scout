/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: no_leading_underscores_for_local_identifiers

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_test/serverpod_test.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import 'dart:async' as _i3;
import 'package:pascoa_scout_server/src/generated/entities/job_analysis_pagination.dart'
    as _i4;
import 'package:pascoa_scout_server/src/generated/entities/job_analysis_list_filter.dart'
    as _i5;
import 'package:pascoa_scout_server/src/generated/entities/job_analysis_state.dart'
    as _i6;
import 'package:pascoa_scout_server/src/generated/entities/job_analysis_force_sync_progress.dart'
    as _i7;
import 'package:pascoa_scout_server/src/generated/entities/job_automation_overview.dart'
    as _i8;
import 'package:pascoa_scout_server/src/generated/entities/job_automation_settings_update.dart'
    as _i9;
import 'package:pascoa_scout_server/src/generated/entities/job_knowledge_summary.dart'
    as _i10;
import 'package:pascoa_scout_server/src/generated/entities/job_knowledge_draft.dart'
    as _i11;
import 'package:pascoa_scout_server/src/generated/entities/job_curriculum_profile.dart'
    as _i12;
import 'package:pascoa_scout_server/src/generated/entities/job_proposal_style_preference.dart'
    as _i13;
import 'package:pascoa_scout_server/src/generated/entities/job_opportunity_preference.dart'
    as _i14;
import 'package:pascoa_scout_server/src/generated/entities/upwork_scrap/job_info.dart'
    as _i15;
import 'package:pascoa_scout_server/src/generated/entities/upwork_scrap/job_filter.dart'
    as _i16;
import 'package:pascoa_scout_server/src/generated/entities/upwork_scrap/pagination.dart'
    as _i17;
import 'package:pascoa_scout_server/src/generated/protocol.dart';
import 'package:pascoa_scout_server/src/generated/endpoints.dart';
export 'package:serverpod_test/serverpod_test_public_exports.dart';

/// Creates a new test group that takes a callback that can be used to write tests.
/// The callback has two parameters: `sessionBuilder` and `endpoints`.
/// `sessionBuilder` is used to build a `Session` object that represents the server state during an endpoint call and is used to set up scenarios.
/// `endpoints` contains all your Serverpod endpoints and lets you call them:
/// ```dart
/// withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
///   test('when calling `hello` then should return greeting', () async {
///     final greeting = await endpoints.example.hello(sessionBuilder, 'Michael');
///     expect(greeting, 'Hello Michael');
///   });
/// });
/// ```
///
/// **Configuration options**
///
/// [applyMigrations] Whether pending migrations should be applied when starting Serverpod. Defaults to `true`
///
/// [enableSessionLogging] Whether session logging should be enabled. Defaults to `false`
///
/// [rollbackDatabase] Options for when to rollback the database during the test lifecycle.
/// By default `withServerpod` does all database operations inside a transaction that is rolled back after each `test` case.
/// Just like the following enum describes, the behavior of the automatic rollbacks can be configured:
/// ```dart
/// /// Options for when to rollback the database during the test lifecycle.
/// enum RollbackDatabase {
///   /// After each test. This is the default.
///   afterEach,
///
///   /// After all tests.
///   afterAll,
///
///   /// Disable rolling back the database.
///   disabled,
/// }
/// ```
///
/// [runMode] The run mode that Serverpod should be running in. Defaults to `test`.
///
/// [serverpodLoggingMode] The logging mode used when creating Serverpod. Defaults to `ServerpodLoggingMode.normal`
///
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 30)`.
///
/// [testServerOutputMode] Options for controlling test server output during test execution. Defaults to `TestServerOutputMode.normal`.
/// ```dart
/// /// Options for controlling test server output during test execution.
/// enum TestServerOutputMode {
///   /// Default mode - only stderr is printed (stdout suppressed).
///   /// This hides normal startup/shutdown logs while preserving error messages.
///   normal,
///
///   /// All logging - both stdout and stderr are printed.
///   /// Useful for debugging when you need to see all server output.
///   verbose,
///
///   /// No logging - both stdout and stderr are suppressed.
///   /// Completely silent mode, useful when you don't want any server output.
///   silent,
/// }
/// ```
///
/// [configOverride] A function to override the server configuration. This function is called with
/// the default server configuration after it is loaded from the config/ directory
/// and before it is used to start the server. Use this to override particular
/// settings in the server configuration.
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
@_i1.isTestGroup
void withServerpod(
  String testGroupName,
  _i1.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  _i2.ServerpodConfig Function(_i2.ServerpodConfig)? configOverride,
  bool? enableSessionLogging,
  _i2.ExperimentalFeatures? experimentalFeatures,
  _i1.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _i2.RuntimeParametersListBuilder? runtimeParametersBuilder,
  _i2.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
  _i1.TestServerOutputMode? testServerOutputMode,
}) {
  _i1.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _i1.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      testServerOutputMode: testServerOutputMode,
      experimentalFeatures: experimentalFeatures,
      runtimeParametersBuilder: runtimeParametersBuilder,
    ),
    maybeRollbackDatabase: rollbackDatabase,
    maybeEnableSessionLogging: enableSessionLogging,
    maybeTestGroupTagsOverride: testGroupTagsOverride,
    maybeServerpodStartTimeout: serverpodStartTimeout,
    maybeTestServerOutputMode: testServerOutputMode,
  )(testClosure);
}

class TestEndpoints {
  late final _JobAnalysisEndpoint jobAnalysis;

  late final _JobAutomationEndpoint jobAutomation;

  late final _JobKnowledgeEndpoint jobKnowledge;

  late final _UpworkJobsEndpoint upworkJobs;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _i1.InternalTestEndpoints {
  @override
  void initialize(
    _i2.SerializationManager serializationManager,
    _i2.EndpointDispatch endpoints,
  ) {
    jobAnalysis = _JobAnalysisEndpoint(
      endpoints,
      serializationManager,
    );
    jobAutomation = _JobAutomationEndpoint(
      endpoints,
      serializationManager,
    );
    jobKnowledge = _JobKnowledgeEndpoint(
      endpoints,
      serializationManager,
    );
    upworkJobs = _UpworkJobsEndpoint(
      endpoints,
      serializationManager,
    );
  }
}

class _JobAnalysisEndpoint {
  _JobAnalysisEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.JobAnalysisPagination> getPage(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i5.JobAnalysisListFilter filter,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobAnalysis',
            method: 'getPage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobAnalysis',
          methodName: 'getPage',
          parameters: _i1.testObjectToJson({'filter': filter}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.JobAnalysisPagination>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.JobAnalysisState> refreshCard(
    _i1.TestSessionBuilder sessionBuilder, {
    required int jobAnalysisStateId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobAnalysis',
            method: 'refreshCard',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobAnalysis',
          methodName: 'refreshCard',
          parameters: _i1.testObjectToJson({
            'jobAnalysisStateId': jobAnalysisStateId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i6.JobAnalysisState>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.JobAnalysisState> markJobViewed(
    _i1.TestSessionBuilder sessionBuilder, {
    required int jobAnalysisStateId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobAnalysis',
            method: 'markJobViewed',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobAnalysis',
          methodName: 'markJobViewed',
          parameters: _i1.testObjectToJson({
            'jobAnalysisStateId': jobAnalysisStateId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i6.JobAnalysisState>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Stream<_i7.JobAnalysisForceSyncProgress> forceSync(
    _i1.TestSessionBuilder sessionBuilder, {
    required int jobAnalysisStateId,
  }) {
    var _localTestStreamManager =
        _i1.TestStreamManager<_i7.JobAnalysisForceSyncProgress>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'jobAnalysis',
              method: 'forceSync',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'jobAnalysis',
              methodName: 'forceSync',
              arguments: {'jobAnalysisStateId': jobAnalysisStateId},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }
}

class _JobAutomationEndpoint {
  _JobAutomationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i8.JobAutomationOverview> getOverview(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobAutomation',
            method: 'getOverview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobAutomation',
          methodName: 'getOverview',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i8.JobAutomationOverview>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Stream<_i8.JobAutomationOverview> watchOverview(
    _i1.TestSessionBuilder sessionBuilder,
  ) {
    var _localTestStreamManager =
        _i1.TestStreamManager<_i8.JobAutomationOverview>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'jobAutomation',
              method: 'watchOverview',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'jobAutomation',
              methodName: 'watchOverview',
              arguments: {},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Future<_i8.JobAutomationOverview> updateSettings(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i9.JobAutomationSettingsUpdate update,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobAutomation',
            method: 'updateSettings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobAutomation',
          methodName: 'updateSettings',
          parameters: _i1.testObjectToJson({'update': update}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i8.JobAutomationOverview>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i8.JobAutomationOverview> setJobFetchingPaused(
    _i1.TestSessionBuilder sessionBuilder, {
    required bool isPaused,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobAutomation',
            method: 'setJobFetchingPaused',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobAutomation',
          methodName: 'setJobFetchingPaused',
          parameters: _i1.testObjectToJson({'isPaused': isPaused}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i8.JobAutomationOverview>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _JobKnowledgeEndpoint {
  _JobKnowledgeEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i10.JobKnowledgeSummary> getSummary(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobKnowledge',
            method: 'getSummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobKnowledge',
          methodName: 'getSummary',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.JobKnowledgeSummary>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.JobKnowledgeDraft> getDraft(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobKnowledge',
            method: 'getDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobKnowledge',
          methodName: 'getDraft',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.JobKnowledgeDraft>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.JobCurriculumProfile> saveCurriculum(
    _i1.TestSessionBuilder sessionBuilder, {
    required String markdownText,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobKnowledge',
            method: 'saveCurriculum',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobKnowledge',
          methodName: 'saveCurriculum',
          parameters: _i1.testObjectToJson({'markdownText': markdownText}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.JobCurriculumProfile>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.JobProposalStylePreference> saveProposalStylePreference(
    _i1.TestSessionBuilder sessionBuilder, {
    required String markdownText,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobKnowledge',
            method: 'saveProposalStylePreference',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobKnowledge',
          methodName: 'saveProposalStylePreference',
          parameters: _i1.testObjectToJson({'markdownText': markdownText}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.JobProposalStylePreference>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.JobOpportunityPreference> saveOpportunityPreference(
    _i1.TestSessionBuilder sessionBuilder, {
    required String markdownText,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jobKnowledge',
            method: 'saveOpportunityPreference',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jobKnowledge',
          methodName: 'saveOpportunityPreference',
          parameters: _i1.testObjectToJson({'markdownText': markdownText}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i14.JobOpportunityPreference>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _UpworkJobsEndpoint {
  _UpworkJobsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i15.JobInfo>> getJobs(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i16.JobFilter filter,
    required _i17.Pagination? pagination,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'upworkJobs',
            method: 'getJobs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'upworkJobs',
          methodName: 'getJobs',
          parameters: _i1.testObjectToJson({
            'filter': filter,
            'pagination': pagination,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i15.JobInfo>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}
