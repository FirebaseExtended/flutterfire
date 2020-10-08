// Copyright 2020, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:firebase_messaging_platform_interface/firebase_messaging_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../method_channel/method_channel_messaging.dart';

/// Defines an interface to work with Messaging on web and mobile
abstract class FirebaseMessagingPlatform extends PlatformInterface {
  /// The [FirebaseApp] this instance was initialized with.
  @protected
  final FirebaseApp appInstance;

  /// Create an instance using [app]
  FirebaseMessagingPlatform({this.appInstance}) : super(token: _token);

  /// Returns the [FirebaseApp] for the current instance.
  FirebaseApp get app {
    if (appInstance == null) {
      return Firebase.app();
    }

    return appInstance;
  }

  static final Object _token = Object();

  /// Create an instance using [app] using the existing implementation
  factory FirebaseMessagingPlatform.instanceFor(
      {FirebaseApp app, Map<dynamic, dynamic> pluginConstants}) {
    return FirebaseMessagingPlatform.instance
        .delegateFor(app: app)
        .setInitialValues(
          isAutoInitEnabled: pluginConstants['AUTO_INIT_ENABLED'],
          initialNotification: pluginConstants['INITIAL_NOTIFICATION'],
        );
  }

  static FirebaseMessagingPlatform _instance;

  /// The current default [FirebaseMessagingPlatform] instance.
  ///
  /// It will always default to [MethodChannelFirebaseMessaging]
  /// if no other implementation was provided.
  static FirebaseMessagingPlatform get instance {
    if (_instance == null) {
      _instance = MethodChannelFirebaseMessaging.instance;
    }
    return _instance;
  }

  /// Sets the [FirebaseMessagingPlatform.instance]
  static set instance(FirebaseMessagingPlatform instance) {
    assert(instance != null);
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  static Stream<RemoteMessage> _onMessageStream;

  /// Returns a Stream that is called when an incoming FCM payload is received whilst
  /// the Flutter instance is in the foreground.
  ///
  /// To handle messages whilst the app is in the background or terminated,
  /// see [onBackgroundMessage].
  static Stream<RemoteMessage> get onMessage {
    return _onMessageStream ??= StreamController<RemoteMessage>().stream;
  }

  static Stream<SentMessage> _onMessageSentStream;

  /// Returns a Stream that is called when a message being sent to FCM (via [sendMessage])
  /// has successfully been sent.
  ///
  /// See [onSendError] to handle sending failures.
  static Stream<SentMessage> get onMessageSent {
    return _onMessageSentStream ??= StreamController<SentMessage>().stream;
  }

  static Stream<RemoteMessage> _onNotificationOpenedAppStream;

  /// Returns a [Stream] that is called when a user presses a notification displayed
  /// via FCM.
  ///
  /// A Stream event will be sent if the app has opened from a background state
  /// (not terminated).
  ///
  /// If your app is opened via a notification whilst the app is terminated,
  /// see [initialNotification].
  static Stream<RemoteMessage> get onNotificationOpenedApp {
    return _onNotificationOpenedAppStream ??=
        StreamController<RemoteMessage>().stream;
  }

  static Stream<void> _onDeletedMessagesStream;

  /// Returns a Stream which is called when the FCM server deletes pending messages.
  ///
  /// This may be due to:
  ///
  /// 1.  Too many messages stored on the FCM server. This can occur when an
  /// app's servers sends many non-collapsible messages to FCM servers while
  /// the device is offline.
  ///
  /// 2. he device hasn't connected in a long time and the app server has recently
  /// (within the last 4 weeks) sent a message to the app on that device.
  static Stream<RemoteMessage> get onDeletedMessages {
    return _onDeletedMessagesStream ??=
        StreamController<RemoteMessage>().stream;
  }

  static RemoteMessageHandler _onBackgroundMessageHandler;

  /// Set a message handler function which is called when the app is in the
  /// background or terminated.
  ///
  /// This provided handler must be a top-level function and cannot be
  /// anonymous otherwise an [ArgumentError] will be thrown.
  static RemoteMessageHandler get onBackgroundMessage {
    return _onBackgroundMessageHandler;
  }

  /// Allows the background message handler to be created and calls the
  /// instance delegate [registerBackgroundMessageHandler] to perform any
  /// platform specific registration logic.
  static set onBackgroundMessage(RemoteMessageHandler handler) {
    _onBackgroundMessageHandler = handler;
    instance.registerBackgroundMessageHandler();
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
    Map<String, dynamic> initialNotification,
  }) {
    throw UnimplementedError('setInitialValues() is not implemented');
  }

  /// Returns whether messaging auto initialization is enabled or disabled for the device.
  bool get isAutoInitEnabled {
    throw UnimplementedError('isAutoInitEnabled is not implemented');
  }

  /// If the application has been opened from a terminated state via a [Notification],
  /// it will be returned, otherwise it will be `null`.
  ///
  /// Once the [Notification] has been consumed, it will be removed and further
  /// calls to [initialNotification] will be `null`.
  ///
  /// This should be used to determine whether specific notification interaction
  /// should open the app with a specific purpose (e.g. opening a chat message,
  /// specific screen etc).
  Notification get initialNotification {
    throw UnimplementedError('initialNotification is not implemented');
  }

  /// Allows delegates to create a background message handler implementation.
  ///
  /// For example, on native platforms this could be to setup an isolate, whereas
  /// on web a service worker can be registered.
  void registerBackgroundMessageHandler() {
    throw UnimplementedError(
        'registerBackgroundMessageHandler() is not implemented');
  }

  /// Removes access to an FCM token previously authorized by it's scope.
  ///
  /// Messages sent by the server to this token will fail.
  Future<void> deleteToken({
    String authorizedEntity,
    String scope,
  }) {
    throw UnimplementedError('deleteToken() is not implemented');
  }

  /// On iOS, it is possible to get the users APNs token. This may be required
  /// if you want to send messages to your iOS devices without using the FCM service.
  Future<String> getAPNSToken() {
    throw UnimplementedError('getAPNSToken() is not implemented');
  }

  /// Returns an FCM token for this device.
  ///
  /// Optionally you can specify a custom authorized entity or scope to tailor
  /// tokens to your own use-case.
  Future<String> getToken({
    String authorizedEntity,
    String scope,
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

  /// On Apple platforms, if your app wants to receive remote messages from FCM
  /// (via APNs), you must explicitly register with APNs if auto-registration
  /// has been disabled or [unregisterDeviceForRemoteMessages] has been called.
  Future<void> registerDeviceForRemoteMessages() {
    throw UnimplementedError(
        'registerDeviceForRemoteMessages() is not implemented');
  }

  /// Unregisters the app from receiving remote notifications.
  Future<void> unregisterDeviceForRemoteMessages() {
    throw UnimplementedError(
        'unregisterDeviceForRemoteMessages() is not implemented');
  }

  /// Send a new message to the FCM server.
  Future<void> sendMessage({
    String senderId,
    Map<String, String> data,
    String collapseKey,
    String messageId,
    String messageType,
    int ttl,
  }) {
    throw UnimplementedError('sendMessage() is not implemented');
  }

  /// Enable or disable auto-initialization of Firebase Cloud Messaging.
  Future<void> setAutoInitEnabled(bool enabled) async {
    throw UnimplementedError('setAutoInitEnabled() is not implemented');
  }

  /// Subscribe to topic in background.
  ///
  /// [topic] must match the following regular expression:
  /// "[a-zA-Z0-9-_.~%]{1,900}".
  Future<void> subscribeToTopic(String topic) {
    throw UnimplementedError('subscribeToTopic() is not implemented');
  }

  /// Unsubscribe from topic in background.
  Future<void> unsubscribeFromTopic(String topic) {
    throw UnimplementedError('unsubscribeFromTopic() is not implemented');
  }

  /// Resets Instance ID and revokes all tokens. In iOS, it also unregisters from remote notifications.
  ///
  /// A new Instance ID is generated asynchronously if Firebase Cloud Messaging auto-init is enabled.
  ///
  /// returns true if the operations executed successfully and false if an error occurred
  Future<bool> deleteInstanceID() async {
    throw UnimplementedError('deleteInstanceID() is not implemented');
  }
}
