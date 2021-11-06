// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_analytics_platform_interface/firebase_analytics_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_web/firebase_core_web_interop.dart'
    as core_interop;
import 'interop/analytics.dart' as analytics_interop;

/// Web implementation of [FirebaseAnalyticsPlatform]
class FirebaseAnalyticsWeb extends FirebaseAnalyticsPlatform {
  /// instance of Analytics from the web plugin
  analytics_interop.Analytics? _webAnalytics;

  /// Lazily initialize [_webAnalytics] on first method call
  analytics_interop.Analytics get _delegate {
    return _webAnalytics ??=
        analytics_interop.getAnalyticsInstance(core_interop.app(app.name));
  }

  /// Builds an instance of [FirebaseAnalyticsWeb] with an optional [FirebaseApp] instance
  /// If [app] is null then the created instance will use the default [FirebaseApp]
  FirebaseAnalyticsWeb({FirebaseApp? app}) : super(appInstance: app);

  /// Called by PluginRegistry to register this plugin for Flutter Web
  static void registerWith(Registrar registrar) {
    FirebaseAnalyticsPlatform.instance = FirebaseAnalyticsWeb();
  }

  @override
  FirebaseAnalyticsPlatform delegateFor({FirebaseApp? app}) {
    return FirebaseAnalyticsWeb(app: app);
  }

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
    CallOptions? callOptions,
  }) async {
    _delegate.logEvent(
      name: name,
      parameters: parameters ?? {},
      callOptions: callOptions,
    );
  }

  @override
  Future<void> setConsent(
      {ConsentStatus? adStorage, ConsentStatus? analyticsStorage}) async {
    // no setConsent() API for web
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    _delegate.setAnalyticsCollectionEnabled(enabled: enabled);
  }

  @override
  Future<void> setUserId({
    String? id,
    CallOptions? callOptions,
  }) async {
    _delegate.setUserId(
      id: id,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> setCurrentScreen({
    String? screenName,
    String? screenClassOverride,
    CallOptions? callOptions,
  }) async {
    _delegate.setCurrentScreen(
      screenName: screenName,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> resetAnalyticsData() async {
    // no resetAnalyticsData() API for web
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required Object value,
    CallOptions? callOptions,
  }) async {
    _delegate.setUserProperty(
      name: name,
      value: value,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> setSessionTimeoutDuration(Duration timeout) async {
    // no setSessionTimeoutDuration() API for web
  }
}
