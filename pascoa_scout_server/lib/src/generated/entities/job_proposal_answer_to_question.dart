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
import '../entities/job_proposal.dart' as _i2;
import '../entities/upwork_scrap/question.dart' as _i3;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i4;

abstract class JobProposalAnswerToQuestion
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  JobProposalAnswerToQuestion._({
    this.id,
    required this.jobProposalId,
    this.jobProposal,
    required this.relatedQuestionId,
    this.relatedQuestion,
    required this.aiGeneratedAnswerText,
  });

  factory JobProposalAnswerToQuestion({
    int? id,
    required int jobProposalId,
    _i2.JobProposal? jobProposal,
    required int relatedQuestionId,
    _i3.Question? relatedQuestion,
    required String aiGeneratedAnswerText,
  }) = _JobProposalAnswerToQuestionImpl;

  factory JobProposalAnswerToQuestion.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobProposalAnswerToQuestion(
      id: jsonSerialization['id'] as int?,
      jobProposalId: jsonSerialization['jobProposalId'] as int,
      jobProposal: jsonSerialization['jobProposal'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.JobProposal>(
              jsonSerialization['jobProposal'],
            ),
      relatedQuestionId: jsonSerialization['relatedQuestionId'] as int,
      relatedQuestion: jsonSerialization['relatedQuestion'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Question>(
              jsonSerialization['relatedQuestion'],
            ),
      aiGeneratedAnswerText:
          jsonSerialization['aiGeneratedAnswerText'] as String,
    );
  }

  static final t = JobProposalAnswerToQuestionTable();

  static const db = JobProposalAnswerToQuestionRepository._();

  @override
  int? id;

  int jobProposalId;

  _i2.JobProposal? jobProposal;

  int relatedQuestionId;

  _i3.Question? relatedQuestion;

  String aiGeneratedAnswerText;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobProposalAnswerToQuestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobProposalAnswerToQuestion copyWith({
    int? id,
    int? jobProposalId,
    _i2.JobProposal? jobProposal,
    int? relatedQuestionId,
    _i3.Question? relatedQuestion,
    String? aiGeneratedAnswerText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobProposalAnswerToQuestion',
      if (id != null) 'id': id,
      'jobProposalId': jobProposalId,
      if (jobProposal != null) 'jobProposal': jobProposal?.toJson(),
      'relatedQuestionId': relatedQuestionId,
      if (relatedQuestion != null) 'relatedQuestion': relatedQuestion?.toJson(),
      'aiGeneratedAnswerText': aiGeneratedAnswerText,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobProposalAnswerToQuestion',
      if (id != null) 'id': id,
      'jobProposalId': jobProposalId,
      if (jobProposal != null) 'jobProposal': jobProposal?.toJsonForProtocol(),
      'relatedQuestionId': relatedQuestionId,
      if (relatedQuestion != null)
        'relatedQuestion': relatedQuestion?.toJsonForProtocol(),
      'aiGeneratedAnswerText': aiGeneratedAnswerText,
    };
  }

  static JobProposalAnswerToQuestionInclude include({
    _i2.JobProposalInclude? jobProposal,
    _i3.QuestionInclude? relatedQuestion,
  }) {
    return JobProposalAnswerToQuestionInclude._(
      jobProposal: jobProposal,
      relatedQuestion: relatedQuestion,
    );
  }

  static JobProposalAnswerToQuestionIncludeList includeList({
    _i1.WhereExpressionBuilder<JobProposalAnswerToQuestionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobProposalAnswerToQuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobProposalAnswerToQuestionTable>? orderByList,
    JobProposalAnswerToQuestionInclude? include,
  }) {
    return JobProposalAnswerToQuestionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobProposalAnswerToQuestion.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JobProposalAnswerToQuestion.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobProposalAnswerToQuestionImpl extends JobProposalAnswerToQuestion {
  _JobProposalAnswerToQuestionImpl({
    int? id,
    required int jobProposalId,
    _i2.JobProposal? jobProposal,
    required int relatedQuestionId,
    _i3.Question? relatedQuestion,
    required String aiGeneratedAnswerText,
  }) : super._(
         id: id,
         jobProposalId: jobProposalId,
         jobProposal: jobProposal,
         relatedQuestionId: relatedQuestionId,
         relatedQuestion: relatedQuestion,
         aiGeneratedAnswerText: aiGeneratedAnswerText,
       );

  /// Returns a shallow copy of this [JobProposalAnswerToQuestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobProposalAnswerToQuestion copyWith({
    Object? id = _Undefined,
    int? jobProposalId,
    Object? jobProposal = _Undefined,
    int? relatedQuestionId,
    Object? relatedQuestion = _Undefined,
    String? aiGeneratedAnswerText,
  }) {
    return JobProposalAnswerToQuestion(
      id: id is int? ? id : this.id,
      jobProposalId: jobProposalId ?? this.jobProposalId,
      jobProposal: jobProposal is _i2.JobProposal?
          ? jobProposal
          : this.jobProposal?.copyWith(),
      relatedQuestionId: relatedQuestionId ?? this.relatedQuestionId,
      relatedQuestion: relatedQuestion is _i3.Question?
          ? relatedQuestion
          : this.relatedQuestion?.copyWith(),
      aiGeneratedAnswerText:
          aiGeneratedAnswerText ?? this.aiGeneratedAnswerText,
    );
  }
}

class JobProposalAnswerToQuestionUpdateTable
    extends _i1.UpdateTable<JobProposalAnswerToQuestionTable> {
  JobProposalAnswerToQuestionUpdateTable(super.table);

  _i1.ColumnValue<int, int> jobProposalId(int value) => _i1.ColumnValue(
    table.jobProposalId,
    value,
  );

  _i1.ColumnValue<int, int> relatedQuestionId(int value) => _i1.ColumnValue(
    table.relatedQuestionId,
    value,
  );

  _i1.ColumnValue<String, String> aiGeneratedAnswerText(String value) =>
      _i1.ColumnValue(
        table.aiGeneratedAnswerText,
        value,
      );
}

class JobProposalAnswerToQuestionTable extends _i1.Table<int?> {
  JobProposalAnswerToQuestionTable({super.tableRelation})
    : super(tableName: 'job_proposal_answer_to_question') {
    updateTable = JobProposalAnswerToQuestionUpdateTable(this);
    jobProposalId = _i1.ColumnInt(
      'jobProposalId',
      this,
    );
    relatedQuestionId = _i1.ColumnInt(
      'relatedQuestionId',
      this,
    );
    aiGeneratedAnswerText = _i1.ColumnString(
      'aiGeneratedAnswerText',
      this,
    );
  }

  late final JobProposalAnswerToQuestionUpdateTable updateTable;

  late final _i1.ColumnInt jobProposalId;

  _i2.JobProposalTable? _jobProposal;

  late final _i1.ColumnInt relatedQuestionId;

  _i3.QuestionTable? _relatedQuestion;

  late final _i1.ColumnString aiGeneratedAnswerText;

  _i2.JobProposalTable get jobProposal {
    if (_jobProposal != null) return _jobProposal!;
    _jobProposal = _i1.createRelationTable(
      relationFieldName: 'jobProposal',
      field: JobProposalAnswerToQuestion.t.jobProposalId,
      foreignField: _i2.JobProposal.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.JobProposalTable(tableRelation: foreignTableRelation),
    );
    return _jobProposal!;
  }

  _i3.QuestionTable get relatedQuestion {
    if (_relatedQuestion != null) return _relatedQuestion!;
    _relatedQuestion = _i1.createRelationTable(
      relationFieldName: 'relatedQuestion',
      field: JobProposalAnswerToQuestion.t.relatedQuestionId,
      foreignField: _i3.Question.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.QuestionTable(tableRelation: foreignTableRelation),
    );
    return _relatedQuestion!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    jobProposalId,
    relatedQuestionId,
    aiGeneratedAnswerText,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'jobProposal') {
      return jobProposal;
    }
    if (relationField == 'relatedQuestion') {
      return relatedQuestion;
    }
    return null;
  }
}

class JobProposalAnswerToQuestionInclude extends _i1.IncludeObject {
  JobProposalAnswerToQuestionInclude._({
    _i2.JobProposalInclude? jobProposal,
    _i3.QuestionInclude? relatedQuestion,
  }) {
    _jobProposal = jobProposal;
    _relatedQuestion = relatedQuestion;
  }

  _i2.JobProposalInclude? _jobProposal;

  _i3.QuestionInclude? _relatedQuestion;

  @override
  Map<String, _i1.Include?> get includes => {
    'jobProposal': _jobProposal,
    'relatedQuestion': _relatedQuestion,
  };

  @override
  _i1.Table<int?> get table => JobProposalAnswerToQuestion.t;
}

class JobProposalAnswerToQuestionIncludeList extends _i1.IncludeList {
  JobProposalAnswerToQuestionIncludeList._({
    _i1.WhereExpressionBuilder<JobProposalAnswerToQuestionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobProposalAnswerToQuestion.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JobProposalAnswerToQuestion.t;
}

class JobProposalAnswerToQuestionRepository {
  const JobProposalAnswerToQuestionRepository._();

  final attachRow = const JobProposalAnswerToQuestionAttachRowRepository._();

  /// Returns a list of [JobProposalAnswerToQuestion]s matching the given query parameters.
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
  Future<List<JobProposalAnswerToQuestion>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobProposalAnswerToQuestionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobProposalAnswerToQuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobProposalAnswerToQuestionTable>? orderByList,
    _i1.Transaction? transaction,
    JobProposalAnswerToQuestionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobProposalAnswerToQuestion>(
      where: where?.call(JobProposalAnswerToQuestion.t),
      orderBy: orderBy?.call(JobProposalAnswerToQuestion.t),
      orderByList: orderByList?.call(JobProposalAnswerToQuestion.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobProposalAnswerToQuestion] matching the given query parameters.
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
  Future<JobProposalAnswerToQuestion?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobProposalAnswerToQuestionTable>? where,
    int? offset,
    _i1.OrderByBuilder<JobProposalAnswerToQuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobProposalAnswerToQuestionTable>? orderByList,
    _i1.Transaction? transaction,
    JobProposalAnswerToQuestionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobProposalAnswerToQuestion>(
      where: where?.call(JobProposalAnswerToQuestion.t),
      orderBy: orderBy?.call(JobProposalAnswerToQuestion.t),
      orderByList: orderByList?.call(JobProposalAnswerToQuestion.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobProposalAnswerToQuestion] by its [id] or null if no such row exists.
  Future<JobProposalAnswerToQuestion?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    JobProposalAnswerToQuestionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobProposalAnswerToQuestion>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobProposalAnswerToQuestion]s in the list and returns the inserted rows.
  ///
  /// The returned [JobProposalAnswerToQuestion]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<JobProposalAnswerToQuestion>> insert(
    _i1.DatabaseSession session,
    List<JobProposalAnswerToQuestion> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<JobProposalAnswerToQuestion>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [JobProposalAnswerToQuestion] and returns the inserted row.
  ///
  /// The returned [JobProposalAnswerToQuestion] will have its `id` field set.
  Future<JobProposalAnswerToQuestion> insertRow(
    _i1.DatabaseSession session,
    JobProposalAnswerToQuestion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobProposalAnswerToQuestion>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JobProposalAnswerToQuestion]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JobProposalAnswerToQuestion>> update(
    _i1.DatabaseSession session,
    List<JobProposalAnswerToQuestion> rows, {
    _i1.ColumnSelections<JobProposalAnswerToQuestionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JobProposalAnswerToQuestion>(
      rows,
      columns: columns?.call(JobProposalAnswerToQuestion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobProposalAnswerToQuestion]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobProposalAnswerToQuestion> updateRow(
    _i1.DatabaseSession session,
    JobProposalAnswerToQuestion row, {
    _i1.ColumnSelections<JobProposalAnswerToQuestionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobProposalAnswerToQuestion>(
      row,
      columns: columns?.call(JobProposalAnswerToQuestion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobProposalAnswerToQuestion] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobProposalAnswerToQuestion?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<JobProposalAnswerToQuestionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JobProposalAnswerToQuestion>(
      id,
      columnValues: columnValues(JobProposalAnswerToQuestion.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobProposalAnswerToQuestion]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JobProposalAnswerToQuestion>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<JobProposalAnswerToQuestionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<JobProposalAnswerToQuestionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobProposalAnswerToQuestionTable>? orderBy,
    _i1.OrderByListBuilder<JobProposalAnswerToQuestionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JobProposalAnswerToQuestion>(
      columnValues: columnValues(JobProposalAnswerToQuestion.t.updateTable),
      where: where(JobProposalAnswerToQuestion.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobProposalAnswerToQuestion.t),
      orderByList: orderByList?.call(JobProposalAnswerToQuestion.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JobProposalAnswerToQuestion]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JobProposalAnswerToQuestion>> delete(
    _i1.DatabaseSession session,
    List<JobProposalAnswerToQuestion> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JobProposalAnswerToQuestion>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JobProposalAnswerToQuestion].
  Future<JobProposalAnswerToQuestion> deleteRow(
    _i1.DatabaseSession session,
    JobProposalAnswerToQuestion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobProposalAnswerToQuestion>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JobProposalAnswerToQuestion>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobProposalAnswerToQuestionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JobProposalAnswerToQuestion>(
      where: where(JobProposalAnswerToQuestion.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobProposalAnswerToQuestionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JobProposalAnswerToQuestion>(
      where: where?.call(JobProposalAnswerToQuestion.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobProposalAnswerToQuestion] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobProposalAnswerToQuestionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobProposalAnswerToQuestion>(
      where: where(JobProposalAnswerToQuestion.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class JobProposalAnswerToQuestionAttachRowRepository {
  const JobProposalAnswerToQuestionAttachRowRepository._();

  /// Creates a relation between the given [JobProposalAnswerToQuestion] and [JobProposal]
  /// by setting the [JobProposalAnswerToQuestion]'s foreign key `jobProposalId` to refer to the [JobProposal].
  Future<void> jobProposal(
    _i1.DatabaseSession session,
    JobProposalAnswerToQuestion jobProposalAnswerToQuestion,
    _i2.JobProposal jobProposal, {
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
    await session.db.updateRow<JobProposalAnswerToQuestion>(
      $jobProposalAnswerToQuestion,
      columns: [JobProposalAnswerToQuestion.t.jobProposalId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [JobProposalAnswerToQuestion] and [Question]
  /// by setting the [JobProposalAnswerToQuestion]'s foreign key `relatedQuestionId` to refer to the [Question].
  Future<void> relatedQuestion(
    _i1.DatabaseSession session,
    JobProposalAnswerToQuestion jobProposalAnswerToQuestion,
    _i3.Question relatedQuestion, {
    _i1.Transaction? transaction,
  }) async {
    if (jobProposalAnswerToQuestion.id == null) {
      throw ArgumentError.notNull('jobProposalAnswerToQuestion.id');
    }
    if (relatedQuestion.id == null) {
      throw ArgumentError.notNull('relatedQuestion.id');
    }

    var $jobProposalAnswerToQuestion = jobProposalAnswerToQuestion.copyWith(
      relatedQuestionId: relatedQuestion.id,
    );
    await session.db.updateRow<JobProposalAnswerToQuestion>(
      $jobProposalAnswerToQuestion,
      columns: [JobProposalAnswerToQuestion.t.relatedQuestionId],
      transaction: transaction,
    );
  }
}
