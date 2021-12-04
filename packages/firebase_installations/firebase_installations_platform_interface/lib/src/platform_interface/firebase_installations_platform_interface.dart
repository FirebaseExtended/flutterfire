// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../method_channel/method_channel_firebase_installations.dart';

abstract class FirebaseInstallationsPlatform extends PlatformInterface {
  /// Create an instance using [app].
  FirebaseInstallationsPlatform(this.app) : super(token: _token);

  static final Object _token = Object();

  static FirebaseInstallationsPlatform? _instance;

  /// The [FirebaseApp] this instance was initialized with
  final FirebaseApp? app;

  /// Create an instance using [app] using the existing implementation
  factory FirebaseInstallationsPlatform.instanceFor(
      {required FirebaseApp app}) {
    return FirebaseInstallationsPlatform.instance.delegateFor(app: app);
  }

  /// The current default [FirebaseInstallationsPlatform] instance.
  ///
  /// It will always default to [MethodChannelFirebaseInstallations]
  /// if no other implementation was provided.
  static FirebaseInstallationsPlatform get instance {
    return _instance ??= MethodChannelFirebaseInstallations.instance;
  }

  /// Sets the [FirebaseInstallationsPlatform.instance]
  static set instance(FirebaseInstallationsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Enables delegates to create new instances of themselves if a none default
  /// [FirebaseApp] instance or region is required by the user.
  @protected
  FirebaseInstallationsPlatform delegateFor({required FirebaseApp app}) {
    throw UnimplementedError('delegateFor() is not implemented');
  }

  /// Deletes the Firebase Installation and all associated data.
  Future<void> delete() {
    throw UnimplementedError('delete() is not implemented');
  }

  /// Creates a Firebase Installation if there isn't one for the app and
  /// returns the Installation ID.
  Future<String> getId() {
    throw UnimplementedError('getId() is not implemented');
  }

  /// Returns an Authentication Token for the current Firebase Installation.
  Future<String> getToken(bool forceRefresh) {
    throw UnimplementedError('getToken() is not implemented');
  }

  /// Sends a new event via a [Stream] whenever the Installation ID changes.
  Stream<String> get idChanges {
    throw UnimplementedError('get idTokenChanges is not implemented');
  }
}
