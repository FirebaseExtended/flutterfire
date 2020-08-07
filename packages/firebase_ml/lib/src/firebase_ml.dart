// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter/services.dart';

import 'firebase_model_manager.dart';

/// The Firebase machine learning API.
///
/// You can get an instance by calling [FirebaseML.instance]
class FirebaseML {
  FirebaseML._();

  /// Singleton of [FirebaseML].
  static final FirebaseML instance = FirebaseML._();

  static const MethodChannel _channel =
      MethodChannel('plugins.flutter.io/firebase_ml');

  /// Example call across channel
  static Future<String> get doSomething async {
    final String version = await _channel.invokeMethod('downloadRemoteModel');
    return version;
  }

  /// Creates an instance of [FirebaseModelManager].
  FirebaseModelManager firebaseModelManager() {
    return FirebaseModelManager();
  }
}
