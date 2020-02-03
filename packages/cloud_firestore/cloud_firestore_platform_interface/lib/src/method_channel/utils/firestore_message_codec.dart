// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:convert';

import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore_platform_interface/src/internal/field_path_type.dart';

/// The codec utilized to encode data back and forth between
/// the Dart application and the native platform.
class FirestoreMessageCodec extends StandardMessageCodec {
  /// Constructor.
  const FirestoreMessageCodec();

  static const int _kDateTime = 128;
  static const int _kGeoPoint = 129;
  static const int _kDocumentReference = 130;
  static const int _kBlob = 131;
  static const int _kArrayUnion = 132;
  static const int _kArrayRemove = 133;
  static const int _kDelete = 134;
  static const int _kServerTimestamp = 135;
  static const int _kTimestamp = 136;
  static const int _kIncrementDouble = 137;
  static const int _kIncrementInteger = 138;
  static const int _kDocumentId = 139;

  static const Map<FieldValueType, int> _kFieldValueCodes =
      <FieldValueType, int>{
    FieldValueType.arrayUnion: _kArrayUnion,
    FieldValueType.arrayRemove: _kArrayRemove,
    FieldValueType.delete: _kDelete,
    FieldValueType.serverTimestamp: _kServerTimestamp,
    FieldValueType.incrementDouble: _kIncrementDouble,
    FieldValueType.incrementInteger: _kIncrementInteger,
  };

  static const Map<FieldPathType, int> _kFieldPathCodes = <FieldPathType, int>{
    FieldPathType.documentId: _kDocumentId,
  };

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is DateTime) {
      buffer.putUint8(_kDateTime);
      buffer.putInt64(value.millisecondsSinceEpoch);
    } else if (value is Timestamp) {
      buffer.putUint8(_kTimestamp);
      buffer.putInt64(value.seconds);
      buffer.putInt32(value.nanoseconds);
    } else if (value is GeoPoint) {
      buffer.putUint8(_kGeoPoint);
      buffer.putFloat64(value.latitude);
      buffer.putFloat64(value.longitude);
    } else if (value is DocumentReferencePlatform) {
      buffer.putUint8(_kDocumentReference);
      final List<int> appName = utf8.encoder.convert(value.firestore.app.name);
      writeSize(buffer, appName.length);
      buffer.putUint8List(appName);
      final List<int> bytes = utf8.encoder.convert(value.path);
      writeSize(buffer, bytes.length);
      buffer.putUint8List(bytes);
    } else if (value is Blob) {
      buffer.putUint8(_kBlob);
      writeSize(buffer, value.bytes.length);
      buffer.putUint8List(value.bytes);
    } else if (value is FieldValuePlatform) {
      final int code = _kFieldValueCodes[value.type];
      assert(code != null);
      buffer.putUint8(code);
      if (value.value != null) writeValue(buffer, value.value);
    } else if (value is FieldPath) {
      final int code = _kFieldPathCodes[value.type];
      assert(code != null);
      buffer.putUint8(code);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case _kDateTime:
        return DateTime.fromMillisecondsSinceEpoch(buffer.getInt64());
      case _kTimestamp:
        return Timestamp(buffer.getInt64(), buffer.getInt32());
      case _kGeoPoint:
        return GeoPoint(buffer.getFloat64(), buffer.getFloat64());
      case _kDocumentReference:
        final int appNameLength = readSize(buffer);
        final String appName =
            utf8.decoder.convert(buffer.getUint8List(appNameLength));
        final FirebaseApp app = FirebaseApp(name: appName);
        final FirestorePlatform firestore =
            FirestorePlatform.instanceFor(app: app);
        final int pathLength = readSize(buffer);
        final String path =
            utf8.decoder.convert(buffer.getUint8List(pathLength));
        return firestore.document(path);
      case _kBlob:
        final int length = readSize(buffer);
        final List<int> bytes = buffer.getUint8List(length);
        return Blob(bytes);
      case _kArrayUnion:
        final List<dynamic> value = readValue(buffer);
        return FieldValueFactoryPlatform.instance.arrayUnion(value);
      case _kArrayRemove:
        final List<dynamic> value = readValue(buffer);
        return FieldValueFactoryPlatform.instance.arrayRemove(value);
      case _kDelete:
        return FieldValueFactoryPlatform.instance.delete();
      case _kServerTimestamp:
        return FieldValueFactoryPlatform.instance.serverTimestamp();
      case _kIncrementDouble:
        final double value = readValue(buffer);
        return FieldValueFactoryPlatform.instance.increment(value);
      case _kIncrementInteger:
        final int value = readValue(buffer);
        return FieldValueFactoryPlatform.instance.increment(value);
      case _kDocumentId:
        return FieldPath.documentId;
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
