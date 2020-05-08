// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:firebase/firebase.dart" as web;
import 'package:firebase_database_platform_interface/firebase_database_platform_interface.dart';

/// Builds [EventPlatform] instance form web event instance
EventPlatform fromWebEventToPlatformEvent(web.QueryEvent event) {
  return EventPlatform(
      fromWebSnapshotToPlatformSnapShot(event.snapshot), event.prevChildKey);
}

/// Builds [DataSnapshotPlatform] instance form web snapshot instance
DataSnapshotPlatform fromWebSnapshotToPlatformSnapShot(
    web.DataSnapshot snapshot) {
  return DataSnapshotPlatform(snapshot.key, snapshot.val());
}
