// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class TracePlatform extends PlatformInterface {
  TracePlatform() : super(token: _token);

  static void verifyExtends(TracePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
  }

  static final Object _token = Object();

  /// Maximum allowed length of a key passed to [putAttribute].
  static const int maxAttributeKeyLength = 40;

  /// Maximum allowed length of a value passed to [putAttribute].
  static const int maxAttributeValueLength = 100;

  /// Maximum allowed number of attributes that can be added.
  static const int maxCustomAttributes = 5;

  Future<void> start() {
    throw UnimplementedError('start() is not implemented');
  }

  Future<void> stop() {
    throw UnimplementedError('stop() is not implemented');
  }

  void incrementMetric(String name, int value) {
    throw UnimplementedError('incrementMetric() is not implemented');
  }

  /// Only works for native apps. Does nothing for web apps.
  void setMetric(String name, int value) {
    throw UnimplementedError('setMetric() is not implemented');
  }

  int getMetric(String name) {
    throw UnimplementedError('getMetric() is not implemented');
  }

  void putAttribute(String name, String value) {
    throw UnimplementedError('putAttribute() is not implemented');
  }

  void removeAttribute(String name) {
    throw UnimplementedError('removeAttribute() is not implemented');
  }

  String? getAttribute(String name) {
    throw UnimplementedError('getAttribute() is not implemented');
  }

  Map<String, String> getAttributes() {
    throw UnimplementedError('getAttributes() is not implemented');
  }
}
