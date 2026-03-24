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
import '../entities/upwork_scrap/job_filter.dart' as _i2;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i3;

abstract class JobAutomationSettings
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  JobAutomationSettings._({
    this.id,
    required this.singletonKey,
    required this.jobFilter,
    required this.isJobFetchingPaused,
    required this.scoreBatchSize,
    required this.proposalBatchSize,
    required this.upworkSyncResultsPerPage,
    required this.proposalMinimumScorePercentage,
    required this.loopDelayMinutes,
    required this.updatedAt,
  });

  factory JobAutomationSettings({
    int? id,
    required String singletonKey,
    required _i2.JobFilter jobFilter,
    required bool isJobFetchingPaused,
    required int scoreBatchSize,
    required int proposalBatchSize,
    required int upworkSyncResultsPerPage,
    required int proposalMinimumScorePercentage,
    required int loopDelayMinutes,
    required DateTime updatedAt,
  }) = _JobAutomationSettingsImpl;

  factory JobAutomationSettings.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobAutomationSettings(
      id: jsonSerialization['id'] as int?,
      singletonKey: jsonSerialization['singletonKey'] as String,
      jobFilter: _i3.Protocol().deserialize<_i2.JobFilter>(
        jsonSerialization['jobFilter'],
      ),
      isJobFetchingPaused: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isJobFetchingPaused'],
      ),
      scoreBatchSize: jsonSerialization['scoreBatchSize'] as int,
      proposalBatchSize: jsonSerialization['proposalBatchSize'] as int,
      upworkSyncResultsPerPage:
          jsonSerialization['upworkSyncResultsPerPage'] as int,
      proposalMinimumScorePercentage:
          jsonSerialization['proposalMinimumScorePercentage'] as int,
      loopDelayMinutes: jsonSerialization['loopDelayMinutes'] as int,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = JobAutomationSettingsTable();

  static const db = JobAutomationSettingsRepository._();

  @override
  int? id;

  String singletonKey;

  _i2.JobFilter jobFilter;

  bool isJobFetchingPaused;

  int scoreBatchSize;

  int proposalBatchSize;

  int upworkSyncResultsPerPage;

  int proposalMinimumScorePercentage;

  int loopDelayMinutes;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobAutomationSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAutomationSettings copyWith({
    int? id,
    String? singletonKey,
    _i2.JobFilter? jobFilter,
    bool? isJobFetchingPaused,
    int? scoreBatchSize,
    int? proposalBatchSize,
    int? upworkSyncResultsPerPage,
    int? proposalMinimumScorePercentage,
    int? loopDelayMinutes,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAutomationSettings',
      if (id != null) 'id': id,
      'singletonKey': singletonKey,
      'jobFilter': jobFilter.toJson(),
      'isJobFetchingPaused': isJobFetchingPaused,
      'scoreBatchSize': scoreBatchSize,
      'proposalBatchSize': proposalBatchSize,
      'upworkSyncResultsPerPage': upworkSyncResultsPerPage,
      'proposalMinimumScorePercentage': proposalMinimumScorePercentage,
      'loopDelayMinutes': loopDelayMinutes,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobAutomationSettings',
      if (id != null) 'id': id,
      'singletonKey': singletonKey,
      'jobFilter': jobFilter.toJsonForProtocol(),
      'isJobFetchingPaused': isJobFetchingPaused,
      'scoreBatchSize': scoreBatchSize,
      'proposalBatchSize': proposalBatchSize,
      'upworkSyncResultsPerPage': upworkSyncResultsPerPage,
      'proposalMinimumScorePercentage': proposalMinimumScorePercentage,
      'loopDelayMinutes': loopDelayMinutes,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static JobAutomationSettingsInclude include() {
    return JobAutomationSettingsInclude._();
  }

  static JobAutomationSettingsIncludeList includeList({
    _i1.WhereExpressionBuilder<JobAutomationSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobAutomationSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobAutomationSettingsTable>? orderByList,
    JobAutomationSettingsInclude? include,
  }) {
    return JobAutomationSettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobAutomationSettings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JobAutomationSettings.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobAutomationSettingsImpl extends JobAutomationSettings {
  _JobAutomationSettingsImpl({
    int? id,
    required String singletonKey,
    required _i2.JobFilter jobFilter,
    required bool isJobFetchingPaused,
    required int scoreBatchSize,
    required int proposalBatchSize,
    required int upworkSyncResultsPerPage,
    required int proposalMinimumScorePercentage,
    required int loopDelayMinutes,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         singletonKey: singletonKey,
         jobFilter: jobFilter,
         isJobFetchingPaused: isJobFetchingPaused,
         scoreBatchSize: scoreBatchSize,
         proposalBatchSize: proposalBatchSize,
         upworkSyncResultsPerPage: upworkSyncResultsPerPage,
         proposalMinimumScorePercentage: proposalMinimumScorePercentage,
         loopDelayMinutes: loopDelayMinutes,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [JobAutomationSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAutomationSettings copyWith({
    Object? id = _Undefined,
    String? singletonKey,
    _i2.JobFilter? jobFilter,
    bool? isJobFetchingPaused,
    int? scoreBatchSize,
    int? proposalBatchSize,
    int? upworkSyncResultsPerPage,
    int? proposalMinimumScorePercentage,
    int? loopDelayMinutes,
    DateTime? updatedAt,
  }) {
    return JobAutomationSettings(
      id: id is int? ? id : this.id,
      singletonKey: singletonKey ?? this.singletonKey,
      jobFilter: jobFilter ?? this.jobFilter.copyWith(),
      isJobFetchingPaused: isJobFetchingPaused ?? this.isJobFetchingPaused,
      scoreBatchSize: scoreBatchSize ?? this.scoreBatchSize,
      proposalBatchSize: proposalBatchSize ?? this.proposalBatchSize,
      upworkSyncResultsPerPage:
          upworkSyncResultsPerPage ?? this.upworkSyncResultsPerPage,
      proposalMinimumScorePercentage:
          proposalMinimumScorePercentage ?? this.proposalMinimumScorePercentage,
      loopDelayMinutes: loopDelayMinutes ?? this.loopDelayMinutes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class JobAutomationSettingsUpdateTable
    extends _i1.UpdateTable<JobAutomationSettingsTable> {
  JobAutomationSettingsUpdateTable(super.table);

  _i1.ColumnValue<String, String> singletonKey(String value) => _i1.ColumnValue(
    table.singletonKey,
    value,
  );

  _i1.ColumnValue<_i2.JobFilter, _i2.JobFilter> jobFilter(
    _i2.JobFilter value,
  ) => _i1.ColumnValue(
    table.jobFilter,
    value,
  );

  _i1.ColumnValue<bool, bool> isJobFetchingPaused(bool value) =>
      _i1.ColumnValue(
        table.isJobFetchingPaused,
        value,
      );

  _i1.ColumnValue<int, int> scoreBatchSize(int value) => _i1.ColumnValue(
    table.scoreBatchSize,
    value,
  );

  _i1.ColumnValue<int, int> proposalBatchSize(int value) => _i1.ColumnValue(
    table.proposalBatchSize,
    value,
  );

  _i1.ColumnValue<int, int> upworkSyncResultsPerPage(int value) =>
      _i1.ColumnValue(
        table.upworkSyncResultsPerPage,
        value,
      );

  _i1.ColumnValue<int, int> proposalMinimumScorePercentage(int value) =>
      _i1.ColumnValue(
        table.proposalMinimumScorePercentage,
        value,
      );

  _i1.ColumnValue<int, int> loopDelayMinutes(int value) => _i1.ColumnValue(
    table.loopDelayMinutes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class JobAutomationSettingsTable extends _i1.Table<int?> {
  JobAutomationSettingsTable({super.tableRelation})
    : super(tableName: 'job_automation_settings') {
    updateTable = JobAutomationSettingsUpdateTable(this);
    singletonKey = _i1.ColumnString(
      'singletonKey',
      this,
    );
    jobFilter = _i1.ColumnSerializable<_i2.JobFilter>(
      'jobFilter',
      this,
    );
    isJobFetchingPaused = _i1.ColumnBool(
      'isJobFetchingPaused',
      this,
    );
    scoreBatchSize = _i1.ColumnInt(
      'scoreBatchSize',
      this,
    );
    proposalBatchSize = _i1.ColumnInt(
      'proposalBatchSize',
      this,
    );
    upworkSyncResultsPerPage = _i1.ColumnInt(
      'upworkSyncResultsPerPage',
      this,
    );
    proposalMinimumScorePercentage = _i1.ColumnInt(
      'proposalMinimumScorePercentage',
      this,
    );
    loopDelayMinutes = _i1.ColumnInt(
      'loopDelayMinutes',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final JobAutomationSettingsUpdateTable updateTable;

  late final _i1.ColumnString singletonKey;

  late final _i1.ColumnSerializable<_i2.JobFilter> jobFilter;

  late final _i1.ColumnBool isJobFetchingPaused;

  late final _i1.ColumnInt scoreBatchSize;

  late final _i1.ColumnInt proposalBatchSize;

  late final _i1.ColumnInt upworkSyncResultsPerPage;

  late final _i1.ColumnInt proposalMinimumScorePercentage;

  late final _i1.ColumnInt loopDelayMinutes;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    singletonKey,
    jobFilter,
    isJobFetchingPaused,
    scoreBatchSize,
    proposalBatchSize,
    upworkSyncResultsPerPage,
    proposalMinimumScorePercentage,
    loopDelayMinutes,
    updatedAt,
  ];
}

class JobAutomationSettingsInclude extends _i1.IncludeObject {
  JobAutomationSettingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => JobAutomationSettings.t;
}

class JobAutomationSettingsIncludeList extends _i1.IncludeList {
  JobAutomationSettingsIncludeList._({
    _i1.WhereExpressionBuilder<JobAutomationSettingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobAutomationSettings.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JobAutomationSettings.t;
}

class JobAutomationSettingsRepository {
  const JobAutomationSettingsRepository._();

  /// Returns a list of [JobAutomationSettings]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<JobAutomationSettings>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobAutomationSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobAutomationSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobAutomationSettingsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobAutomationSettings>(
      where: where?.call(JobAutomationSettings.t),
      orderBy: orderBy?.call(JobAutomationSettings.t),
      orderByList: orderByList?.call(JobAutomationSettings.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobAutomationSettings] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<JobAutomationSettings?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobAutomationSettingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<JobAutomationSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobAutomationSettingsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobAutomationSettings>(
      where: where?.call(JobAutomationSettings.t),
      orderBy: orderBy?.call(JobAutomationSettings.t),
      orderByList: orderByList?.call(JobAutomationSettings.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobAutomationSettings] by its [id] or null if no such row exists.
  Future<JobAutomationSettings?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobAutomationSettings>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobAutomationSettings]s in the list and returns the inserted rows.
  ///
  /// The returned [JobAutomationSettings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<JobAutomationSettings>> insert(
    _i1.DatabaseSession session,
    List<JobAutomationSettings> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<JobAutomationSettings>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [JobAutomationSettings] and returns the inserted row.
  ///
  /// The returned [JobAutomationSettings] will have its `id` field set.
  Future<JobAutomationSettings> insertRow(
    _i1.DatabaseSession session,
    JobAutomationSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobAutomationSettings>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JobAutomationSettings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JobAutomationSettings>> update(
    _i1.DatabaseSession session,
    List<JobAutomationSettings> rows, {
    _i1.ColumnSelections<JobAutomationSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JobAutomationSettings>(
      rows,
      columns: columns?.call(JobAutomationSettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobAutomationSettings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobAutomationSettings> updateRow(
    _i1.DatabaseSession session,
    JobAutomationSettings row, {
    _i1.ColumnSelections<JobAutomationSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobAutomationSettings>(
      row,
      columns: columns?.call(JobAutomationSettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobAutomationSettings] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobAutomationSettings?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<JobAutomationSettingsUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JobAutomationSettings>(
      id,
      columnValues: columnValues(JobAutomationSettings.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobAutomationSettings]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JobAutomationSettings>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<JobAutomationSettingsUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<JobAutomationSettingsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobAutomationSettingsTable>? orderBy,
    _i1.OrderByListBuilder<JobAutomationSettingsTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JobAutomationSettings>(
      columnValues: columnValues(JobAutomationSettings.t.updateTable),
      where: where(JobAutomationSettings.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobAutomationSettings.t),
      orderByList: orderByList?.call(JobAutomationSettings.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JobAutomationSettings]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JobAutomationSettings>> delete(
    _i1.DatabaseSession session,
    List<JobAutomationSettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JobAutomationSettings>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JobAutomationSettings].
  Future<JobAutomationSettings> deleteRow(
    _i1.DatabaseSession session,
    JobAutomationSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobAutomationSettings>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JobAutomationSettings>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobAutomationSettingsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JobAutomationSettings>(
      where: where(JobAutomationSettings.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobAutomationSettingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JobAutomationSettings>(
      where: where?.call(JobAutomationSettings.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobAutomationSettings] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobAutomationSettingsTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobAutomationSettings>(
      where: where(JobAutomationSettings.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
