/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../entities/job_analysis_state.dart' as _i2;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i3;

abstract class JobScore
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  JobScore._({
    this.id,
    required this.jobAnalysisStateId,
    this.jobAnalysisState,
    required this.scorePercentage,
    required this.aiScoreJustificationText,
  });

  factory JobScore({
    int? id,
    required int jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    required int scorePercentage,
    required String aiScoreJustificationText,
  }) = _JobScoreImpl;

  factory JobScore.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobScore(
      id: jsonSerialization['id'] as int?,
      jobAnalysisStateId: jsonSerialization['jobAnalysisStateId'] as int,
      jobAnalysisState: jsonSerialization['jobAnalysisState'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.JobAnalysisState>(
              jsonSerialization['jobAnalysisState'],
            ),
      scorePercentage: jsonSerialization['scorePercentage'] as int,
      aiScoreJustificationText:
          jsonSerialization['aiScoreJustificationText'] as String,
    );
  }

  static final t = JobScoreTable();

  static const db = JobScoreRepository._();

  @override
  int? id;

  int jobAnalysisStateId;

  _i2.JobAnalysisState? jobAnalysisState;

  int scorePercentage;

  String aiScoreJustificationText;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobScore copyWith({
    int? id,
    int? jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    int? scorePercentage,
    String? aiScoreJustificationText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobScore',
      if (id != null) 'id': id,
      'jobAnalysisStateId': jobAnalysisStateId,
      if (jobAnalysisState != null)
        'jobAnalysisState': jobAnalysisState?.toJson(),
      'scorePercentage': scorePercentage,
      'aiScoreJustificationText': aiScoreJustificationText,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobScore',
      if (id != null) 'id': id,
      'jobAnalysisStateId': jobAnalysisStateId,
      if (jobAnalysisState != null)
        'jobAnalysisState': jobAnalysisState?.toJsonForProtocol(),
      'scorePercentage': scorePercentage,
      'aiScoreJustificationText': aiScoreJustificationText,
    };
  }

  static JobScoreInclude include({
    _i2.JobAnalysisStateInclude? jobAnalysisState,
  }) {
    return JobScoreInclude._(jobAnalysisState: jobAnalysisState);
  }

  static JobScoreIncludeList includeList({
    _i1.WhereExpressionBuilder<JobScoreTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobScoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobScoreTable>? orderByList,
    JobScoreInclude? include,
  }) {
    return JobScoreIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobScore.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JobScore.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobScoreImpl extends JobScore {
  _JobScoreImpl({
    int? id,
    required int jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    required int scorePercentage,
    required String aiScoreJustificationText,
  }) : super._(
         id: id,
         jobAnalysisStateId: jobAnalysisStateId,
         jobAnalysisState: jobAnalysisState,
         scorePercentage: scorePercentage,
         aiScoreJustificationText: aiScoreJustificationText,
       );

  /// Returns a shallow copy of this [JobScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobScore copyWith({
    Object? id = _Undefined,
    int? jobAnalysisStateId,
    Object? jobAnalysisState = _Undefined,
    int? scorePercentage,
    String? aiScoreJustificationText,
  }) {
    return JobScore(
      id: id is int? ? id : this.id,
      jobAnalysisStateId: jobAnalysisStateId ?? this.jobAnalysisStateId,
      jobAnalysisState: jobAnalysisState is _i2.JobAnalysisState?
          ? jobAnalysisState
          : this.jobAnalysisState?.copyWith(),
      scorePercentage: scorePercentage ?? this.scorePercentage,
      aiScoreJustificationText:
          aiScoreJustificationText ?? this.aiScoreJustificationText,
    );
  }
}

class JobScoreUpdateTable extends _i1.UpdateTable<JobScoreTable> {
  JobScoreUpdateTable(super.table);

  _i1.ColumnValue<int, int> jobAnalysisStateId(int value) => _i1.ColumnValue(
    table.jobAnalysisStateId,
    value,
  );

  _i1.ColumnValue<int, int> scorePercentage(int value) => _i1.ColumnValue(
    table.scorePercentage,
    value,
  );

  _i1.ColumnValue<String, String> aiScoreJustificationText(String value) =>
      _i1.ColumnValue(
        table.aiScoreJustificationText,
        value,
      );
}

class JobScoreTable extends _i1.Table<int?> {
  JobScoreTable({super.tableRelation}) : super(tableName: 'job_score') {
    updateTable = JobScoreUpdateTable(this);
    jobAnalysisStateId = _i1.ColumnInt(
      'jobAnalysisStateId',
      this,
    );
    scorePercentage = _i1.ColumnInt(
      'scorePercentage',
      this,
    );
    aiScoreJustificationText = _i1.ColumnString(
      'aiScoreJustificationText',
      this,
    );
  }

  late final JobScoreUpdateTable updateTable;

  late final _i1.ColumnInt jobAnalysisStateId;

  _i2.JobAnalysisStateTable? _jobAnalysisState;

  late final _i1.ColumnInt scorePercentage;

  late final _i1.ColumnString aiScoreJustificationText;

  _i2.JobAnalysisStateTable get jobAnalysisState {
    if (_jobAnalysisState != null) return _jobAnalysisState!;
    _jobAnalysisState = _i1.createRelationTable(
      relationFieldName: 'jobAnalysisState',
      field: JobScore.t.jobAnalysisStateId,
      foreignField: _i2.JobAnalysisState.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.JobAnalysisStateTable(tableRelation: foreignTableRelation),
    );
    return _jobAnalysisState!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    jobAnalysisStateId,
    scorePercentage,
    aiScoreJustificationText,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'jobAnalysisState') {
      return jobAnalysisState;
    }
    return null;
  }
}

class JobScoreInclude extends _i1.IncludeObject {
  JobScoreInclude._({_i2.JobAnalysisStateInclude? jobAnalysisState}) {
    _jobAnalysisState = jobAnalysisState;
  }

  _i2.JobAnalysisStateInclude? _jobAnalysisState;

  @override
  Map<String, _i1.Include?> get includes => {
    'jobAnalysisState': _jobAnalysisState,
  };

  @override
  _i1.Table<int?> get table => JobScore.t;
}

class JobScoreIncludeList extends _i1.IncludeList {
  JobScoreIncludeList._({
    _i1.WhereExpressionBuilder<JobScoreTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobScore.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JobScore.t;
}

class JobScoreRepository {
  const JobScoreRepository._();

  final attachRow = const JobScoreAttachRowRepository._();

  /// Returns a list of [JobScore]s matching the given query parameters.
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
  Future<List<JobScore>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobScoreTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobScoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobScoreTable>? orderByList,
    _i1.Transaction? transaction,
    JobScoreInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobScore>(
      where: where?.call(JobScore.t),
      orderBy: orderBy?.call(JobScore.t),
      orderByList: orderByList?.call(JobScore.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobScore] matching the given query parameters.
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
  Future<JobScore?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobScoreTable>? where,
    int? offset,
    _i1.OrderByBuilder<JobScoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobScoreTable>? orderByList,
    _i1.Transaction? transaction,
    JobScoreInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobScore>(
      where: where?.call(JobScore.t),
      orderBy: orderBy?.call(JobScore.t),
      orderByList: orderByList?.call(JobScore.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobScore] by its [id] or null if no such row exists.
  Future<JobScore?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    JobScoreInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobScore>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobScore]s in the list and returns the inserted rows.
  ///
  /// The returned [JobScore]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<JobScore>> insert(
    _i1.DatabaseSession session,
    List<JobScore> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<JobScore>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [JobScore] and returns the inserted row.
  ///
  /// The returned [JobScore] will have its `id` field set.
  Future<JobScore> insertRow(
    _i1.DatabaseSession session,
    JobScore row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobScore>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JobScore]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JobScore>> update(
    _i1.DatabaseSession session,
    List<JobScore> rows, {
    _i1.ColumnSelections<JobScoreTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JobScore>(
      rows,
      columns: columns?.call(JobScore.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobScore]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobScore> updateRow(
    _i1.DatabaseSession session,
    JobScore row, {
    _i1.ColumnSelections<JobScoreTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobScore>(
      row,
      columns: columns?.call(JobScore.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobScore] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobScore?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<JobScoreUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JobScore>(
      id,
      columnValues: columnValues(JobScore.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobScore]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JobScore>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<JobScoreUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<JobScoreTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobScoreTable>? orderBy,
    _i1.OrderByListBuilder<JobScoreTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JobScore>(
      columnValues: columnValues(JobScore.t.updateTable),
      where: where(JobScore.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobScore.t),
      orderByList: orderByList?.call(JobScore.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JobScore]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JobScore>> delete(
    _i1.DatabaseSession session,
    List<JobScore> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JobScore>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JobScore].
  Future<JobScore> deleteRow(
    _i1.DatabaseSession session,
    JobScore row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobScore>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JobScore>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobScoreTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JobScore>(
      where: where(JobScore.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobScoreTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JobScore>(
      where: where?.call(JobScore.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobScore] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobScoreTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobScore>(
      where: where(JobScore.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class JobScoreAttachRowRepository {
  const JobScoreAttachRowRepository._();

  /// Creates a relation between the given [JobScore] and [JobAnalysisState]
  /// by setting the [JobScore]'s foreign key `jobAnalysisStateId` to refer to the [JobAnalysisState].
  Future<void> jobAnalysisState(
    _i1.DatabaseSession session,
    JobScore jobScore,
    _i2.JobAnalysisState jobAnalysisState, {
    _i1.Transaction? transaction,
  }) async {
    if (jobScore.id == null) {
      throw ArgumentError.notNull('jobScore.id');
    }
    if (jobAnalysisState.id == null) {
      throw ArgumentError.notNull('jobAnalysisState.id');
    }

    var $jobScore = jobScore.copyWith(jobAnalysisStateId: jobAnalysisState.id);
    await session.db.updateRow<JobScore>(
      $jobScore,
      columns: [JobScore.t.jobAnalysisStateId],
      transaction: transaction,
    );
  }
}
