// Copyright 2020, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:firebase_messaging_platform_interface/firebase_messaging_platform_interface.dart';

class RemoteMessage {
  const RemoteMessage(
      {this.senderId,
      this.category,
      this.collapseKey,
      this.contentAvailable,
      this.data,
      this.from,
      this.messageId,
      this.messageType,
      this.mutableContent,
      this.notification,
      this.sentTime,
      this.threadId,
      this.ttl});

  factory RemoteMessage.fromMap(Map<String, dynamic> map) {
    return RemoteMessage(
      senderId: map['senderId'],
      category: map['category'],
      collapseKey: map['collapseKey'],
      contentAvailable: map['contentAvailable'] ?? false,
      data: map['data'] == null
          ? <String, dynamic>{}
          : Map<String, dynamic>.from(map['data']),
      from: map['from'],
      messageId: map['messageId'],
      mutableContent: map['mutableContent'] ?? false,
      notification: map['notification'] == null
          ? null
          : Notification.fromMap(
              Map<String, dynamic>.from(map['notification'])),
      sentTime: map['sentTime'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['sentTime']),
      threadId: map['threadId'],
      ttl: map['ttl'],
    );
  }

  /// The ID of the upstream sender location.
  final String senderId;

  /// The iOS category this notification is assigned to.
  final String category;

  /// The collapse key a message was sent with. Used to override existing messages with the same key.
  final String collapseKey;

  /// Whether the iOS APNs message was configured as a background update notification.
  final bool contentAvailable;

  /// Any additional data sent with the message.
  final Map<String, String> data;

  /// The topic name or message identifier.
  final String from;

  /// A unique ID assigned to every message.
  final String messageId;

  /// The message type of the message.
  final String messageType;

  /// Whether the iOS APNs `mutable-content` property on the message was set
  /// allowing the app to modify the notification via app extensions.
  final bool mutableContent;

  /// Additional Notification data sent with the message
  final Notification notification;

  /// The time the message was sent, represented as a [DateTime].
  final DateTime sentTime;

  /// An iOS app specific identifier used for notification grouping.
  final String threadId;

  /// The time to live for the message in seconds.
  final int ttl;
}
