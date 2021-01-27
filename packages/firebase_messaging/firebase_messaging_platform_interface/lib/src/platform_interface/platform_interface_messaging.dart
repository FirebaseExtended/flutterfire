// Copyright 2020, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging_platform_interface/firebase_messaging_platform_interface.dart';
import 'package:meta/meta.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../method_channel/method_channel_messaging.dart';

/// Defines an interface to work with Messaging on web and mobile.
abstract class FirebaseMessagingPlatform extends PlatformInterface {
  /// The [FirebaseApp] this instance was initialized with.
  @protected
  final FirebaseApp appInstance;

  /// Create an instance using [app].
  FirebaseMessagingPlatform({this.appInstance}) : super(token: _token);

  /// Returns the [FirebaseApp] for the current instance.
  FirebaseApp get app {
    if (appInstance == null) {
      return Firebase.app();
    }

    return appInstance;
  }

  static final Object _token = Object();

  /// Create an instance with a [FirebaseApp] using an existing instance.
  factory FirebaseMessagingPlatform.instanceFor(
      {FirebaseApp app, Map<dynamic, dynamic> pluginConstants}) {
    return FirebaseMessagingPlatform.instance
        .delegateFor(app: app)
        .setInitialValues(
          isAutoInitEnabled: pluginConstants['AUTO_INIT_ENABLED'],
        );
  }

  static FirebaseMessagingPlatform _instance;

  /// The current default [FirebaseMessagingPlatform] instance.
  ///
  /// It will always default to [MethodChannelFirebaseMessaging]
  /// if no other implementation was provided.
  static FirebaseMessagingPlatform get instance {
    return _instance ??= MethodChannelFirebaseMessaging.instance;
  }

  /// Sets the [FirebaseMessagingPlatform.instance]
  static set instance(FirebaseMessagingPlatform instance) {
    assert(instance != null);
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // ignore: close_sinks
  static StreamController<RemoteMessage> _onMessageStreamController;

  /// Returns a Stream that is called when an incoming FCM payload is received whilst
  /// the Flutter instance is in the foreground.
  ///
  /// To handle messages whilst the app is in the background or terminated,
  /// see [onBackgroundMessage].
  static StreamController<RemoteMessage> get onMessage {
    return _onMessageStreamController ??=
        StreamController<RemoteMessage>.broadcast();
  }

  // ignore: close_sinks
  static StreamController<RemoteMessage> _onMessageOpenedAppStreamController;

  /// Returns a [Stream] that is called when a user presses a notification displayed
  /// via FCM.
  ///
  /// A Stream event will be sent if the app has opened from a background state
  /// (not terminated).
  ///
  /// If your app is opened via a notification whilst the app is terminated,
  /// see [getInitialMessage].
  static StreamController<RemoteMessage> get onMessageOpenedApp {
    return _onMessageOpenedAppStreamController ??=
        StreamController<RemoteMessage>.broadcast();
  }

  static BackgroundMessageHandler _onBackgroundMessageHandler;

  /// Set a message handler function which is called when the app is in the
  /// background or terminated.
  ///
  /// This provided handler must be a top-level function and cannot be
  /// anonymous otherwise an [ArgumentError] will be thrown.
  static BackgroundMessageHandler get onBackgroundMessage {
    return _onBackgroundMessageHandler;
  }

  /// Allows the background message handler to be created and calls the
  /// instance delegate [registerBackgroundMessageHandler] to perform any
  /// platform specific registration logic.
  static set onBackgroundMessage(BackgroundMessageHandler handler) {
    _onBackgroundMessageHandler = handler;
    instance.registerBackgroundMessageHandler(handler);
  }

  /// Enables delegates to create new instances of themselves if a none default
  /// [FirebaseApp] instance is required by the user.
  @protected
  FirebaseMessagingPlatform delegateFor({FirebaseApp app}) {
    throw UnimplementedError('delegateFor() is not implemented');
  }

  /// Sets any initial values on the instance.
  ///
  /// Platforms with Method Channels can provide constant values to be available
  /// before the instance has initialized to prevent any unnecessary async
  /// calls.
  @protected
  FirebaseMessagingPlatform setInitialValues({
    bool isAutoInitEnabled,
  }) {
    throw UnimplementedError('setInitialValues() is not implemented');
  }

  /// Returns whether messaging auto initialization is enabled or disabled for the device.
  bool get isAutoInitEnabled {
    throw UnimplementedError('isAutoInitEnabled is not implemented');
  }

  /// If the application has been opened from a terminated state via a [RemoteMessage]
  /// (containing a [Notification]), it will be returned, otherwise it will be `null`.
  ///
  /// Once the [Notification] has been consumed, it will be removed and further
  /// calls to [getInitialMessage] will be `null`.
  ///
  /// This should be used to determine whether specific notification interaction
  /// should open the app with a specific purpose (e.g. opening a chat message,
  /// specific screen etc).
  Future<RemoteMessage> getInitialMessage() {
    throw UnimplementedError('getInitialMessage() is not implemented');
  }

  /// Allows delegates to create a background message handler implementation.
  ///
  /// For example, on native platforms this could be to setup an isolate, whereas
  /// on web a service worker can be registered.
  void registerBackgroundMessageHandler(BackgroundMessageHandler handler) {
    throw UnimplementedError(
        'registerBackgroundMessageHandler() is not implemented');
  }

  /// Removes access to an FCM token previously authorized with optional [senderId].
  ///
  /// Messages sent by the server to this token will fail.
  Future<void> deleteToken({
    String senderId,
  }) {
    throw UnimplementedError('deleteToken() is not implemented');
  }

  /// On iOS & MacOS, it is possible to get the users APNs token. This may be required
  /// if you want to send messages to your iOS devices without using the FCM service.
  Future<String> getAPNSToken() {
    throw UnimplementedError('getAPNSToken() is not implemented');
  }

  /// Returns the default FCM token for this device and optionally [senderId].
  Future<String> getToken({
    String senderId,
    String vapidKey,
  }) {
    throw UnimplementedError('getToken() is not implemented');
  }

  /// Fires when a new FCM token is generated.
  Stream<String> get onTokenRefresh {
    throw UnimplementedError('onTokenRefresh is not implemented');
  }

  /// Returns the current [NotificationSettings].
  ///
  /// To request permissions, call [requestPermission].
  Future<NotificationSettings> getNotificationSettings() {
    throw UnimplementedError('getNotificationSettings() is not implemented');
  }

  /// Prompts the user for notification permissions.
  ///
  /// On iOS, a dialog is shown requesting the users permission.
  /// If [provisional] is set to `true`, silent notification permissions will be
  /// automatically granted. When notifications are delivered to the device, the
  /// user will be presented with an option to disable notifications, keep receiving
  /// them silently or enable prominent notifications.
  ///
  /// On Android, is it not required to call this method. If called however,
  /// a [NotificationSettings] class will be returned with
  /// [NotificationSettings.authorizationStatus] returning
  /// [AuthorizationStatus.authorized].
  ///
  /// On Web, a popup requesting the users permission is shown using the native
  /// browser API.
  Future<NotificationSettings> requestPermission({
    /// Request permission to display alerts. Defaults to `true`.
    ///
    /// iOS only.
    bool alert = true,

    /// Request permission for Siri to automatically read out notification messages over AirPods.
    /// Defaults to `false`.
    ///
    /// iOS only.
    bool announcement = false,

    /// Request permission to update the application badge. Defaults to `true`.
    ///
    /// iOS only.
    bool badge = true,

    /// Request permission to display notifications in a CarPlay environment.
    /// Defaults to `false`.
    ///
    /// iOS only.
    bool carPlay = false,

    /// Request permission for critical alerts. Defaults to `false`.
    ///
    /// Note; your application must explicitly state reasoning for enabling
    /// critical alerts during the App Store review process or your may be
    /// rejected.
    ///
    /// iOS only.
    bool criticalAlert = false,

    /// Request permission to provisionally create non-interrupting notifications.
    /// Defaults to `false`.
    ///
    /// iOS only.
    bool provisional = false,

    /// Request permission to play sounds. Defaults to `true`.
    ///
    /// iOS only.
    bool sound = true,
  }) {
    throw UnimplementedError('requestPermission() is not implemented');
  }

  /// Enable or disable auto-initialization of Firebase Cloud Messaging.
  Future<void> setAutoInitEnabled(bool enabled) async {
    throw UnimplementedError('setAutoInitEnabled() is not implemented');
  }

  /// Sets the presentation options for iOS based notifications when received in
  /// the foreground.
  ///
  /// By default, on iOS devices notification messages are only shown when
  /// the application is in the background or terminated. Calling this method
  /// updates these settings to allow a notification to trigger feedback to the
  /// user.
  ///
  /// Important: The requested permissions and those set by the user take priority
  /// over these settings.
  ///
  /// - [alert] Causes a notification message to display in the foreground, overlaying
  ///   the current application (heads up mode).
  /// - [badge] The application badge count will be updated if the application is
  ///   in the foreground.
  /// - [sound] The device will trigger a sound if the application is in the foreground.
  ///
  /// If all arguments are `false`, a notification message will not be displayed in the
  /// foreground.
  Future<void> setForegroundNotificationPresentationOptions({
    bool alert,
    bool badge,
    bool sound,
  }) {
    throw UnimplementedError(
        'setForegroundNotificationPresentationOptions() is not implemented');
  }

  /// Send a new [RemoteMessage] to the FCM server.
  Future<void> sendMessage({
    String to,
    Map<String, String> data,
    String collapseKey,
    String messageId,
    String messageType,
    int ttl,
  }) {
    throw UnimplementedError('sendMessage() is not implemented');
  }

  /// Subscribe to topic in background.
  ///
  /// [topic] must match the following regular expression:
  /// `[a-zA-Z0-9-_.~%]{1,900}`.
  Future<void> subscribeToTopic(String topic) {
    throw UnimplementedError('subscribeToTopic() is not implemented');
  }

  /// Unsubscribe from topic in background.
  Future<void> unsubscribeFromTopic(String topic) {
    throw UnimplementedError('unsubscribeFromTopic() is not implemented');
  }
}
