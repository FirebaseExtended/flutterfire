library cloud_firestore_platform_interface;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart' show required, visibleForTesting;
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

part 'src/method_channel_firestore.dart';
part 'src/blob.dart';
part 'src/utils/auto_id_generator.dart';
part 'src/method_channel_field_value_factory.dart';
part 'src/platform_interface/field_value_factory.dart';
part 'src/platform_interface/collection_reference.dart';
part 'src/method_channel_collection_reference.dart';
part 'src/method_channel_document_change.dart';
part 'src/platform_interface/document_change.dart';
part 'src/method_channel_document_reference.dart';
part 'src/platform_interface/document_reference_interface.dart';
part 'src/document_snapshot.dart';
part 'src/field_path.dart';
part 'src/platform_interface/field_value.dart';
part 'src/firestore_message_codec.dart';
part 'src/geo_point.dart';
part 'src/method_channel_query.dart';
part 'src/platform_interface/query.dart';
part 'src/platform_interface/query_snapshot.dart';
part 'src/method_channel_query_snapshot.dart';
part 'src/snapshot_metadata.dart';
part 'src/source.dart';
part 'src/timestamp.dart';
part 'src/transaction.dart';
part 'src/transaction_platform_interface.dart';
part 'src/write_batch.dart';
part 'src/write_batch_platform_interface.dart';

abstract class FirestorePlatform extends PlatformInterface {
  final FirebaseApp app;

  FirestorePlatform({FirebaseApp app}) : app = app ?? FirebaseApp.instance, super(token: _token);

  static final Object _token = Object();

  factory FirestorePlatform.withApp({FirebaseApp app}) {
    FirestorePlatform.instance = FirestorePlatform.instance.withApp(app);
    return FirestorePlatform.instance;
  }

  static FirestorePlatform get instance {
    if (_instance == null) {
      _instance = MethodChannelFirestore();
    }
    return _instance;
  }

  static FirestorePlatform _instance;

  static set instance(FirestorePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  FirestorePlatform withApp(FirebaseApp app) {
    throw UnimplementedError("_withApp() not implemented");
  }

  String appName() {
    throw UnimplementedError("appName() not implemented");
  }

  /// Gets a [CollectionReference] for the specified Firestore path.
  CollectionReference collection(String path) {
    throw UnimplementedError('collection() is not implemented');
  }

  /// Gets a [Query] for the specified collection group.
  Query collectionGroup(String path) {
    throw UnimplementedError('collectionGroup() is not implemented');
  }

  /// Gets a [DocumentReference] for the specified Firestore path.
  DocumentReference document(String path) {
    throw UnimplementedError('document() is not implemented');
  }

  /// Creates a write batch, used for performing multiple writes as a single
  /// atomic operation.
  ///
  /// Unlike transactions, write batches are persisted offline and therefore are
  /// preferable when you don’t need to condition your writes on read data.
  WriteBatch batch() {
    throw UnimplementedError('batch() is not implemented');
  }

  /// Executes the given TransactionHandler and then attempts to commit the
  /// changes applied within an atomic transaction.
  ///
  /// In the TransactionHandler, a set of reads and writes can be performed
  /// atomically using the Transaction object passed to the TransactionHandler.
  /// After the TransactionHandler is run, Firestore will attempt to apply the
  /// changes to the server. If any of the data read has been modified outside
  /// of this transaction since being read, then the transaction will be
  /// retried by executing the updateBlock again. If the transaction still
  /// fails after 5 retries, then the transaction will fail.
  ///
  /// The TransactionHandler may be executed multiple times, it should be able
  /// to handle multiple executions.
  ///
  /// Data accessed with the transaction will not reflect local changes that
  /// have not been committed. For this reason, it is required that all
  /// reads are performed before any writes. Transactions must be performed
  /// while online. Otherwise, reads will fail, and the final commit will fail.
  ///
  /// By default transactions are limited to 5 seconds of execution time. This
  /// timeout can be adjusted by setting the timeout parameter.
  Future<Map<String, dynamic>> runTransaction(
      TransactionHandler transactionHandler,
      {Duration timeout = const Duration(seconds: 5)}) async {
    throw UnimplementedError('runTransaction() is not implemented');
  }

  @deprecated
  Future<void> enablePersistence(bool enable) async {
    throw UnimplementedError('enablePersistence() is not implemented');
  }

  Future<void> settings(
      {bool persistenceEnabled,
      String host,
      bool sslEnabled,
      int cacheSizeBytes}) async {
    throw UnimplementedError('settings() is not implemented');
  }

  @override
  int get hashCode => appName().hashCode;

  @override
  bool operator ==(dynamic o) => o is FirestorePlatform && o.app == app;
}
