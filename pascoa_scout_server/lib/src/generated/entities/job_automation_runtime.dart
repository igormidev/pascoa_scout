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
import '../entities/job_automation_step.dart' as _i2;

abstract class JobAutomationRuntime
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  JobAutomationRuntime._({
    this.id,
    required this.singletonKey,
    required this.currentStep,
    required this.currentStepStartedAt,
    required this.updatedAt,
    this.lastSuccessfulJobSyncAt,
    this.lastSuccessfulScoringAt,
    this.lastSuccessfulProposalGenerationAt,
    this.lastErrorMessage,
    this.lastErrorAt,
  });

  factory JobAutomationRuntime({
    int? id,
    required String singletonKey,
    required _i2.JobAutomationStep currentStep,
    required DateTime currentStepStartedAt,
    required DateTime updatedAt,
    DateTime? lastSuccessfulJobSyncAt,
    DateTime? lastSuccessfulScoringAt,
    DateTime? lastSuccessfulProposalGenerationAt,
    String? lastErrorMessage,
    DateTime? lastErrorAt,
  }) = _JobAutomationRuntimeImpl;

  factory JobAutomationRuntime.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobAutomationRuntime(
      id: jsonSerialization['id'] as int?,
      singletonKey: jsonSerialization['singletonKey'] as String,
      currentStep: _i2.JobAutomationStep.fromJson(
        (jsonSerialization['currentStep'] as String),
      ),
      currentStepStartedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['currentStepStartedAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      lastSuccessfulJobSyncAt:
          jsonSerialization['lastSuccessfulJobSyncAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessfulJobSyncAt'],
            ),
      lastSuccessfulScoringAt:
          jsonSerialization['lastSuccessfulScoringAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessfulScoringAt'],
            ),
      lastSuccessfulProposalGenerationAt:
          jsonSerialization['lastSuccessfulProposalGenerationAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessfulProposalGenerationAt'],
            ),
      lastErrorMessage: jsonSerialization['lastErrorMessage'] as String?,
      lastErrorAt: jsonSerialization['lastErrorAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastErrorAt'],
            ),
    );
  }

  static final t = JobAutomationRuntimeTable();

  static const db = JobAutomationRuntimeRepository._();

  @override
  int? id;

  String singletonKey;

  _i2.JobAutomationStep currentStep;

  DateTime currentStepStartedAt;

  DateTime updatedAt;

  DateTime? lastSuccessfulJobSyncAt;

  DateTime? lastSuccessfulScoringAt;

  DateTime? lastSuccessfulProposalGenerationAt;

  String? lastErrorMessage;

  DateTime? lastErrorAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobAutomationRuntime]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAutomationRuntime copyWith({
    int? id,
    String? singletonKey,
    _i2.JobAutomationStep? currentStep,
    DateTime? currentStepStartedAt,
    DateTime? updatedAt,
    DateTime? lastSuccessfulJobSyncAt,
    DateTime? lastSuccessfulScoringAt,
    DateTime? lastSuccessfulProposalGenerationAt,
    String? lastErrorMessage,
    DateTime? lastErrorAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAutomationRuntime',
      if (id != null) 'id': id,
      'singletonKey': singletonKey,
      'currentStep': currentStep.toJson(),
      'currentStepStartedAt': currentStepStartedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastSuccessfulJobSyncAt != null)
        'lastSuccessfulJobSyncAt': lastSuccessfulJobSyncAt?.toJson(),
      if (lastSuccessfulScoringAt != null)
        'lastSuccessfulScoringAt': lastSuccessfulScoringAt?.toJson(),
      if (lastSuccessfulProposalGenerationAt != null)
        'lastSuccessfulProposalGenerationAt': lastSuccessfulProposalGenerationAt
            ?.toJson(),
      if (lastErrorMessage != null) 'lastErrorMessage': lastErrorMessage,
      if (lastErrorAt != null) 'lastErrorAt': lastErrorAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobAutomationRuntime',
      if (id != null) 'id': id,
      'singletonKey': singletonKey,
      'currentStep': currentStep.toJson(),
      'currentStepStartedAt': currentStepStartedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastSuccessfulJobSyncAt != null)
        'lastSuccessfulJobSyncAt': lastSuccessfulJobSyncAt?.toJson(),
      if (lastSuccessfulScoringAt != null)
        'lastSuccessfulScoringAt': lastSuccessfulScoringAt?.toJson(),
      if (lastSuccessfulProposalGenerationAt != null)
        'lastSuccessfulProposalGenerationAt': lastSuccessfulProposalGenerationAt
            ?.toJson(),
      if (lastErrorMessage != null) 'lastErrorMessage': lastErrorMessage,
      if (lastErrorAt != null) 'lastErrorAt': lastErrorAt?.toJson(),
    };
  }

  static JobAutomationRuntimeInclude include() {
    return JobAutomationRuntimeInclude._();
  }

  static JobAutomationRuntimeIncludeList includeList({
    _i1.WhereExpressionBuilder<JobAutomationRuntimeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobAutomationRuntimeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobAutomationRuntimeTable>? orderByList,
    JobAutomationRuntimeInclude? include,
  }) {
    return JobAutomationRuntimeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobAutomationRuntime.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JobAutomationRuntime.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobAutomationRuntimeImpl extends JobAutomationRuntime {
  _JobAutomationRuntimeImpl({
    int? id,
    required String singletonKey,
    required _i2.JobAutomationStep currentStep,
    required DateTime currentStepStartedAt,
    required DateTime updatedAt,
    DateTime? lastSuccessfulJobSyncAt,
    DateTime? lastSuccessfulScoringAt,
    DateTime? lastSuccessfulProposalGenerationAt,
    String? lastErrorMessage,
    DateTime? lastErrorAt,
  }) : super._(
         id: id,
         singletonKey: singletonKey,
         currentStep: currentStep,
         currentStepStartedAt: currentStepStartedAt,
         updatedAt: updatedAt,
         lastSuccessfulJobSyncAt: lastSuccessfulJobSyncAt,
         lastSuccessfulScoringAt: lastSuccessfulScoringAt,
         lastSuccessfulProposalGenerationAt: lastSuccessfulProposalGenerationAt,
         lastErrorMessage: lastErrorMessage,
         lastErrorAt: lastErrorAt,
       );

  /// Returns a shallow copy of this [JobAutomationRuntime]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAutomationRuntime copyWith({
    Object? id = _Undefined,
    String? singletonKey,
    _i2.JobAutomationStep? currentStep,
    DateTime? currentStepStartedAt,
    DateTime? updatedAt,
    Object? lastSuccessfulJobSyncAt = _Undefined,
    Object? lastSuccessfulScoringAt = _Undefined,
    Object? lastSuccessfulProposalGenerationAt = _Undefined,
    Object? lastErrorMessage = _Undefined,
    Object? lastErrorAt = _Undefined,
  }) {
    return JobAutomationRuntime(
      id: id is int? ? id : this.id,
      singletonKey: singletonKey ?? this.singletonKey,
      currentStep: currentStep ?? this.currentStep,
      currentStepStartedAt: currentStepStartedAt ?? this.currentStepStartedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSuccessfulJobSyncAt: lastSuccessfulJobSyncAt is DateTime?
          ? lastSuccessfulJobSyncAt
          : this.lastSuccessfulJobSyncAt,
      lastSuccessfulScoringAt: lastSuccessfulScoringAt is DateTime?
          ? lastSuccessfulScoringAt
          : this.lastSuccessfulScoringAt,
      lastSuccessfulProposalGenerationAt:
          lastSuccessfulProposalGenerationAt is DateTime?
          ? lastSuccessfulProposalGenerationAt
          : this.lastSuccessfulProposalGenerationAt,
      lastErrorMessage: lastErrorMessage is String?
          ? lastErrorMessage
          : this.lastErrorMessage,
      lastErrorAt: lastErrorAt is DateTime? ? lastErrorAt : this.lastErrorAt,
    );
  }
}

class JobAutomationRuntimeUpdateTable
    extends _i1.UpdateTable<JobAutomationRuntimeTable> {
  JobAutomationRuntimeUpdateTable(super.table);

  _i1.ColumnValue<String, String> singletonKey(String value) => _i1.ColumnValue(
    table.singletonKey,
    value,
  );

  _i1.ColumnValue<_i2.JobAutomationStep, _i2.JobAutomationStep> currentStep(
    _i2.JobAutomationStep value,
  ) => _i1.ColumnValue(
    table.currentStep,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> currentStepStartedAt(DateTime value) =>
      _i1.ColumnValue(
        table.currentStepStartedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastSuccessfulJobSyncAt(
    DateTime? value,
  ) => _i1.ColumnValue(
    table.lastSuccessfulJobSyncAt,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastSuccessfulScoringAt(
    DateTime? value,
  ) => _i1.ColumnValue(
    table.lastSuccessfulScoringAt,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastSuccessfulProposalGenerationAt(
    DateTime? value,
  ) => _i1.ColumnValue(
    table.lastSuccessfulProposalGenerationAt,
    value,
  );

  _i1.ColumnValue<String, String> lastErrorMessage(String? value) =>
      _i1.ColumnValue(
        table.lastErrorMessage,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastErrorAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastErrorAt,
        value,
      );
}

class JobAutomationRuntimeTable extends _i1.Table<int?> {
  JobAutomationRuntimeTable({super.tableRelation})
    : super(tableName: 'job_automation_runtime') {
    updateTable = JobAutomationRuntimeUpdateTable(this);
    singletonKey = _i1.ColumnString(
      'singletonKey',
      this,
    );
    currentStep = _i1.ColumnEnum(
      'currentStep',
      this,
      _i1.EnumSerialization.byName,
    );
    currentStepStartedAt = _i1.ColumnDateTime(
      'currentStepStartedAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    lastSuccessfulJobSyncAt = _i1.ColumnDateTime(
      'lastSuccessfulJobSyncAt',
      this,
    );
    lastSuccessfulScoringAt = _i1.ColumnDateTime(
      'lastSuccessfulScoringAt',
      this,
    );
    lastSuccessfulProposalGenerationAt = _i1.ColumnDateTime(
      'lastSuccessfulProposalGenerationAt',
      this,
    );
    lastErrorMessage = _i1.ColumnString(
      'lastErrorMessage',
      this,
    );
    lastErrorAt = _i1.ColumnDateTime(
      'lastErrorAt',
      this,
    );
  }

  late final JobAutomationRuntimeUpdateTable updateTable;

  late final _i1.ColumnString singletonKey;

  late final _i1.ColumnEnum<_i2.JobAutomationStep> currentStep;

  late final _i1.ColumnDateTime currentStepStartedAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime lastSuccessfulJobSyncAt;

  late final _i1.ColumnDateTime lastSuccessfulScoringAt;

  late final _i1.ColumnDateTime lastSuccessfulProposalGenerationAt;

  late final _i1.ColumnString lastErrorMessage;

  late final _i1.ColumnDateTime lastErrorAt;

  @override
  List<_i1.Column> get columns => [
    id,
    singletonKey,
    currentStep,
    currentStepStartedAt,
    updatedAt,
    lastSuccessfulJobSyncAt,
    lastSuccessfulScoringAt,
    lastSuccessfulProposalGenerationAt,
    lastErrorMessage,
    lastErrorAt,
  ];
}

class JobAutomationRuntimeInclude extends _i1.IncludeObject {
  JobAutomationRuntimeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => JobAutomationRuntime.t;
}

class JobAutomationRuntimeIncludeList extends _i1.IncludeList {
  JobAutomationRuntimeIncludeList._({
    _i1.WhereExpressionBuilder<JobAutomationRuntimeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobAutomationRuntime.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JobAutomationRuntime.t;
}

class JobAutomationRuntimeRepository {
  const JobAutomationRuntimeRepository._();

  /// Returns a list of [JobAutomationRuntime]s matching the given query parameters.
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
  Future<List<JobAutomationRuntime>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobAutomationRuntimeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobAutomationRuntimeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobAutomationRuntimeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobAutomationRuntime>(
      where: where?.call(JobAutomationRuntime.t),
      orderBy: orderBy?.call(JobAutomationRuntime.t),
      orderByList: orderByList?.call(JobAutomationRuntime.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobAutomationRuntime] matching the given query parameters.
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
  Future<JobAutomationRuntime?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobAutomationRuntimeTable>? where,
    int? offset,
    _i1.OrderByBuilder<JobAutomationRuntimeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobAutomationRuntimeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobAutomationRuntime>(
      where: where?.call(JobAutomationRuntime.t),
      orderBy: orderBy?.call(JobAutomationRuntime.t),
      orderByList: orderByList?.call(JobAutomationRuntime.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobAutomationRuntime] by its [id] or null if no such row exists.
  Future<JobAutomationRuntime?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobAutomationRuntime>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobAutomationRuntime]s in the list and returns the inserted rows.
  ///
  /// The returned [JobAutomationRuntime]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<JobAutomationRuntime>> insert(
    _i1.DatabaseSession session,
    List<JobAutomationRuntime> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<JobAutomationRuntime>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [JobAutomationRuntime] and returns the inserted row.
  ///
  /// The returned [JobAutomationRuntime] will have its `id` field set.
  Future<JobAutomationRuntime> insertRow(
    _i1.DatabaseSession session,
    JobAutomationRuntime row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobAutomationRuntime>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JobAutomationRuntime]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JobAutomationRuntime>> update(
    _i1.DatabaseSession session,
    List<JobAutomationRuntime> rows, {
    _i1.ColumnSelections<JobAutomationRuntimeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JobAutomationRuntime>(
      rows,
      columns: columns?.call(JobAutomationRuntime.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobAutomationRuntime]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobAutomationRuntime> updateRow(
    _i1.DatabaseSession session,
    JobAutomationRuntime row, {
    _i1.ColumnSelections<JobAutomationRuntimeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobAutomationRuntime>(
      row,
      columns: columns?.call(JobAutomationRuntime.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobAutomationRuntime] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobAutomationRuntime?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<JobAutomationRuntimeUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JobAutomationRuntime>(
      id,
      columnValues: columnValues(JobAutomationRuntime.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobAutomationRuntime]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JobAutomationRuntime>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<JobAutomationRuntimeUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<JobAutomationRuntimeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobAutomationRuntimeTable>? orderBy,
    _i1.OrderByListBuilder<JobAutomationRuntimeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JobAutomationRuntime>(
      columnValues: columnValues(JobAutomationRuntime.t.updateTable),
      where: where(JobAutomationRuntime.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobAutomationRuntime.t),
      orderByList: orderByList?.call(JobAutomationRuntime.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JobAutomationRuntime]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JobAutomationRuntime>> delete(
    _i1.DatabaseSession session,
    List<JobAutomationRuntime> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JobAutomationRuntime>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JobAutomationRuntime].
  Future<JobAutomationRuntime> deleteRow(
    _i1.DatabaseSession session,
    JobAutomationRuntime row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobAutomationRuntime>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JobAutomationRuntime>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobAutomationRuntimeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JobAutomationRuntime>(
      where: where(JobAutomationRuntime.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobAutomationRuntimeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JobAutomationRuntime>(
      where: where?.call(JobAutomationRuntime.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobAutomationRuntime] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobAutomationRuntimeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobAutomationRuntime>(
      where: where(JobAutomationRuntime.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
