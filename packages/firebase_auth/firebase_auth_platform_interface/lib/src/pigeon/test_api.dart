// Autogenerated from Pigeon (v3.2.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis
// ignore_for_file: avoid_relative_lib_imports
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;
import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'messages.pigeon.dart';

class _TestMultiFactorUserHostApiCodec extends StandardMessageCodec {
  const _TestMultiFactorUserHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PigeonMultiFactorInfo) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is PigeonMultiFactorSession) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is PigeonPhoneMultiFactorAssertion) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return PigeonMultiFactorInfo.decode(readValue(buffer)!);

      case 129:
        return PigeonMultiFactorSession.decode(readValue(buffer)!);

      case 130:
        return PigeonPhoneMultiFactorAssertion.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestMultiFactorUserHostApi {
  static const MessageCodec<Object?> codec = _TestMultiFactorUserHostApiCodec();

  Future<void> enrollPhone(String appName,
      PigeonPhoneMultiFactorAssertion assertion, String? displayName);
  Future<PigeonMultiFactorSession> getSession(String appName);
  Future<void> unenroll(String appName, String? factorUid);
  Future<List<PigeonMultiFactorInfo?>> getEnrolledFactors(String appName);
  static void setup(TestMultiFactorUserHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.MultiFactorUserHostApi.enrollPhone', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.MultiFactorUserHostApi.enrollPhone was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_appName = (args[0] as String?);
          assert(arg_appName != null,
              'Argument for dev.flutter.pigeon.MultiFactorUserHostApi.enrollPhone was null, expected non-null String.');
          final PigeonPhoneMultiFactorAssertion? arg_assertion =
              (args[1] as PigeonPhoneMultiFactorAssertion?);
          assert(arg_assertion != null,
              'Argument for dev.flutter.pigeon.MultiFactorUserHostApi.enrollPhone was null, expected non-null PigeonPhoneMultiFactorAssertion.');
          final String? arg_displayName = (args[2] as String?);
          await api.enrollPhone(arg_appName!, arg_assertion!, arg_displayName);
          return <Object?, Object?>{};
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.MultiFactorUserHostApi.getSession', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.MultiFactorUserHostApi.getSession was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_appName = (args[0] as String?);
          assert(arg_appName != null,
              'Argument for dev.flutter.pigeon.MultiFactorUserHostApi.getSession was null, expected non-null String.');
          final PigeonMultiFactorSession output =
              await api.getSession(arg_appName!);
          return <Object?, Object?>{'result': output};
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.MultiFactorUserHostApi.unenroll', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.MultiFactorUserHostApi.unenroll was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_appName = (args[0] as String?);
          assert(arg_appName != null,
              'Argument for dev.flutter.pigeon.MultiFactorUserHostApi.unenroll was null, expected non-null String.');
          final String? arg_factorUid = (args[1] as String?);
          await api.unenroll(arg_appName!, arg_factorUid);
          return <Object?, Object?>{};
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.MultiFactorUserHostApi.getEnrolledFactors', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.MultiFactorUserHostApi.getEnrolledFactors was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_appName = (args[0] as String?);
          assert(arg_appName != null,
              'Argument for dev.flutter.pigeon.MultiFactorUserHostApi.getEnrolledFactors was null, expected non-null String.');
          final List<PigeonMultiFactorInfo?> output =
              await api.getEnrolledFactors(arg_appName!);
          return <Object?, Object?>{'result': output};
        });
      }
    }
  }
}

class _TestMultiFactoResolverHostApiCodec extends StandardMessageCodec {
  const _TestMultiFactoResolverHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PigeonMultiFactorInfo) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is PigeonMultiFactorSession) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is PigeonPhoneMultiFactorAssertion) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return PigeonMultiFactorInfo.decode(readValue(buffer)!);

      case 129:
        return PigeonMultiFactorSession.decode(readValue(buffer)!);

      case 130:
        return PigeonPhoneMultiFactorAssertion.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestMultiFactoResolverHostApi {
  static const MessageCodec<Object?> codec =
      _TestMultiFactoResolverHostApiCodec();

  Future<Map<String?, Object?>> resolveSignIn(
      String resolverId, PigeonPhoneMultiFactorAssertion assertion);
  static void setup(TestMultiFactoResolverHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.MultiFactoResolverHostApi.resolveSignIn', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.MultiFactoResolverHostApi.resolveSignIn was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_resolverId = (args[0] as String?);
          assert(arg_resolverId != null,
              'Argument for dev.flutter.pigeon.MultiFactoResolverHostApi.resolveSignIn was null, expected non-null String.');
          final PigeonPhoneMultiFactorAssertion? arg_assertion =
              (args[1] as PigeonPhoneMultiFactorAssertion?);
          assert(arg_assertion != null,
              'Argument for dev.flutter.pigeon.MultiFactoResolverHostApi.resolveSignIn was null, expected non-null PigeonPhoneMultiFactorAssertion.');
          final Map<String?, Object?> output =
              await api.resolveSignIn(arg_resolverId!, arg_assertion!);
          return <Object?, Object?>{'result': output};
        });
      }
    }
  }
}
