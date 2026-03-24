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
import '../../entities/upwork_scrap/job_info.dart' as _i2;
import '../../entities/job_proposal_answer_to_question.dart' as _i3;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i4;

abstract class Question
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Question._({
    this.id,
    required this.question,
    required this.positionIndex,
    this.jobInfoId,
    this.jobInfo,
    this.proposalAnswer,
  });

  factory Question({
    int? id,
    required String question,
    required int positionIndex,
    int? jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobProposalAnswerToQuestion? proposalAnswer,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      question: jsonSerialization['question'] as String,
      positionIndex: jsonSerialization['positionIndex'] as int,
      jobInfoId: jsonSerialization['jobInfoId'] as int?,
      jobInfo: jsonSerialization['jobInfo'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.JobInfo>(
              jsonSerialization['jobInfo'],
            ),
      proposalAnswer: jsonSerialization['proposalAnswer'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.JobProposalAnswerToQuestion>(
              jsonSerialization['proposalAnswer'],
            ),
    );
  }

  static final t = QuestionTable();

  static const db = QuestionRepository._();

  @override
  int? id;

  String question;

  int positionIndex;

  int? jobInfoId;

  _i2.JobInfo? jobInfo;

  _i3.JobProposalAnswerToQuestion? proposalAnswer;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Question copyWith({
    int? id,
    String? question,
    int? positionIndex,
    int? jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobProposalAnswerToQuestion? proposalAnswer,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'question': question,
      'positionIndex': positionIndex,
      if (jobInfoId != null) 'jobInfoId': jobInfoId,
      if (jobInfo != null) 'jobInfo': jobInfo?.toJson(),
      if (proposalAnswer != null) 'proposalAnswer': proposalAnswer?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'question': question,
      'positionIndex': positionIndex,
      if (jobInfoId != null) 'jobInfoId': jobInfoId,
      if (jobInfo != null) 'jobInfo': jobInfo?.toJsonForProtocol(),
      if (proposalAnswer != null)
        'proposalAnswer': proposalAnswer?.toJsonForProtocol(),
    };
  }

  static QuestionInclude include({
    _i2.JobInfoInclude? jobInfo,
    _i3.JobProposalAnswerToQuestionInclude? proposalAnswer,
  }) {
    return QuestionInclude._(
      jobInfo: jobInfo,
      proposalAnswer: proposalAnswer,
    );
  }

  static QuestionIncludeList includeList({
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    QuestionInclude? include,
  }) {
    return QuestionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Question.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required String question,
    required int positionIndex,
    int? jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobProposalAnswerToQuestion? proposalAnswer,
  }) : super._(
         id: id,
         question: question,
         positionIndex: positionIndex,
         jobInfoId: jobInfoId,
         jobInfo: jobInfo,
         proposalAnswer: proposalAnswer,
       );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    String? question,
    int? positionIndex,
    Object? jobInfoId = _Undefined,
    Object? jobInfo = _Undefined,
    Object? proposalAnswer = _Undefined,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      question: question ?? this.question,
      positionIndex: positionIndex ?? this.positionIndex,
      jobInfoId: jobInfoId is int? ? jobInfoId : this.jobInfoId,
      jobInfo: jobInfo is _i2.JobInfo? ? jobInfo : this.jobInfo?.copyWith(),
      proposalAnswer: proposalAnswer is _i3.JobProposalAnswerToQuestion?
          ? proposalAnswer
          : this.proposalAnswer?.copyWith(),
    );
  }
}

class QuestionUpdateTable extends _i1.UpdateTable<QuestionTable> {
  QuestionUpdateTable(super.table);

  _i1.ColumnValue<String, String> question(String value) => _i1.ColumnValue(
    table.question,
    value,
  );

  _i1.ColumnValue<int, int> positionIndex(int value) => _i1.ColumnValue(
    table.positionIndex,
    value,
  );

  _i1.ColumnValue<int, int> jobInfoId(int? value) => _i1.ColumnValue(
    table.jobInfoId,
    value,
  );
}

class QuestionTable extends _i1.Table<int?> {
  QuestionTable({super.tableRelation}) : super(tableName: 'question') {
    updateTable = QuestionUpdateTable(this);
    question = _i1.ColumnString(
      'question',
      this,
    );
    positionIndex = _i1.ColumnInt(
      'positionIndex',
      this,
    );
    jobInfoId = _i1.ColumnInt(
      'jobInfoId',
      this,
    );
  }

  late final QuestionUpdateTable updateTable;

  late final _i1.ColumnString question;

  late final _i1.ColumnInt positionIndex;

  late final _i1.ColumnInt jobInfoId;

  _i2.JobInfoTable? _jobInfo;

  _i3.JobProposalAnswerToQuestionTable? _proposalAnswer;

  _i2.JobInfoTable get jobInfo {
    if (_jobInfo != null) return _jobInfo!;
    _jobInfo = _i1.createRelationTable(
      relationFieldName: 'jobInfo',
      field: Question.t.jobInfoId,
      foreignField: _i2.JobInfo.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.JobInfoTable(tableRelation: foreignTableRelation),
    );
    return _jobInfo!;
  }

  _i3.JobProposalAnswerToQuestionTable get proposalAnswer {
    if (_proposalAnswer != null) return _proposalAnswer!;
    _proposalAnswer = _i1.createRelationTable(
      relationFieldName: 'proposalAnswer',
      field: Question.t.id,
      foreignField: _i3.JobProposalAnswerToQuestion.t.relatedQuestionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.JobProposalAnswerToQuestionTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return _proposalAnswer!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    question,
    positionIndex,
    jobInfoId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'jobInfo') {
      return jobInfo;
    }
    if (relationField == 'proposalAnswer') {
      return proposalAnswer;
    }
    return null;
  }
}

class QuestionInclude extends _i1.IncludeObject {
  QuestionInclude._({
    _i2.JobInfoInclude? jobInfo,
    _i3.JobProposalAnswerToQuestionInclude? proposalAnswer,
  }) {
    _jobInfo = jobInfo;
    _proposalAnswer = proposalAnswer;
  }

  _i2.JobInfoInclude? _jobInfo;

  _i3.JobProposalAnswerToQuestionInclude? _proposalAnswer;

  @override
  Map<String, _i1.Include?> get includes => {
    'jobInfo': _jobInfo,
    'proposalAnswer': _proposalAnswer,
  };

  @override
  _i1.Table<int?> get table => Question.t;
}

class QuestionIncludeList extends _i1.IncludeList {
  QuestionIncludeList._({
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Question.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Question.t;
}

class QuestionRepository {
  const QuestionRepository._();

  final attachRow = const QuestionAttachRowRepository._();

  final detachRow = const QuestionDetachRowRepository._();

  /// Returns a list of [Question]s matching the given query parameters.
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
  Future<List<Question>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    _i1.Transaction? transaction,
    QuestionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Question] matching the given query parameters.
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
  Future<Question?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    _i1.Transaction? transaction,
    QuestionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Question] by its [id] or null if no such row exists.
  Future<Question?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    QuestionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Question>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Question]s in the list and returns the inserted rows.
  ///
  /// The returned [Question]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Question>> insert(
    _i1.DatabaseSession session,
    List<Question> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Question>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Question] and returns the inserted row.
  ///
  /// The returned [Question] will have its `id` field set.
  Future<Question> insertRow(
    _i1.DatabaseSession session,
    Question row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Question]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Question>> update(
    _i1.DatabaseSession session,
    List<Question> rows, {
    _i1.ColumnSelections<QuestionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Question>(
      rows,
      columns: columns?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Question]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Question> updateRow(
    _i1.DatabaseSession session,
    Question row, {
    _i1.ColumnSelections<QuestionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Question>(
      row,
      columns: columns?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Question] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Question?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Question>(
      id,
      columnValues: columnValues(Question.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Question]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Question>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<QuestionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Question>(
      columnValues: columnValues(Question.t.updateTable),
      where: where(Question.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Question]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Question>> delete(
    _i1.DatabaseSession session,
    List<Question> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Question>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Question].
  Future<Question> deleteRow(
    _i1.DatabaseSession session,
    Question row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Question>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<QuestionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Question>(
      where: where(Question.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Question>(
      where: where?.call(Question.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Question] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<QuestionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Question>(
      where: where(Question.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class QuestionAttachRowRepository {
  const QuestionAttachRowRepository._();

  /// Creates a relation between the given [Question] and [JobInfo]
  /// by setting the [Question]'s foreign key `jobInfoId` to refer to the [JobInfo].
  Future<void> jobInfo(
    _i1.DatabaseSession session,
    Question question,
    _i2.JobInfo jobInfo, {
    _i1.Transaction? transaction,
  }) async {
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }
    if (jobInfo.id == null) {
      throw ArgumentError.notNull('jobInfo.id');
    }

    var $question = question.copyWith(jobInfoId: jobInfo.id);
    await session.db.updateRow<Question>(
      $question,
      columns: [Question.t.jobInfoId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Question] and [JobProposalAnswerToQuestion]
  /// by setting the [Question]'s foreign key `id` to refer to the [JobProposalAnswerToQuestion].
  Future<void> proposalAnswer(
    _i1.DatabaseSession session,
    Question question,
    _i3.JobProposalAnswerToQuestion proposalAnswer, {
    _i1.Transaction? transaction,
  }) async {
    if (proposalAnswer.id == null) {
      throw ArgumentError.notNull('proposalAnswer.id');
    }
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }

    var $proposalAnswer = proposalAnswer.copyWith(
      relatedQuestionId: question.id,
    );
    await session.db.updateRow<_i3.JobProposalAnswerToQuestion>(
      $proposalAnswer,
      columns: [_i3.JobProposalAnswerToQuestion.t.relatedQuestionId],
      transaction: transaction,
    );
  }
}

class QuestionDetachRowRepository {
  const QuestionDetachRowRepository._();

  /// Detaches the relation between this [Question] and the [JobInfo] set in `jobInfo`
  /// by setting the [Question]'s foreign key `jobInfoId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> jobInfo(
    _i1.DatabaseSession session,
    Question question, {
    _i1.Transaction? transaction,
  }) async {
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }

    var $question = question.copyWith(jobInfoId: null);
    await session.db.updateRow<Question>(
      $question,
      columns: [Question.t.jobInfoId],
      transaction: transaction,
    );
  }
}
