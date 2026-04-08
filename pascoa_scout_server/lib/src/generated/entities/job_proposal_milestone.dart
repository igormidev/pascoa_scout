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
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i3;

abstract class JobProposalMilestone
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  JobProposalMilestone._({
    this.id,
    required this.jobProposalId,
    this.jobProposal,
    required this.positionIndex,
    required this.title,
    required this.description,
    required this.suggestedPrice,
  });

  factory JobProposalMilestone({
    int? id,
    required int jobProposalId,
    _i2.JobProposal? jobProposal,
    required int positionIndex,
    required String title,
    required String description,
    required double suggestedPrice,
  }) = _JobProposalMilestoneImpl;

  factory JobProposalMilestone.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobProposalMilestone(
      id: jsonSerialization['id'] as int?,
      jobProposalId: jsonSerialization['jobProposalId'] as int,
      jobProposal: jsonSerialization['jobProposal'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.JobProposal>(
              jsonSerialization['jobProposal'],
            ),
      positionIndex: jsonSerialization['positionIndex'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      suggestedPrice: (jsonSerialization['suggestedPrice'] as num).toDouble(),
    );
  }

  static final t = JobProposalMilestoneTable();

  static const db = JobProposalMilestoneRepository._();

  @override
  int? id;

  int jobProposalId;

  _i2.JobProposal? jobProposal;

  int positionIndex;

  String title;

  String description;

  double suggestedPrice;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobProposalMilestone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobProposalMilestone copyWith({
    int? id,
    int? jobProposalId,
    _i2.JobProposal? jobProposal,
    int? positionIndex,
    String? title,
    String? description,
    double? suggestedPrice,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobProposalMilestone',
      if (id != null) 'id': id,
      'jobProposalId': jobProposalId,
      if (jobProposal != null) 'jobProposal': jobProposal?.toJson(),
      'positionIndex': positionIndex,
      'title': title,
      'description': description,
      'suggestedPrice': suggestedPrice,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobProposalMilestone',
      if (id != null) 'id': id,
      'jobProposalId': jobProposalId,
      if (jobProposal != null) 'jobProposal': jobProposal?.toJsonForProtocol(),
      'positionIndex': positionIndex,
      'title': title,
      'description': description,
      'suggestedPrice': suggestedPrice,
    };
  }

  static JobProposalMilestoneInclude include({
    _i2.JobProposalInclude? jobProposal,
  }) {
    return JobProposalMilestoneInclude._(jobProposal: jobProposal);
  }

  static JobProposalMilestoneIncludeList includeList({
    _i1.WhereExpressionBuilder<JobProposalMilestoneTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobProposalMilestoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobProposalMilestoneTable>? orderByList,
    JobProposalMilestoneInclude? include,
  }) {
    return JobProposalMilestoneIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobProposalMilestone.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JobProposalMilestone.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobProposalMilestoneImpl extends JobProposalMilestone {
  _JobProposalMilestoneImpl({
    int? id,
    required int jobProposalId,
    _i2.JobProposal? jobProposal,
    required int positionIndex,
    required String title,
    required String description,
    required double suggestedPrice,
  }) : super._(
         id: id,
         jobProposalId: jobProposalId,
         jobProposal: jobProposal,
         positionIndex: positionIndex,
         title: title,
         description: description,
         suggestedPrice: suggestedPrice,
       );

  /// Returns a shallow copy of this [JobProposalMilestone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobProposalMilestone copyWith({
    Object? id = _Undefined,
    int? jobProposalId,
    Object? jobProposal = _Undefined,
    int? positionIndex,
    String? title,
    String? description,
    double? suggestedPrice,
  }) {
    return JobProposalMilestone(
      id: id is int? ? id : this.id,
      jobProposalId: jobProposalId ?? this.jobProposalId,
      jobProposal: jobProposal is _i2.JobProposal?
          ? jobProposal
          : this.jobProposal?.copyWith(),
      positionIndex: positionIndex ?? this.positionIndex,
      title: title ?? this.title,
      description: description ?? this.description,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
    );
  }
}

class JobProposalMilestoneUpdateTable
    extends _i1.UpdateTable<JobProposalMilestoneTable> {
  JobProposalMilestoneUpdateTable(super.table);

  _i1.ColumnValue<int, int> jobProposalId(int value) => _i1.ColumnValue(
    table.jobProposalId,
    value,
  );

  _i1.ColumnValue<int, int> positionIndex(int value) => _i1.ColumnValue(
    table.positionIndex,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<double, double> suggestedPrice(double value) =>
      _i1.ColumnValue(
        table.suggestedPrice,
        value,
      );
}

class JobProposalMilestoneTable extends _i1.Table<int?> {
  JobProposalMilestoneTable({super.tableRelation})
    : super(tableName: 'job_proposal_milestone') {
    updateTable = JobProposalMilestoneUpdateTable(this);
    jobProposalId = _i1.ColumnInt(
      'jobProposalId',
      this,
    );
    positionIndex = _i1.ColumnInt(
      'positionIndex',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    suggestedPrice = _i1.ColumnDouble(
      'suggestedPrice',
      this,
    );
  }

  late final JobProposalMilestoneUpdateTable updateTable;

  late final _i1.ColumnInt jobProposalId;

  _i2.JobProposalTable? _jobProposal;

  late final _i1.ColumnInt positionIndex;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnDouble suggestedPrice;

  _i2.JobProposalTable get jobProposal {
    if (_jobProposal != null) return _jobProposal!;
    _jobProposal = _i1.createRelationTable(
      relationFieldName: 'jobProposal',
      field: JobProposalMilestone.t.jobProposalId,
      foreignField: _i2.JobProposal.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.JobProposalTable(tableRelation: foreignTableRelation),
    );
    return _jobProposal!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    jobProposalId,
    positionIndex,
    title,
    description,
    suggestedPrice,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'jobProposal') {
      return jobProposal;
    }
    return null;
  }
}

class JobProposalMilestoneInclude extends _i1.IncludeObject {
  JobProposalMilestoneInclude._({_i2.JobProposalInclude? jobProposal}) {
    _jobProposal = jobProposal;
  }

  _i2.JobProposalInclude? _jobProposal;

  @override
  Map<String, _i1.Include?> get includes => {'jobProposal': _jobProposal};

  @override
  _i1.Table<int?> get table => JobProposalMilestone.t;
}

class JobProposalMilestoneIncludeList extends _i1.IncludeList {
  JobProposalMilestoneIncludeList._({
    _i1.WhereExpressionBuilder<JobProposalMilestoneTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobProposalMilestone.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JobProposalMilestone.t;
}

class JobProposalMilestoneRepository {
  const JobProposalMilestoneRepository._();

  final attachRow = const JobProposalMilestoneAttachRowRepository._();

  /// Returns a list of [JobProposalMilestone]s matching the given query parameters.
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
  Future<List<JobProposalMilestone>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobProposalMilestoneTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobProposalMilestoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobProposalMilestoneTable>? orderByList,
    _i1.Transaction? transaction,
    JobProposalMilestoneInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobProposalMilestone>(
      where: where?.call(JobProposalMilestone.t),
      orderBy: orderBy?.call(JobProposalMilestone.t),
      orderByList: orderByList?.call(JobProposalMilestone.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobProposalMilestone] matching the given query parameters.
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
  Future<JobProposalMilestone?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobProposalMilestoneTable>? where,
    int? offset,
    _i1.OrderByBuilder<JobProposalMilestoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobProposalMilestoneTable>? orderByList,
    _i1.Transaction? transaction,
    JobProposalMilestoneInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobProposalMilestone>(
      where: where?.call(JobProposalMilestone.t),
      orderBy: orderBy?.call(JobProposalMilestone.t),
      orderByList: orderByList?.call(JobProposalMilestone.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobProposalMilestone] by its [id] or null if no such row exists.
  Future<JobProposalMilestone?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    JobProposalMilestoneInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobProposalMilestone>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobProposalMilestone]s in the list and returns the inserted rows.
  ///
  /// The returned [JobProposalMilestone]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<JobProposalMilestone>> insert(
    _i1.DatabaseSession session,
    List<JobProposalMilestone> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<JobProposalMilestone>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [JobProposalMilestone] and returns the inserted row.
  ///
  /// The returned [JobProposalMilestone] will have its `id` field set.
  Future<JobProposalMilestone> insertRow(
    _i1.DatabaseSession session,
    JobProposalMilestone row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobProposalMilestone>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JobProposalMilestone]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JobProposalMilestone>> update(
    _i1.DatabaseSession session,
    List<JobProposalMilestone> rows, {
    _i1.ColumnSelections<JobProposalMilestoneTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JobProposalMilestone>(
      rows,
      columns: columns?.call(JobProposalMilestone.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobProposalMilestone]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobProposalMilestone> updateRow(
    _i1.DatabaseSession session,
    JobProposalMilestone row, {
    _i1.ColumnSelections<JobProposalMilestoneTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobProposalMilestone>(
      row,
      columns: columns?.call(JobProposalMilestone.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobProposalMilestone] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobProposalMilestone?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<JobProposalMilestoneUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JobProposalMilestone>(
      id,
      columnValues: columnValues(JobProposalMilestone.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobProposalMilestone]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JobProposalMilestone>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<JobProposalMilestoneUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<JobProposalMilestoneTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobProposalMilestoneTable>? orderBy,
    _i1.OrderByListBuilder<JobProposalMilestoneTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JobProposalMilestone>(
      columnValues: columnValues(JobProposalMilestone.t.updateTable),
      where: where(JobProposalMilestone.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobProposalMilestone.t),
      orderByList: orderByList?.call(JobProposalMilestone.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JobProposalMilestone]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JobProposalMilestone>> delete(
    _i1.DatabaseSession session,
    List<JobProposalMilestone> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JobProposalMilestone>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JobProposalMilestone].
  Future<JobProposalMilestone> deleteRow(
    _i1.DatabaseSession session,
    JobProposalMilestone row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobProposalMilestone>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JobProposalMilestone>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobProposalMilestoneTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JobProposalMilestone>(
      where: where(JobProposalMilestone.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobProposalMilestoneTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JobProposalMilestone>(
      where: where?.call(JobProposalMilestone.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobProposalMilestone] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobProposalMilestoneTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobProposalMilestone>(
      where: where(JobProposalMilestone.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class JobProposalMilestoneAttachRowRepository {
  const JobProposalMilestoneAttachRowRepository._();

  /// Creates a relation between the given [JobProposalMilestone] and [JobProposal]
  /// by setting the [JobProposalMilestone]'s foreign key `jobProposalId` to refer to the [JobProposal].
  Future<void> jobProposal(
    _i1.DatabaseSession session,
    JobProposalMilestone jobProposalMilestone,
    _i2.JobProposal jobProposal, {
    _i1.Transaction? transaction,
  }) async {
    if (jobProposalMilestone.id == null) {
      throw ArgumentError.notNull('jobProposalMilestone.id');
    }
    if (jobProposal.id == null) {
      throw ArgumentError.notNull('jobProposal.id');
    }

    var $jobProposalMilestone = jobProposalMilestone.copyWith(
      jobProposalId: jobProposal.id,
    );
    await session.db.updateRow<JobProposalMilestone>(
      $jobProposalMilestone,
      columns: [JobProposalMilestone.t.jobProposalId],
      transaction: transaction,
    );
  }
}
