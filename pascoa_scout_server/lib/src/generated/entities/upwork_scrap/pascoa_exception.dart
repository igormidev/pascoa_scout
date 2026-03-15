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

abstract class PascoaException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  PascoaException._({
    required this.message,
    required this.description,
    this.error,
    this.stackTrace,
  });

  factory PascoaException({
    required String message,
    required String description,
    String? error,
    String? stackTrace,
  }) = _PascoaExceptionImpl;

  factory PascoaException.fromJson(Map<String, dynamic> jsonSerialization) {
    return PascoaException(
      message: jsonSerialization['message'] as String,
      description: jsonSerialization['description'] as String,
      error: jsonSerialization['error'] as String?,
      stackTrace: jsonSerialization['stackTrace'] as String?,
    );
  }

  String message;

  String description;

  String? error;

  String? stackTrace;

  /// Returns a shallow copy of this [PascoaException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PascoaException copyWith({
    String? message,
    String? description,
    String? error,
    String? stackTrace,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PascoaException',
      'message': message,
      'description': description,
      if (error != null) 'error': error,
      if (stackTrace != null) 'stackTrace': stackTrace,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PascoaException',
      'message': message,
      'description': description,
      if (error != null) 'error': error,
      if (stackTrace != null) 'stackTrace': stackTrace,
    };
  }

  @override
  String toString() {
    return 'PascoaException(message: $message, description: $description, error: $error, stackTrace: $stackTrace)';
  }
}

class _Undefined {}

class _PascoaExceptionImpl extends PascoaException {
  _PascoaExceptionImpl({
    required String message,
    required String description,
    String? error,
    String? stackTrace,
  }) : super._(
         message: message,
         description: description,
         error: error,
         stackTrace: stackTrace,
       );

  /// Returns a shallow copy of this [PascoaException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PascoaException copyWith({
    String? message,
    String? description,
    Object? error = _Undefined,
    Object? stackTrace = _Undefined,
  }) {
    return PascoaException(
      message: message ?? this.message,
      description: description ?? this.description,
      error: error is String? ? error : this.error,
      stackTrace: stackTrace is String? ? stackTrace : this.stackTrace,
    );
  }
}
