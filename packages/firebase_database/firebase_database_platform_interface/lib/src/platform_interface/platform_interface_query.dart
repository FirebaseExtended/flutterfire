// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_database_platform_interface/firebase_database_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Represents a query over the data at a particular location.
abstract class QueryPlatform extends PlatformInterface {
  /// The Database instance associated with this query
  final DatabasePlatform database;

  /// The parameters associated with this query
  final Map<String, dynamic> parameters;

  static final Object _token = Object();

  /// Create a [QueryPlatform] instance
  QueryPlatform({
    required this.database,
    this.parameters = const <String, dynamic>{},
  }) : super(token: _token);

  /// Returns the path to this reference.
  String get path {
    throw UnimplementedError('get path not implemented');
  }

  /// Obtains a DatabaseReference corresponding to this query's location.
  DatabaseReferencePlatform get ref {
    throw UnimplementedError('get ref() not implemented');
  }

  /// Assigns the proper event type to a stream for [DatabaseEventPlatform]
  Stream<DatabaseEventPlatform> observe(DatabaseEventType eventType) {
    throw UnimplementedError('observe() not implemented');
  }

  /// Gets the most up-to-date result for this query.
  Future<DataSnapshotPlatform> get() {
    throw UnimplementedError('get() not implemented');
  }

  /// Fires when children are added.
  Stream<DatabaseEventPlatform> get onChildAdded =>
      observe(DatabaseEventType.childAdded);

  /// Fires when children are removed. `previousChildKey` is null.
  Stream<DatabaseEventPlatform> get onChildRemoved =>
      observe(DatabaseEventType.childRemoved);

  /// Fires when children are changed.
  Stream<DatabaseEventPlatform> get onChildChanged =>
      observe(DatabaseEventType.childChanged);

  /// Fires when children are moved.
  Stream<DatabaseEventPlatform> get onChildMoved =>
      observe(DatabaseEventType.childMoved);

  /// Fires when the data at this location is updated. `previousChildKey` is null.
  Stream<DatabaseEventPlatform> get onValue => observe(DatabaseEventType.value);

  /// Create a query constrained to only return child nodes with a value greater
  /// than or equal to the given value, using the given orderBy directive or
  /// priority as default, and optionally only child nodes with a key greater
  /// than or equal to the given key.
  QueryPlatform startAt(dynamic value, {String? key}) {
    throw UnimplementedError('startAt() not implemented');
  }

  /// Creates a query with the specified starting point (exclusive).
  /// Using [startAt], [startAfter], [endBefore], [endAt] and [equalTo]
  /// allows you to choose arbitrary starting and ending points for your
  /// queries.
  ///
  /// The starting point is exclusive.
  ///
  /// If only a value is provided, children with a value greater than
  /// the specified value will be included in the query.
  /// If a key is specified, then children must have a value greater than
  /// or equal to the specified value and a a key name greater than
  /// the specified key.
  QueryPlatform startAfter(dynamic value, {String? key}) {
    throw UnimplementedError('startAfter() not implemented');
  }

  /// Create a query constrained to only return child nodes with a value less
  /// than or equal to the given value, using the given orderBy directive or
  /// priority as default, and optionally only child nodes with a key less
  /// than or equal to the given key.
  QueryPlatform endAt(dynamic value, {String? key}) {
    throw UnimplementedError('endAt() not implemented');
  }

  /// Creates a query with the specified ending point (exclusive)
  /// The ending point is exclusive. If only a value is provided,
  /// children with a value less than the specified value will be included in
  /// the query. If a key is specified, then children must have a value lesss
  /// than or equal to the specified value and a a key name less than the
  /// specified key.
  QueryPlatform endBefore(dynamic value, {String? key}) {
    throw UnimplementedError('endBefore() not implemented');
  }

  /// Create a query constrained to only return child nodes with the given
  /// `value` (and `key`, if provided).
  ///
  /// If a key is provided, there is at most one such child as names are unique.
  QueryPlatform equalTo(dynamic value, {String? key}) {
    throw UnimplementedError('equalTo() not implemented');
  }

  /// Create a query with limit and anchor it to the start of the window.
  QueryPlatform limitToFirst(int limit) {
    throw UnimplementedError('limitToFirst() not implemented');
  }

  /// Create a query with limit and anchor it to the end of the window.
  QueryPlatform limitToLast(int limit) {
    throw UnimplementedError('limitToLast() not implemented');
  }

  /// Generate a view of the data sorted by values of a particular child key.
  ///
  /// Intended to be used in combination with [startAt], [endAt], or
  /// [equalTo].
  QueryPlatform orderByChild(String key) {
    throw UnimplementedError('orderByChild() not implemented');
  }

  /// Generate a view of the data sorted by key.
  ///
  /// Intended to be used in combination with [startAt], [endAt], or
  /// [equalTo].
  QueryPlatform orderByKey() {
    throw UnimplementedError('orderByKey() not implemented');
  }

  /// Generate a view of the data sorted by value.
  ///
  /// Intended to be used in combination with [startAt], [endAt], or
  /// [equalTo].
  QueryPlatform orderByValue() {
    throw UnimplementedError('orderByValue() not implemented');
  }

  /// Generate a view of the data sorted by priority.
  ///
  /// Intended to be used in combination with [startAt], [endAt], or
  /// [equalTo].
  QueryPlatform orderByPriority() {
    throw UnimplementedError('orderByPriority() not implemented');
  }

  /// By calling keepSynced(true) on a location, the data for that location will
  /// automatically be downloaded and kept in sync, even when no listeners are
  /// attached for that location. Additionally, while a location is kept synced,
  /// it will not be evicted from the persistent disk cache.
  Future<void> keepSynced(bool value) {
    throw UnimplementedError('keepSynced() not implemented');
  }
}
