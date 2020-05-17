import 'package:firebase/firebase.dart' as firebase;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_analytics_platform_interface/firebase_analytics_platform_interface.dart';

/// Web implementation for [FirebaseAnalyticsPlatform]
class FirebaseAnalyticsWeb extends FirebaseAnalyticsPlatform {
  /// Instance of Analytics from the web plugin.
  final firebase.Analytics _analytics = firebase.analytics();

  /// Called by PluginRegistry to register this plugin for Flutter Web
  static void registerWith(Registrar registrar) {
    FirebaseAnalyticsPlatform.instance = FirebaseAnalyticsWeb();
  }

  @override
  Future<void> logEvent({
    String name,
    Map<String, dynamic> parameters,
  }) {
    _analytics.logEvent(name, parameters);
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) {
    _analytics.setAnalyticsCollectionEnabled(enabled);
  }

  @override
  Future<void> setUserId(String id) {
    _analytics.setUserId(id);
  }

  @override
  Future<void> setCurrentScreen({
    String screenName,
    // TODO(tugorez): Determine what this parameter can be used for in Web.
    String screenClassOverride,
  }) {
    _analytics.setCurrentScreen(screenName);
  }

  @override
  Future<void> setUserProperty({
    String name,
    String value,
  }) {
    _analytics.setUserProperties({name: value});
  }

  @override
  Future<void> resetAnalyticsData() {
    // TODO(tugorez): Determine what is this used for.
  }

  @override
  Future<void> setSessionTimeoutDuration(int milliseconds) {
    // TODO(tugorez): Determine what is this used for.
  }
}
