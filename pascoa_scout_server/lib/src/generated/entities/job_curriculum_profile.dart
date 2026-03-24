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

abstract class JobCurriculumProfile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  JobCurriculumProfile._({
    this.id,
    required this.singletonKey,
    required this.markdownText,
    required this.updatedAt,
  });

  factory JobCurriculumProfile({
    int? id,
    required String singletonKey,
    required String markdownText,
    required DateTime updatedAt,
  }) = _JobCurriculumProfileImpl;

  factory JobCurriculumProfile.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobCurriculumProfile(
      id: jsonSerialization['id'] as int?,
      singletonKey: jsonSerialization['singletonKey'] as String,
      markdownText: jsonSerialization['markdownText'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = JobCurriculumProfileTable();

  static const db = JobCurriculumProfileRepository._();

  @override
  int? id;

  String singletonKey;

  String markdownText;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobCurriculumProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobCurriculumProfile copyWith({
    int? id,
    String? singletonKey,
    String? markdownText,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobCurriculumProfile',
      if (id != null) 'id': id,
      'singletonKey': singletonKey,
      'markdownText': markdownText,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobCurriculumProfile',
      if (id != null) 'id': id,
      'singletonKey': singletonKey,
      'markdownText': markdownText,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static JobCurriculumProfileInclude include() {
    return JobCurriculumProfileInclude._();
  }

  static JobCurriculumProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<JobCurriculumProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobCurriculumProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobCurriculumProfileTable>? orderByList,
    JobCurriculumProfileInclude? include,
  }) {
    return JobCurriculumProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobCurriculumProfile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JobCurriculumProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobCurriculumProfileImpl extends JobCurriculumProfile {
  _JobCurriculumProfileImpl({
    int? id,
    required String singletonKey,
    required String markdownText,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         singletonKey: singletonKey,
         markdownText: markdownText,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [JobCurriculumProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobCurriculumProfile copyWith({
    Object? id = _Undefined,
    String? singletonKey,
    String? markdownText,
    DateTime? updatedAt,
  }) {
    return JobCurriculumProfile(
      id: id is int? ? id : this.id,
      singletonKey: singletonKey ?? this.singletonKey,
      markdownText: markdownText ?? this.markdownText,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class JobCurriculumProfileUpdateTable
    extends _i1.UpdateTable<JobCurriculumProfileTable> {
  JobCurriculumProfileUpdateTable(super.table);

  _i1.ColumnValue<String, String> singletonKey(String value) => _i1.ColumnValue(
    table.singletonKey,
    value,
  );

  _i1.ColumnValue<String, String> markdownText(String value) => _i1.ColumnValue(
    table.markdownText,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class JobCurriculumProfileTable extends _i1.Table<int?> {
  JobCurriculumProfileTable({super.tableRelation})
    : super(tableName: 'job_curriculum_profile') {
    updateTable = JobCurriculumProfileUpdateTable(this);
    singletonKey = _i1.ColumnString(
      'singletonKey',
      this,
    );
    markdownText = _i1.ColumnString(
      'markdownText',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final JobCurriculumProfileUpdateTable updateTable;

  late final _i1.ColumnString singletonKey;

  late final _i1.ColumnString markdownText;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    singletonKey,
    markdownText,
    updatedAt,
  ];
}

class JobCurriculumProfileInclude extends _i1.IncludeObject {
  JobCurriculumProfileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => JobCurriculumProfile.t;
}

class JobCurriculumProfileIncludeList extends _i1.IncludeList {
  JobCurriculumProfileIncludeList._({
    _i1.WhereExpressionBuilder<JobCurriculumProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobCurriculumProfile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JobCurriculumProfile.t;
}

class JobCurriculumProfileRepository {
  const JobCurriculumProfileRepository._();

  /// Returns a list of [JobCurriculumProfile]s matching the given query parameters.
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
  Future<List<JobCurriculumProfile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobCurriculumProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobCurriculumProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobCurriculumProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobCurriculumProfile>(
      where: where?.call(JobCurriculumProfile.t),
      orderBy: orderBy?.call(JobCurriculumProfile.t),
      orderByList: orderByList?.call(JobCurriculumProfile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobCurriculumProfile] matching the given query parameters.
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
  Future<JobCurriculumProfile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobCurriculumProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<JobCurriculumProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobCurriculumProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobCurriculumProfile>(
      where: where?.call(JobCurriculumProfile.t),
      orderBy: orderBy?.call(JobCurriculumProfile.t),
      orderByList: orderByList?.call(JobCurriculumProfile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobCurriculumProfile] by its [id] or null if no such row exists.
  Future<JobCurriculumProfile?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobCurriculumProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobCurriculumProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [JobCurriculumProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<JobCurriculumProfile>> insert(
    _i1.DatabaseSession session,
    List<JobCurriculumProfile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<JobCurriculumProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [JobCurriculumProfile] and returns the inserted row.
  ///
  /// The returned [JobCurriculumProfile] will have its `id` field set.
  Future<JobCurriculumProfile> insertRow(
    _i1.DatabaseSession session,
    JobCurriculumProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobCurriculumProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JobCurriculumProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JobCurriculumProfile>> update(
    _i1.DatabaseSession session,
    List<JobCurriculumProfile> rows, {
    _i1.ColumnSelections<JobCurriculumProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JobCurriculumProfile>(
      rows,
      columns: columns?.call(JobCurriculumProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobCurriculumProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobCurriculumProfile> updateRow(
    _i1.DatabaseSession session,
    JobCurriculumProfile row, {
    _i1.ColumnSelections<JobCurriculumProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobCurriculumProfile>(
      row,
      columns: columns?.call(JobCurriculumProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobCurriculumProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobCurriculumProfile?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<JobCurriculumProfileUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JobCurriculumProfile>(
      id,
      columnValues: columnValues(JobCurriculumProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobCurriculumProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JobCurriculumProfile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<JobCurriculumProfileUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<JobCurriculumProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobCurriculumProfileTable>? orderBy,
    _i1.OrderByListBuilder<JobCurriculumProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JobCurriculumProfile>(
      columnValues: columnValues(JobCurriculumProfile.t.updateTable),
      where: where(JobCurriculumProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobCurriculumProfile.t),
      orderByList: orderByList?.call(JobCurriculumProfile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JobCurriculumProfile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JobCurriculumProfile>> delete(
    _i1.DatabaseSession session,
    List<JobCurriculumProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JobCurriculumProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JobCurriculumProfile].
  Future<JobCurriculumProfile> deleteRow(
    _i1.DatabaseSession session,
    JobCurriculumProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobCurriculumProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JobCurriculumProfile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobCurriculumProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JobCurriculumProfile>(
      where: where(JobCurriculumProfile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobCurriculumProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JobCurriculumProfile>(
      where: where?.call(JobCurriculumProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobCurriculumProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobCurriculumProfileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobCurriculumProfile>(
      where: where(JobCurriculumProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
