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
import '../entities/job_proposal_answer_to_question.dart' as _i3;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i4;

abstract class JobProposal
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  JobProposal._({
    this.id,
    required this.jobAnalysisStateId,
    this.jobAnalysisState,
    required this.aiGeneratedCoverLetterText,
    this.answers,
  });

  factory JobProposal({
    int? id,
    required int jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    required String aiGeneratedCoverLetterText,
    List<_i3.JobProposalAnswerToQuestion>? answers,
  }) = _JobProposalImpl;

  factory JobProposal.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobProposal(
      id: jsonSerialization['id'] as int?,
      jobAnalysisStateId: jsonSerialization['jobAnalysisStateId'] as int,
      jobAnalysisState: jsonSerialization['jobAnalysisState'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.JobAnalysisState>(
              jsonSerialization['jobAnalysisState'],
            ),
      aiGeneratedCoverLetterText:
          jsonSerialization['aiGeneratedCoverLetterText'] as String,
      answers: jsonSerialization['answers'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.JobProposalAnswerToQuestion>>(
              jsonSerialization['answers'],
            ),
    );
  }

  static final t = JobProposalTable();

  static const db = JobProposalRepository._();

  @override
  int? id;

  int jobAnalysisStateId;

  _i2.JobAnalysisState? jobAnalysisState;

  String aiGeneratedCoverLetterText;

  List<_i3.JobProposalAnswerToQuestion>? answers;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobProposal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobProposal copyWith({
    int? id,
    int? jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    String? aiGeneratedCoverLetterText,
    List<_i3.JobProposalAnswerToQuestion>? answers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobProposal',
      if (id != null) 'id': id,
      'jobAnalysisStateId': jobAnalysisStateId,
      if (jobAnalysisState != null)
        'jobAnalysisState': jobAnalysisState?.toJson(),
      'aiGeneratedCoverLetterText': aiGeneratedCoverLetterText,
      if (answers != null)
        'answers': answers?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobProposal',
      if (id != null) 'id': id,
      'jobAnalysisStateId': jobAnalysisStateId,
      if (jobAnalysisState != null)
        'jobAnalysisState': jobAnalysisState?.toJsonForProtocol(),
      'aiGeneratedCoverLetterText': aiGeneratedCoverLetterText,
      if (answers != null)
        'answers': answers?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static JobProposalInclude include({
    _i2.JobAnalysisStateInclude? jobAnalysisState,
    _i3.JobProposalAnswerToQuestionIncludeList? answers,
  }) {
    return JobProposalInclude._(
      jobAnalysisState: jobAnalysisState,
      answers: answers,
    );
  }

  static JobProposalIncludeList includeList({
    _i1.WhereExpressionBuilder<JobProposalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobProposalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobProposalTable>? orderByList,
    JobProposalInclude? include,
  }) {
    return JobProposalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobProposal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JobProposal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobProposalImpl extends JobProposal {
  _JobProposalImpl({
    int? id,
    required int jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    required String aiGeneratedCoverLetterText,
    List<_i3.JobProposalAnswerToQuestion>? answers,
  }) : super._(
         id: id,
         jobAnalysisStateId: jobAnalysisStateId,
         jobAnalysisState: jobAnalysisState,
         aiGeneratedCoverLetterText: aiGeneratedCoverLetterText,
         answers: answers,
       );

  /// Returns a shallow copy of this [JobProposal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobProposal copyWith({
    Object? id = _Undefined,
    int? jobAnalysisStateId,
    Object? jobAnalysisState = _Undefined,
    String? aiGeneratedCoverLetterText,
    Object? answers = _Undefined,
  }) {
    return JobProposal(
      id: id is int? ? id : this.id,
      jobAnalysisStateId: jobAnalysisStateId ?? this.jobAnalysisStateId,
      jobAnalysisState: jobAnalysisState is _i2.JobAnalysisState?
          ? jobAnalysisState
          : this.jobAnalysisState?.copyWith(),
      aiGeneratedCoverLetterText:
          aiGeneratedCoverLetterText ?? this.aiGeneratedCoverLetterText,
      answers: answers is List<_i3.JobProposalAnswerToQuestion>?
          ? answers
          : this.answers?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class JobProposalUpdateTable extends _i1.UpdateTable<JobProposalTable> {
  JobProposalUpdateTable(super.table);

  _i1.ColumnValue<int, int> jobAnalysisStateId(int value) => _i1.ColumnValue(
    table.jobAnalysisStateId,
    value,
  );

  _i1.ColumnValue<String, String> aiGeneratedCoverLetterText(String value) =>
      _i1.ColumnValue(
        table.aiGeneratedCoverLetterText,
        value,
      );
}

class JobProposalTable extends _i1.Table<int?> {
  JobProposalTable({super.tableRelation}) : super(tableName: 'job_proposal') {
    updateTable = JobProposalUpdateTable(this);
    jobAnalysisStateId = _i1.ColumnInt(
      'jobAnalysisStateId',
      this,
    );
    aiGeneratedCoverLetterText = _i1.ColumnString(
      'aiGeneratedCoverLetterText',
      this,
    );
  }

  late final JobProposalUpdateTable updateTable;

  late final _i1.ColumnInt jobAnalysisStateId;

  _i2.JobAnalysisStateTable? _jobAnalysisState;

  late final _i1.ColumnString aiGeneratedCoverLetterText;

  _i3.JobProposalAnswerToQuestionTable? ___answers;

  _i1.ManyRelation<_i3.JobProposalAnswerToQuestionTable>? _answers;

  _i2.JobAnalysisStateTable get jobAnalysisState {
    if (_jobAnalysisState != null) return _jobAnalysisState!;
    _jobAnalysisState = _i1.createRelationTable(
      relationFieldName: 'jobAnalysisState',
      field: JobProposal.t.jobAnalysisStateId,
      foreignField: _i2.JobAnalysisState.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.JobAnalysisStateTable(tableRelation: foreignTableRelation),
    );
    return _jobAnalysisState!;
  }

  _i3.JobProposalAnswerToQuestionTable get __answers {
    if (___answers != null) return ___answers!;
    ___answers = _i1.createRelationTable(
      relationFieldName: '__answers',
      field: JobProposal.t.id,
      foreignField: _i3.JobProposalAnswerToQuestion.t.jobProposalId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.JobProposalAnswerToQuestionTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return ___answers!;
  }

  _i1.ManyRelation<_i3.JobProposalAnswerToQuestionTable> get answers {
    if (_answers != null) return _answers!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'answers',
      field: JobProposal.t.id,
      foreignField: _i3.JobProposalAnswerToQuestion.t.jobProposalId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.JobProposalAnswerToQuestionTable(
            tableRelation: foreignTableRelation,
          ),
    );
    _answers = _i1.ManyRelation<_i3.JobProposalAnswerToQuestionTable>(
      tableWithRelations: relationTable,
      table: _i3.JobProposalAnswerToQuestionTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _answers!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    jobAnalysisStateId,
    aiGeneratedCoverLetterText,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'jobAnalysisState') {
      return jobAnalysisState;
    }
    if (relationField == 'answers') {
      return __answers;
    }
    return null;
  }
}

class JobProposalInclude extends _i1.IncludeObject {
  JobProposalInclude._({
    _i2.JobAnalysisStateInclude? jobAnalysisState,
    _i3.JobProposalAnswerToQuestionIncludeList? answers,
  }) {
    _jobAnalysisState = jobAnalysisState;
    _answers = answers;
  }

  _i2.JobAnalysisStateInclude? _jobAnalysisState;

  _i3.JobProposalAnswerToQuestionIncludeList? _answers;

  @override
  Map<String, _i1.Include?> get includes => {
    'jobAnalysisState': _jobAnalysisState,
    'answers': _answers,
  };

  @override
  _i1.Table<int?> get table => JobProposal.t;
}

class JobProposalIncludeList extends _i1.IncludeList {
  JobProposalIncludeList._({
    _i1.WhereExpressionBuilder<JobProposalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobProposal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JobProposal.t;
}

class JobProposalRepository {
  const JobProposalRepository._();

  final attach = const JobProposalAttachRepository._();

  final attachRow = const JobProposalAttachRowRepository._();

  final detach = const JobProposalDetachRepository._();

  final detachRow = const JobProposalDetachRowRepository._();

  /// Returns a list of [JobProposal]s matching the given query parameters.
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
  Future<List<JobProposal>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobProposalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobProposalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobProposalTable>? orderByList,
    _i1.Transaction? transaction,
    JobProposalInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobProposal>(
      where: where?.call(JobProposal.t),
      orderBy: orderBy?.call(JobProposal.t),
      orderByList: orderByList?.call(JobProposal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobProposal] matching the given query parameters.
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
  Future<JobProposal?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobProposalTable>? where,
    int? offset,
    _i1.OrderByBuilder<JobProposalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobProposalTable>? orderByList,
    _i1.Transaction? transaction,
    JobProposalInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobProposal>(
      where: where?.call(JobProposal.t),
      orderBy: orderBy?.call(JobProposal.t),
      orderByList: orderByList?.call(JobProposal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobProposal] by its [id] or null if no such row exists.
  Future<JobProposal?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    JobProposalInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobProposal>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobProposal]s in the list and returns the inserted rows.
  ///
  /// The returned [JobProposal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<JobProposal>> insert(
    _i1.DatabaseSession session,
    List<JobProposal> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<JobProposal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [JobProposal] and returns the inserted row.
  ///
  /// The returned [JobProposal] will have its `id` field set.
  Future<JobProposal> insertRow(
    _i1.DatabaseSession session,
    JobProposal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobProposal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JobProposal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JobProposal>> update(
    _i1.DatabaseSession session,
    List<JobProposal> rows, {
    _i1.ColumnSelections<JobProposalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JobProposal>(
      rows,
      columns: columns?.call(JobProposal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobProposal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobProposal> updateRow(
    _i1.DatabaseSession session,
    JobProposal row, {
    _i1.ColumnSelections<JobProposalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobProposal>(
      row,
      columns: columns?.call(JobProposal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobProposal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobProposal?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<JobProposalUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JobProposal>(
      id,
      columnValues: columnValues(JobProposal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobProposal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JobProposal>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<JobProposalUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<JobProposalTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobProposalTable>? orderBy,
    _i1.OrderByListBuilder<JobProposalTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JobProposal>(
      columnValues: columnValues(JobProposal.t.updateTable),
      where: where(JobProposal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobProposal.t),
      orderByList: orderByList?.call(JobProposal.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JobProposal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JobProposal>> delete(
    _i1.DatabaseSession session,
    List<JobProposal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JobProposal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JobProposal].
  Future<JobProposal> deleteRow(
    _i1.DatabaseSession session,
    JobProposal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobProposal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JobProposal>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobProposalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JobProposal>(
      where: where(JobProposal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobProposalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JobProposal>(
      where: where?.call(JobProposal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobProposal] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobProposalTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobProposal>(
      where: where(JobProposal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class JobProposalAttachRepository {
  const JobProposalAttachRepository._();

  /// Creates a relation between this [JobProposal] and the given [JobProposalAnswerToQuestion]s
  /// by setting each [JobProposalAnswerToQuestion]'s foreign key `jobProposalId` to refer to this [JobProposal].
  Future<void> answers(
    _i1.DatabaseSession session,
    JobProposal jobProposal,
    List<_i3.JobProposalAnswerToQuestion> jobProposalAnswerToQuestion, {
    _i1.Transaction? transaction,
  }) async {
    if (jobProposalAnswerToQuestion.any((e) => e.id == null)) {
      throw ArgumentError.notNull('jobProposalAnswerToQuestion.id');
    }
    if (jobProposal.id == null) {
      throw ArgumentError.notNull('jobProposal.id');
    }

    var $jobProposalAnswerToQuestion = jobProposalAnswerToQuestion
        .map((e) => e.copyWith(jobProposalId: jobProposal.id))
        .toList();
    await session.db.update<_i3.JobProposalAnswerToQuestion>(
      $jobProposalAnswerToQuestion,
      columns: [_i3.JobProposalAnswerToQuestion.t.jobProposalId],
      transaction: transaction,
    );
  }
}

class JobProposalAttachRowRepository {
  const JobProposalAttachRowRepository._();

  /// Creates a relation between the given [JobProposal] and [JobAnalysisState]
  /// by setting the [JobProposal]'s foreign key `jobAnalysisStateId` to refer to the [JobAnalysisState].
  Future<void> jobAnalysisState(
    _i1.DatabaseSession session,
    JobProposal jobProposal,
    _i2.JobAnalysisState jobAnalysisState, {
    _i1.Transaction? transaction,
  }) async {
    if (jobProposal.id == null) {
      throw ArgumentError.notNull('jobProposal.id');
    }
    if (jobAnalysisState.id == null) {
      throw ArgumentError.notNull('jobAnalysisState.id');
    }

    var $jobProposal = jobProposal.copyWith(
      jobAnalysisStateId: jobAnalysisState.id,
    );
    await session.db.updateRow<JobProposal>(
      $jobProposal,
      columns: [JobProposal.t.jobAnalysisStateId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [JobProposal] and the given [JobProposalAnswerToQuestion]
  /// by setting the [JobProposalAnswerToQuestion]'s foreign key `jobProposalId` to refer to this [JobProposal].
  Future<void> answers(
    _i1.DatabaseSession session,
    JobProposal jobProposal,
    _i3.JobProposalAnswerToQuestion jobProposalAnswerToQuestion, {
    _i1.Transaction? transaction,
  }) async {
    if (jobProposalAnswerToQuestion.id == null) {
      throw ArgumentError.notNull('jobProposalAnswerToQuestion.id');
    }
    if (jobProposal.id == null) {
      throw ArgumentError.notNull('jobProposal.id');
    }

    var $jobProposalAnswerToQuestion = jobProposalAnswerToQuestion.copyWith(
      jobProposalId: jobProposal.id,
    );
    await session.db.updateRow<_i3.JobProposalAnswerToQuestion>(
      $jobProposalAnswerToQuestion,
      columns: [_i3.JobProposalAnswerToQuestion.t.jobProposalId],
      transaction: transaction,
    );
  }
}

class JobProposalDetachRepository {
  const JobProposalDetachRepository._();

  /// Detaches the relation between this [JobProposal] and the given [JobProposalAnswerToQuestion]
  /// by setting the [JobProposalAnswerToQuestion]'s foreign key `jobProposalId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> answers(
    _i1.DatabaseSession session,
    List<_i3.JobProposalAnswerToQuestion> jobProposalAnswerToQuestion, {
    _i1.Transaction? transaction,
  }) async {
    if (jobProposalAnswerToQuestion.any((e) => e.id == null)) {
      throw ArgumentError.notNull('jobProposalAnswerToQuestion.id');
    }

    var $jobProposalAnswerToQuestion = jobProposalAnswerToQuestion
        .map((e) => e.copyWith(jobProposalId: null))
        .toList();
    await session.db.update<_i3.JobProposalAnswerToQuestion>(
      $jobProposalAnswerToQuestion,
      columns: [_i3.JobProposalAnswerToQuestion.t.jobProposalId],
      transaction: transaction,
    );
  }
}

class JobProposalDetachRowRepository {
  const JobProposalDetachRowRepository._();

  /// Detaches the relation between this [JobProposal] and the given [JobProposalAnswerToQuestion]
  /// by setting the [JobProposalAnswerToQuestion]'s foreign key `jobProposalId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> answers(
    _i1.DatabaseSession session,
    _i3.JobProposalAnswerToQuestion jobProposalAnswerToQuestion, {
    _i1.Transaction? transaction,
  }) async {
    if (jobProposalAnswerToQuestion.id == null) {
      throw ArgumentError.notNull('jobProposalAnswerToQuestion.id');
    }

    var $jobProposalAnswerToQuestion = jobProposalAnswerToQuestion.copyWith(
      jobProposalId: null,
    );
    await session.db.updateRow<_i3.JobProposalAnswerToQuestion>(
      $jobProposalAnswerToQuestion,
      columns: [_i3.JobProposalAnswerToQuestion.t.jobProposalId],
      transaction: transaction,
    );
  }
}
