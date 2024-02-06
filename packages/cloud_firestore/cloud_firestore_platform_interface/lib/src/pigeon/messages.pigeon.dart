// Copyright 2023, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

/// An enumeration of document change types.
enum DocumentChangeType {
  /// Indicates a new document was added to the set of documents matching the
  /// query.
  added,

  /// Indicates a document within the query was modified.
  modified,

  /// Indicates a document within the query was removed (either deleted or no
  /// longer matches the query.
  removed,
}

/// An enumeration of firestore source types.
enum Source {
  /// Causes Firestore to try to retrieve an up-to-date (server-retrieved) snapshot, but fall back to
  /// returning cached data if the server can't be reached.
  serverAndCache,

  /// Causes Firestore to avoid the cache, generating an error if the server cannot be reached. Note
  /// that the cache will still be updated if the server request succeeds. Also note that
  /// latency-compensation still takes effect, so any pending write operations will be visible in the
  /// returned data (merged into the server-provided data).
  server,

  /// Causes Firestore to immediately return a value from the cache, ignoring the server completely
  /// (implying that the returned value may be stale with respect to the value on the server). If
  /// there is no data in the cache to satisfy the `get` call,
  /// [DocumentReference.get] will throw a [FirebaseException] and
  /// [Query.get] will return an empty [QuerySnapshotPlatform] with no documents.
  cache,
}

enum ServerTimestampBehavior {
  /// Return null for [FieldValue.serverTimestamp()] values that have not yet
  none,

  /// Return local estimates for [FieldValue.serverTimestamp()] values that have not yet been set to their final value.
  estimate,

  /// Return the previous value for [FieldValue.serverTimestamp()] values that have not yet been set to their final value.
  previous,
}

/// [AggregateSource] represents the source of data for an [AggregateQuery].
enum AggregateSource {
  /// Indicates that the data should be retrieved from the server.
  server,
}

enum PigeonTransactionResult {
  success,
  failure,
}

enum PigeonTransactionType {
  get,
  update,
  set,
  deleteType,
}

enum AggregateType {
  count,
  sum,
  average,
}

class PigeonFirebaseSettings {
  PigeonFirebaseSettings({
    this.persistenceEnabled,
    this.host,
    this.sslEnabled,
    this.cacheSizeBytes,
    required this.ignoreUndefinedProperties,
  });

  bool? persistenceEnabled;

  String? host;

  bool? sslEnabled;

  int? cacheSizeBytes;

  bool ignoreUndefinedProperties;

  Object encode() {
    return <Object?>[
      persistenceEnabled,
      host,
      sslEnabled,
      cacheSizeBytes,
      ignoreUndefinedProperties,
    ];
  }

  static PigeonFirebaseSettings decode(Object result) {
    result as List<Object?>;
    return PigeonFirebaseSettings(
      persistenceEnabled: result[0] as bool?,
      host: result[1] as String?,
      sslEnabled: result[2] as bool?,
      cacheSizeBytes: result[3] as int?,
      ignoreUndefinedProperties: result[4]! as bool,
    );
  }
}

class FirestorePigeonFirebaseApp {
  FirestorePigeonFirebaseApp({
    required this.appName,
    required this.settings,
    required this.databaseURL,
  });

  String appName;

  PigeonFirebaseSettings settings;

  String databaseURL;

  Object encode() {
    return <Object?>[
      appName,
      settings.encode(),
      databaseURL,
    ];
  }

  static FirestorePigeonFirebaseApp decode(Object result) {
    result as List<Object?>;
    return FirestorePigeonFirebaseApp(
      appName: result[0]! as String,
      settings: PigeonFirebaseSettings.decode(result[1]! as List<Object?>),
      databaseURL: result[2]! as String,
    );
  }
}

class PigeonSnapshotMetadata {
  PigeonSnapshotMetadata({
    required this.hasPendingWrites,
    required this.isFromCache,
  });

  bool hasPendingWrites;

  bool isFromCache;

  Object encode() {
    return <Object?>[
      hasPendingWrites,
      isFromCache,
    ];
  }

  static PigeonSnapshotMetadata decode(Object result) {
    result as List<Object?>;
    return PigeonSnapshotMetadata(
      hasPendingWrites: result[0]! as bool,
      isFromCache: result[1]! as bool,
    );
  }
}

class PigeonDocumentSnapshot {
  PigeonDocumentSnapshot({
    required this.path,
    this.data,
    required this.metadata,
  });

  String path;

  Map<String?, Object?>? data;

  PigeonSnapshotMetadata metadata;

  Object encode() {
    return <Object?>[
      path,
      data,
      metadata.encode(),
    ];
  }

  static PigeonDocumentSnapshot decode(Object result) {
    result as List<Object?>;
    return PigeonDocumentSnapshot(
      path: result[0]! as String,
      data: (result[1] as Map<Object?, Object?>?)?.cast<String?, Object?>(),
      metadata: PigeonSnapshotMetadata.decode(result[2]! as List<Object?>),
    );
  }
}

class PigeonDocumentChange {
  PigeonDocumentChange({
    required this.type,
    required this.document,
    required this.oldIndex,
    required this.newIndex,
  });

  DocumentChangeType type;

  PigeonDocumentSnapshot document;

  int oldIndex;

  int newIndex;

  Object encode() {
    return <Object?>[
      type.index,
      document.encode(),
      oldIndex,
      newIndex,
    ];
  }

  static PigeonDocumentChange decode(Object result) {
    result as List<Object?>;
    return PigeonDocumentChange(
      type: DocumentChangeType.values[result[0]! as int],
      document: PigeonDocumentSnapshot.decode(result[1]! as List<Object?>),
      oldIndex: result[2]! as int,
      newIndex: result[3]! as int,
    );
  }
}

class PigeonQuerySnapshot {
  PigeonQuerySnapshot({
    required this.documents,
    required this.documentChanges,
    required this.metadata,
  });

  List<PigeonDocumentSnapshot?> documents;

  List<PigeonDocumentChange?> documentChanges;

  PigeonSnapshotMetadata metadata;

  Object encode() {
    return <Object?>[
      documents,
      documentChanges,
      metadata.encode(),
    ];
  }

  static PigeonQuerySnapshot decode(Object result) {
    result as List<Object?>;
    return PigeonQuerySnapshot(
      documents: (result[0] as List<Object?>?)!.cast<PigeonDocumentSnapshot?>(),
      documentChanges:
          (result[1] as List<Object?>?)!.cast<PigeonDocumentChange?>(),
      metadata: PigeonSnapshotMetadata.decode(result[2]! as List<Object?>),
    );
  }
}

class PigeonGetOptions {
  PigeonGetOptions({
    required this.source,
    required this.serverTimestampBehavior,
  });

  Source source;

  ServerTimestampBehavior serverTimestampBehavior;

  Object encode() {
    return <Object?>[
      source.index,
      serverTimestampBehavior.index,
    ];
  }

  static PigeonGetOptions decode(Object result) {
    result as List<Object?>;
    return PigeonGetOptions(
      source: Source.values[result[0]! as int],
      serverTimestampBehavior:
          ServerTimestampBehavior.values[result[1]! as int],
    );
  }
}

class PigeonDocumentOption {
  PigeonDocumentOption({
    this.merge,
    this.mergeFields,
  });

  bool? merge;

  List<List<String?>?>? mergeFields;

  Object encode() {
    return <Object?>[
      merge,
      mergeFields,
    ];
  }

  static PigeonDocumentOption decode(Object result) {
    result as List<Object?>;
    return PigeonDocumentOption(
      merge: result[0] as bool?,
      mergeFields: (result[1] as List<Object?>?)?.cast<List<String?>?>(),
    );
  }
}

class PigeonTransactionCommand {
  PigeonTransactionCommand({
    required this.type,
    required this.path,
    this.data,
    this.option,
  });

  PigeonTransactionType type;

  String path;

  Map<String?, Object?>? data;

  PigeonDocumentOption? option;

  Object encode() {
    return <Object?>[
      type.index,
      path,
      data,
      option?.encode(),
    ];
  }

  static PigeonTransactionCommand decode(Object result) {
    result as List<Object?>;
    return PigeonTransactionCommand(
      type: PigeonTransactionType.values[result[0]! as int],
      path: result[1]! as String,
      data: (result[2] as Map<Object?, Object?>?)?.cast<String?, Object?>(),
      option: result[3] != null
          ? PigeonDocumentOption.decode(result[3]! as List<Object?>)
          : null,
    );
  }
}

class DocumentReferenceRequest {
  DocumentReferenceRequest({
    required this.path,
    this.data,
    this.option,
    this.source,
    this.serverTimestampBehavior,
  });

  String path;

  Map<Object?, Object?>? data;

  PigeonDocumentOption? option;

  Source? source;

  ServerTimestampBehavior? serverTimestampBehavior;

  Object encode() {
    return <Object?>[
      path,
      data,
      option?.encode(),
      source?.index,
      serverTimestampBehavior?.index,
    ];
  }

  static DocumentReferenceRequest decode(Object result) {
    result as List<Object?>;
    return DocumentReferenceRequest(
      path: result[0]! as String,
      data: (result[1] as Map<Object?, Object?>?)?.cast<Object?, Object?>(),
      option: result[2] != null
          ? PigeonDocumentOption.decode(result[2]! as List<Object?>)
          : null,
      source: result[3] != null ? Source.values[result[3]! as int] : null,
      serverTimestampBehavior: result[4] != null
          ? ServerTimestampBehavior.values[result[4]! as int]
          : null,
    );
  }
}

class PigeonQueryParameters {
  PigeonQueryParameters({
    this.where,
    this.orderBy,
    this.limit,
    this.limitToLast,
    this.startAt,
    this.startAfter,
    this.endAt,
    this.endBefore,
    this.filters,
  });

  List<List<Object?>?>? where;

  List<List<Object?>?>? orderBy;

  int? limit;

  int? limitToLast;

  List<Object?>? startAt;

  List<Object?>? startAfter;

  List<Object?>? endAt;

  List<Object?>? endBefore;

  Map<String?, Object?>? filters;

  Object encode() {
    return <Object?>[
      where,
      orderBy,
      limit,
      limitToLast,
      startAt,
      startAfter,
      endAt,
      endBefore,
      filters,
    ];
  }

  static PigeonQueryParameters decode(Object result) {
    result as List<Object?>;
    return PigeonQueryParameters(
      where: (result[0] as List<Object?>?)?.cast<List<Object?>?>(),
      orderBy: (result[1] as List<Object?>?)?.cast<List<Object?>?>(),
      limit: result[2] as int?,
      limitToLast: result[3] as int?,
      startAt: (result[4] as List<Object?>?)?.cast<Object?>(),
      startAfter: (result[5] as List<Object?>?)?.cast<Object?>(),
      endAt: (result[6] as List<Object?>?)?.cast<Object?>(),
      endBefore: (result[7] as List<Object?>?)?.cast<Object?>(),
      filters: (result[8] as Map<Object?, Object?>?)?.cast<String?, Object?>(),
    );
  }
}

class AggregateQuery {
  AggregateQuery({
    required this.type,
    this.field,
  });

  AggregateType type;

  String? field;

  Object encode() {
    return <Object?>[
      type.index,
      field,
    ];
  }

  static AggregateQuery decode(Object result) {
    result as List<Object?>;
    return AggregateQuery(
      type: AggregateType.values[result[0]! as int],
      field: result[1] as String?,
    );
  }
}

class AggregateQueryResponse {
  AggregateQueryResponse({
    required this.type,
    this.field,
    required this.value,
  });

  AggregateType type;

  String? field;

  double value;

  Object encode() {
    return <Object?>[
      type.index,
      field,
      value,
    ];
  }

  static AggregateQueryResponse decode(Object result) {
    result as List<Object?>;
    return AggregateQueryResponse(
      type: AggregateType.values[result[0]! as int],
      field: result[1] as String?,
      value: result[2]! as double,
    );
  }
}

class _FirebaseFirestoreHostApiCodec extends StandardMessageCodec {
  const _FirebaseFirestoreHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AggregateQuery) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is AggregateQueryResponse) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is DocumentReferenceRequest) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is FirestorePigeonFirebaseApp) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is PigeonDocumentChange) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is PigeonDocumentOption) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is PigeonDocumentSnapshot) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is PigeonFirebaseSettings) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is PigeonGetOptions) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else if (value is PigeonQueryParameters) {
      buffer.putUint8(137);
      writeValue(buffer, value.encode());
    } else if (value is PigeonQuerySnapshot) {
      buffer.putUint8(138);
      writeValue(buffer, value.encode());
    } else if (value is PigeonSnapshotMetadata) {
      buffer.putUint8(139);
      writeValue(buffer, value.encode());
    } else if (value is PigeonTransactionCommand) {
      buffer.putUint8(140);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return AggregateQuery.decode(readValue(buffer)!);
      case 129:
        return AggregateQueryResponse.decode(readValue(buffer)!);
      case 130:
        return DocumentReferenceRequest.decode(readValue(buffer)!);
      case 131:
        return FirestorePigeonFirebaseApp.decode(readValue(buffer)!);
      case 132:
        return PigeonDocumentChange.decode(readValue(buffer)!);
      case 133:
        return PigeonDocumentOption.decode(readValue(buffer)!);
      case 134:
        return PigeonDocumentSnapshot.decode(readValue(buffer)!);
      case 135:
        return PigeonFirebaseSettings.decode(readValue(buffer)!);
      case 136:
        return PigeonGetOptions.decode(readValue(buffer)!);
      case 137:
        return PigeonQueryParameters.decode(readValue(buffer)!);
      case 138:
        return PigeonQuerySnapshot.decode(readValue(buffer)!);
      case 139:
        return PigeonSnapshotMetadata.decode(readValue(buffer)!);
      case 140:
        return PigeonTransactionCommand.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class FirebaseFirestoreHostApi {
  /// Constructor for [FirebaseFirestoreHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  FirebaseFirestoreHostApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _FirebaseFirestoreHostApiCodec();

  Future<String> loadBundle(
      FirestorePigeonFirebaseApp arg_app, Uint8List arg_bundle) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.loadBundle',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app, arg_bundle]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<PigeonQuerySnapshot> namedQueryGet(FirestorePigeonFirebaseApp arg_app,
      String arg_name, PigeonGetOptions arg_options) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.namedQueryGet',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel
        .send(<Object?>[arg_app, arg_name, arg_options]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as PigeonQuerySnapshot?)!;
    }
  }

  Future<void> clearPersistence(FirestorePigeonFirebaseApp arg_app) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.clearPersistence',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> disableNetwork(FirestorePigeonFirebaseApp arg_app) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.disableNetwork',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> enableNetwork(FirestorePigeonFirebaseApp arg_app) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.enableNetwork',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> terminate(FirestorePigeonFirebaseApp arg_app) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.terminate',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> waitForPendingWrites(FirestorePigeonFirebaseApp arg_app) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.waitForPendingWrites',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> setIndexConfiguration(
      FirestorePigeonFirebaseApp arg_app, String arg_indexConfiguration) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.setIndexConfiguration',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel
        .send(<Object?>[arg_app, arg_indexConfiguration]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> setLoggingEnabled(bool arg_loggingEnabled) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.setLoggingEnabled',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_loggingEnabled]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<String> snapshotsInSyncSetup(
      FirestorePigeonFirebaseApp arg_app) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.snapshotsInSyncSetup',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<String> transactionCreate(FirestorePigeonFirebaseApp arg_app,
      int arg_timeout, int arg_maxAttempts) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.transactionCreate',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app, arg_timeout, arg_maxAttempts])
            as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<void> transactionStoreResult(
      String arg_transactionId,
      PigeonTransactionResult arg_resultType,
      List<PigeonTransactionCommand?>? arg_commands) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.transactionStoreResult',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(
            <Object?>[arg_transactionId, arg_resultType.index, arg_commands])
        as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<PigeonDocumentSnapshot> transactionGet(
      FirestorePigeonFirebaseApp arg_app,
      String arg_transactionId,
      String arg_path) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.transactionGet',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app, arg_transactionId, arg_path])
            as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as PigeonDocumentSnapshot?)!;
    }
  }

  Future<void> documentReferenceSet(FirestorePigeonFirebaseApp arg_app,
      DocumentReferenceRequest arg_request) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.documentReferenceSet',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app, arg_request]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> documentReferenceUpdate(FirestorePigeonFirebaseApp arg_app,
      DocumentReferenceRequest arg_request) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.documentReferenceUpdate',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app, arg_request]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<PigeonDocumentSnapshot> documentReferenceGet(
      FirestorePigeonFirebaseApp arg_app,
      DocumentReferenceRequest arg_request) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.documentReferenceGet',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app, arg_request]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as PigeonDocumentSnapshot?)!;
    }
  }

  Future<void> documentReferenceDelete(FirestorePigeonFirebaseApp arg_app,
      DocumentReferenceRequest arg_request) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.documentReferenceDelete',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app, arg_request]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<PigeonQuerySnapshot> queryGet(
      FirestorePigeonFirebaseApp arg_app,
      String arg_path,
      bool arg_isCollectionGroup,
      PigeonQueryParameters arg_parameters,
      PigeonGetOptions arg_options) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.queryGet',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(<Object?>[
      arg_app,
      arg_path,
      arg_isCollectionGroup,
      arg_parameters,
      arg_options
    ]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as PigeonQuerySnapshot?)!;
    }
  }

  Future<List<AggregateQueryResponse?>> aggregateQuery(
      FirestorePigeonFirebaseApp arg_app,
      String arg_path,
      PigeonQueryParameters arg_parameters,
      AggregateSource arg_source,
      List<AggregateQuery?> arg_queries,
      bool arg_isCollectionGroup) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.aggregateQuery',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(<Object?>[
      arg_app,
      arg_path,
      arg_parameters,
      arg_source.index,
      arg_queries,
      arg_isCollectionGroup
    ]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as List<Object?>?)!.cast<AggregateQueryResponse?>();
    }
  }

  Future<void> writeBatchCommit(FirestorePigeonFirebaseApp arg_app,
      List<PigeonTransactionCommand?> arg_writes) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.writeBatchCommit',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_app, arg_writes]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<String> querySnapshot(
      FirestorePigeonFirebaseApp arg_app,
      String arg_path,
      bool arg_isCollectionGroup,
      PigeonQueryParameters arg_parameters,
      PigeonGetOptions arg_options,
      bool arg_includeMetadataChanges) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.querySnapshot',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(<Object?>[
      arg_app,
      arg_path,
      arg_isCollectionGroup,
      arg_parameters,
      arg_options,
      arg_includeMetadataChanges
    ]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<String> documentReferenceSnapshot(
      FirestorePigeonFirebaseApp arg_app,
      DocumentReferenceRequest arg_parameters,
      bool arg_includeMetadataChanges) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.cloud_firestore_platform_interface.FirebaseFirestoreHostApi.documentReferenceSnapshot',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(
            <Object?>[arg_app, arg_parameters, arg_includeMetadataChanges])
        as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }
}
