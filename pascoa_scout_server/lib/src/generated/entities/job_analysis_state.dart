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
import '../entities/upwork_scrap/job_info.dart' as _i2;
import '../entities/job_score.dart' as _i3;
import '../entities/job_proposal.dart' as _i4;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i5;

abstract class JobAnalysisState
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  JobAnalysisState._({
    this.id,
    required this.jobInfoId,
    this.jobInfo,
    this.score,
    this.proposal,
    required this.createdJobInfoAt,
    this.createdJobScoringAt,
    this.createdJobAiResponsesAt,
  });

  factory JobAnalysisState({
    int? id,
    required int jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobScore? score,
    _i4.JobProposal? proposal,
    required DateTime createdJobInfoAt,
    DateTime? createdJobScoringAt,
    DateTime? createdJobAiResponsesAt,
  }) = _JobAnalysisStateImpl;

  factory JobAnalysisState.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobAnalysisState(
      id: jsonSerialization['id'] as int?,
      jobInfoId: jsonSerialization['jobInfoId'] as int,
      jobInfo: jsonSerialization['jobInfo'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.JobInfo>(
              jsonSerialization['jobInfo'],
            ),
      score: jsonSerialization['score'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.JobScore>(
              jsonSerialization['score'],
            ),
      proposal: jsonSerialization['proposal'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.JobProposal>(
              jsonSerialization['proposal'],
            ),
      createdJobInfoAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdJobInfoAt'],
      ),
      createdJobScoringAt: jsonSerialization['createdJobScoringAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['createdJobScoringAt'],
            ),
      createdJobAiResponsesAt:
          jsonSerialization['createdJobAiResponsesAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['createdJobAiResponsesAt'],
            ),
    );
  }

  static final t = JobAnalysisStateTable();

  static const db = JobAnalysisStateRepository._();

  @override
  int? id;

  int jobInfoId;

  _i2.JobInfo? jobInfo;

  _i3.JobScore? score;

  _i4.JobProposal? proposal;

  DateTime createdJobInfoAt;

  DateTime? createdJobScoringAt;

  DateTime? createdJobAiResponsesAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobAnalysisState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAnalysisState copyWith({
    int? id,
    int? jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobScore? score,
    _i4.JobProposal? proposal,
    DateTime? createdJobInfoAt,
    DateTime? createdJobScoringAt,
    DateTime? createdJobAiResponsesAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAnalysisState',
      if (id != null) 'id': id,
      'jobInfoId': jobInfoId,
      if (jobInfo != null) 'jobInfo': jobInfo?.toJson(),
      if (score != null) 'score': score?.toJson(),
      if (proposal != null) 'proposal': proposal?.toJson(),
      'createdJobInfoAt': createdJobInfoAt.toJson(),
      if (createdJobScoringAt != null)
        'createdJobScoringAt': createdJobScoringAt?.toJson(),
      if (createdJobAiResponsesAt != null)
        'createdJobAiResponsesAt': createdJobAiResponsesAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobAnalysisState',
      if (id != null) 'id': id,
      'jobInfoId': jobInfoId,
      if (jobInfo != null) 'jobInfo': jobInfo?.toJsonForProtocol(),
      if (score != null) 'score': score?.toJsonForProtocol(),
      if (proposal != null) 'proposal': proposal?.toJsonForProtocol(),
      'createdJobInfoAt': createdJobInfoAt.toJson(),
      if (createdJobScoringAt != null)
        'createdJobScoringAt': createdJobScoringAt?.toJson(),
      if (createdJobAiResponsesAt != null)
        'createdJobAiResponsesAt': createdJobAiResponsesAt?.toJson(),
    };
  }

  static JobAnalysisStateInclude include({
    _i2.JobInfoInclude? jobInfo,
    _i3.JobScoreInclude? score,
    _i4.JobProposalInclude? proposal,
  }) {
    return JobAnalysisStateInclude._(
      jobInfo: jobInfo,
      score: score,
      proposal: proposal,
    );
  }

  static JobAnalysisStateIncludeList includeList({
    _i1.WhereExpressionBuilder<JobAnalysisStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobAnalysisStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobAnalysisStateTable>? orderByList,
    JobAnalysisStateInclude? include,
  }) {
    return JobAnalysisStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobAnalysisState.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JobAnalysisState.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobAnalysisStateImpl extends JobAnalysisState {
  _JobAnalysisStateImpl({
    int? id,
    required int jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobScore? score,
    _i4.JobProposal? proposal,
    required DateTime createdJobInfoAt,
    DateTime? createdJobScoringAt,
    DateTime? createdJobAiResponsesAt,
  }) : super._(
         id: id,
         jobInfoId: jobInfoId,
         jobInfo: jobInfo,
         score: score,
         proposal: proposal,
         createdJobInfoAt: createdJobInfoAt,
         createdJobScoringAt: createdJobScoringAt,
         createdJobAiResponsesAt: createdJobAiResponsesAt,
       );

  /// Returns a shallow copy of this [JobAnalysisState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAnalysisState copyWith({
    Object? id = _Undefined,
    int? jobInfoId,
    Object? jobInfo = _Undefined,
    Object? score = _Undefined,
    Object? proposal = _Undefined,
    DateTime? createdJobInfoAt,
    Object? createdJobScoringAt = _Undefined,
    Object? createdJobAiResponsesAt = _Undefined,
  }) {
    return JobAnalysisState(
      id: id is int? ? id : this.id,
      jobInfoId: jobInfoId ?? this.jobInfoId,
      jobInfo: jobInfo is _i2.JobInfo? ? jobInfo : this.jobInfo?.copyWith(),
      score: score is _i3.JobScore? ? score : this.score?.copyWith(),
      proposal: proposal is _i4.JobProposal?
          ? proposal
          : this.proposal?.copyWith(),
      createdJobInfoAt: createdJobInfoAt ?? this.createdJobInfoAt,
      createdJobScoringAt: createdJobScoringAt is DateTime?
          ? createdJobScoringAt
          : this.createdJobScoringAt,
      createdJobAiResponsesAt: createdJobAiResponsesAt is DateTime?
          ? createdJobAiResponsesAt
          : this.createdJobAiResponsesAt,
    );
  }
}

class JobAnalysisStateUpdateTable
    extends _i1.UpdateTable<JobAnalysisStateTable> {
  JobAnalysisStateUpdateTable(super.table);

  _i1.ColumnValue<int, int> jobInfoId(int value) => _i1.ColumnValue(
    table.jobInfoId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdJobInfoAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdJobInfoAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdJobScoringAt(DateTime? value) =>
      _i1.ColumnValue(
        table.createdJobScoringAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdJobAiResponsesAt(
    DateTime? value,
  ) => _i1.ColumnValue(
    table.createdJobAiResponsesAt,
    value,
  );
}

class JobAnalysisStateTable extends _i1.Table<int?> {
  JobAnalysisStateTable({super.tableRelation})
    : super(tableName: 'job_analysis_state') {
    updateTable = JobAnalysisStateUpdateTable(this);
    jobInfoId = _i1.ColumnInt(
      'jobInfoId',
      this,
    );
    createdJobInfoAt = _i1.ColumnDateTime(
      'createdJobInfoAt',
      this,
    );
    createdJobScoringAt = _i1.ColumnDateTime(
      'createdJobScoringAt',
      this,
    );
    createdJobAiResponsesAt = _i1.ColumnDateTime(
      'createdJobAiResponsesAt',
      this,
    );
  }

  late final JobAnalysisStateUpdateTable updateTable;

  late final _i1.ColumnInt jobInfoId;

  _i2.JobInfoTable? _jobInfo;

  _i3.JobScoreTable? _score;

  _i4.JobProposalTable? _proposal;

  late final _i1.ColumnDateTime createdJobInfoAt;

  late final _i1.ColumnDateTime createdJobScoringAt;

  late final _i1.ColumnDateTime createdJobAiResponsesAt;

  _i2.JobInfoTable get jobInfo {
    if (_jobInfo != null) return _jobInfo!;
    _jobInfo = _i1.createRelationTable(
      relationFieldName: 'jobInfo',
      field: JobAnalysisState.t.jobInfoId,
      foreignField: _i2.JobInfo.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.JobInfoTable(tableRelation: foreignTableRelation),
    );
    return _jobInfo!;
  }

  _i3.JobScoreTable get score {
    if (_score != null) return _score!;
    _score = _i1.createRelationTable(
      relationFieldName: 'score',
      field: JobAnalysisState.t.id,
      foreignField: _i3.JobScore.t.jobAnalysisStateId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.JobScoreTable(tableRelation: foreignTableRelation),
    );
    return _score!;
  }

  _i4.JobProposalTable get proposal {
    if (_proposal != null) return _proposal!;
    _proposal = _i1.createRelationTable(
      relationFieldName: 'proposal',
      field: JobAnalysisState.t.id,
      foreignField: _i4.JobProposal.t.jobAnalysisStateId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.JobProposalTable(tableRelation: foreignTableRelation),
    );
    return _proposal!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    jobInfoId,
    createdJobInfoAt,
    createdJobScoringAt,
    createdJobAiResponsesAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'jobInfo') {
      return jobInfo;
    }
    if (relationField == 'score') {
      return score;
    }
    if (relationField == 'proposal') {
      return proposal;
    }
    return null;
  }
}

class JobAnalysisStateInclude extends _i1.IncludeObject {
  JobAnalysisStateInclude._({
    _i2.JobInfoInclude? jobInfo,
    _i3.JobScoreInclude? score,
    _i4.JobProposalInclude? proposal,
  }) {
    _jobInfo = jobInfo;
    _score = score;
    _proposal = proposal;
  }

  _i2.JobInfoInclude? _jobInfo;

  _i3.JobScoreInclude? _score;

  _i4.JobProposalInclude? _proposal;

  @override
  Map<String, _i1.Include?> get includes => {
    'jobInfo': _jobInfo,
    'score': _score,
    'proposal': _proposal,
  };

  @override
  _i1.Table<int?> get table => JobAnalysisState.t;
}

class JobAnalysisStateIncludeList extends _i1.IncludeList {
  JobAnalysisStateIncludeList._({
    _i1.WhereExpressionBuilder<JobAnalysisStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobAnalysisState.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JobAnalysisState.t;
}

class JobAnalysisStateRepository {
  const JobAnalysisStateRepository._();

  final attachRow = const JobAnalysisStateAttachRowRepository._();

  final detachRow = const JobAnalysisStateDetachRowRepository._();

  /// Returns a list of [JobAnalysisState]s matching the given query parameters.
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
  Future<List<JobAnalysisState>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobAnalysisStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobAnalysisStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobAnalysisStateTable>? orderByList,
    _i1.Transaction? transaction,
    JobAnalysisStateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobAnalysisState>(
      where: where?.call(JobAnalysisState.t),
      orderBy: orderBy?.call(JobAnalysisState.t),
      orderByList: orderByList?.call(JobAnalysisState.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobAnalysisState] matching the given query parameters.
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
  Future<JobAnalysisState?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobAnalysisStateTable>? where,
    int? offset,
    _i1.OrderByBuilder<JobAnalysisStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobAnalysisStateTable>? orderByList,
    _i1.Transaction? transaction,
    JobAnalysisStateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobAnalysisState>(
      where: where?.call(JobAnalysisState.t),
      orderBy: orderBy?.call(JobAnalysisState.t),
      orderByList: orderByList?.call(JobAnalysisState.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobAnalysisState] by its [id] or null if no such row exists.
  Future<JobAnalysisState?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    JobAnalysisStateInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobAnalysisState>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobAnalysisState]s in the list and returns the inserted rows.
  ///
  /// The returned [JobAnalysisState]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<JobAnalysisState>> insert(
    _i1.DatabaseSession session,
    List<JobAnalysisState> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<JobAnalysisState>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [JobAnalysisState] and returns the inserted row.
  ///
  /// The returned [JobAnalysisState] will have its `id` field set.
  Future<JobAnalysisState> insertRow(
    _i1.DatabaseSession session,
    JobAnalysisState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobAnalysisState>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JobAnalysisState]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JobAnalysisState>> update(
    _i1.DatabaseSession session,
    List<JobAnalysisState> rows, {
    _i1.ColumnSelections<JobAnalysisStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JobAnalysisState>(
      rows,
      columns: columns?.call(JobAnalysisState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobAnalysisState]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobAnalysisState> updateRow(
    _i1.DatabaseSession session,
    JobAnalysisState row, {
    _i1.ColumnSelections<JobAnalysisStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobAnalysisState>(
      row,
      columns: columns?.call(JobAnalysisState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobAnalysisState] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobAnalysisState?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<JobAnalysisStateUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JobAnalysisState>(
      id,
      columnValues: columnValues(JobAnalysisState.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobAnalysisState]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JobAnalysisState>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<JobAnalysisStateUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<JobAnalysisStateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobAnalysisStateTable>? orderBy,
    _i1.OrderByListBuilder<JobAnalysisStateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JobAnalysisState>(
      columnValues: columnValues(JobAnalysisState.t.updateTable),
      where: where(JobAnalysisState.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobAnalysisState.t),
      orderByList: orderByList?.call(JobAnalysisState.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JobAnalysisState]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JobAnalysisState>> delete(
    _i1.DatabaseSession session,
    List<JobAnalysisState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JobAnalysisState>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JobAnalysisState].
  Future<JobAnalysisState> deleteRow(
    _i1.DatabaseSession session,
    JobAnalysisState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobAnalysisState>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JobAnalysisState>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobAnalysisStateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JobAnalysisState>(
      where: where(JobAnalysisState.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobAnalysisStateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JobAnalysisState>(
      where: where?.call(JobAnalysisState.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobAnalysisState] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobAnalysisStateTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobAnalysisState>(
      where: where(JobAnalysisState.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class JobAnalysisStateAttachRowRepository {
  const JobAnalysisStateAttachRowRepository._();

  /// Creates a relation between the given [JobAnalysisState] and [JobInfo]
  /// by setting the [JobAnalysisState]'s foreign key `jobInfoId` to refer to the [JobInfo].
  Future<void> jobInfo(
    _i1.DatabaseSession session,
    JobAnalysisState jobAnalysisState,
    _i2.JobInfo jobInfo, {
    _i1.Transaction? transaction,
  }) async {
    if (jobAnalysisState.id == null) {
      throw ArgumentError.notNull('jobAnalysisState.id');
    }
    if (jobInfo.id == null) {
      throw ArgumentError.notNull('jobInfo.id');
    }

    var $jobAnalysisState = jobAnalysisState.copyWith(jobInfoId: jobInfo.id);
    await session.db.updateRow<JobAnalysisState>(
      $jobAnalysisState,
      columns: [JobAnalysisState.t.jobInfoId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [JobAnalysisState] and [JobScore]
  /// by setting the [JobAnalysisState]'s foreign key `id` to refer to the [JobScore].
  Future<void> score(
    _i1.DatabaseSession session,
    JobAnalysisState jobAnalysisState,
    _i3.JobScore score, {
    _i1.Transaction? transaction,
  }) async {
    if (score.id == null) {
      throw ArgumentError.notNull('score.id');
    }
    if (jobAnalysisState.id == null) {
      throw ArgumentError.notNull('jobAnalysisState.id');
    }

    var $score = score.copyWith(jobAnalysisStateId: jobAnalysisState.id);
    await session.db.updateRow<_i3.JobScore>(
      $score,
      columns: [_i3.JobScore.t.jobAnalysisStateId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [JobAnalysisState] and [JobProposal]
  /// by setting the [JobAnalysisState]'s foreign key `id` to refer to the [JobProposal].
  Future<void> proposal(
    _i1.DatabaseSession session,
    JobAnalysisState jobAnalysisState,
    _i4.JobProposal proposal, {
    _i1.Transaction? transaction,
  }) async {
    if (proposal.id == null) {
      throw ArgumentError.notNull('proposal.id');
    }
    if (jobAnalysisState.id == null) {
      throw ArgumentError.notNull('jobAnalysisState.id');
    }

    var $proposal = proposal.copyWith(jobAnalysisStateId: jobAnalysisState.id);
    await session.db.updateRow<_i4.JobProposal>(
      $proposal,
      columns: [_i4.JobProposal.t.jobAnalysisStateId],
      transaction: transaction,
    );
  }
}

class JobAnalysisStateDetachRowRepository {
  const JobAnalysisStateDetachRowRepository._();

  /// Detaches the relation between this [JobAnalysisState] and the [JobScore] set in `score`
  /// by setting the [JobAnalysisState]'s foreign key `id` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> score(
    _i1.DatabaseSession session,
    JobAnalysisState jobAnalysisState, {
    _i1.Transaction? transaction,
  }) async {
    var $score = jobAnalysisState.score;

    if ($score == null) {
      throw ArgumentError.notNull('jobAnalysisState.score');
    }
    if ($score.id == null) {
      throw ArgumentError.notNull('jobAnalysisState.score.id');
    }
    if (jobAnalysisState.id == null) {
      throw ArgumentError.notNull('jobAnalysisState.id');
    }

    var $$score = $score.copyWith(jobAnalysisStateId: null);
    await session.db.updateRow<_i3.JobScore>(
      $$score,
      columns: [_i3.JobScore.t.jobAnalysisStateId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [JobAnalysisState] and the [JobProposal] set in `proposal`
  /// by setting the [JobAnalysisState]'s foreign key `id` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> proposal(
    _i1.DatabaseSession session,
    JobAnalysisState jobAnalysisState, {
    _i1.Transaction? transaction,
  }) async {
    var $proposal = jobAnalysisState.proposal;

    if ($proposal == null) {
      throw ArgumentError.notNull('jobAnalysisState.proposal');
    }
    if ($proposal.id == null) {
      throw ArgumentError.notNull('jobAnalysisState.proposal.id');
    }
    if (jobAnalysisState.id == null) {
      throw ArgumentError.notNull('jobAnalysisState.id');
    }

    var $$proposal = $proposal.copyWith(jobAnalysisStateId: null);
    await session.db.updateRow<_i4.JobProposal>(
      $$proposal,
      columns: [_i4.JobProposal.t.jobAnalysisStateId],
      transaction: transaction,
    );
  }
}
