// Autogenerated from Pigeon (v3.2.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';

class PigeonMultiFactorSession {
  PigeonMultiFactorSession({
    required this.id,
  });

  String id;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['id'] = id;
    return pigeonMap;
  }

  static PigeonMultiFactorSession decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PigeonMultiFactorSession(
      id: pigeonMap['id']! as String,
    );
  }
}

class PigeonPhoneMultiFactorAssertion {
  PigeonPhoneMultiFactorAssertion({
    required this.verificationId,
    required this.verificationCode,
  });

  String verificationId;
  String verificationCode;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['verificationId'] = verificationId;
    pigeonMap['verificationCode'] = verificationCode;
    return pigeonMap;
  }

  static PigeonPhoneMultiFactorAssertion decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PigeonPhoneMultiFactorAssertion(
      verificationId: pigeonMap['verificationId']! as String,
      verificationCode: pigeonMap['verificationCode']! as String,
    );
  }
}

class PigeonMultiFactorInfo {
  PigeonMultiFactorInfo({
    this.displayName,
    required this.enrollmentTimestamp,
    required this.factorId,
    required this.uid,
    this.phoneNumber,
  });

  String? displayName;
  double enrollmentTimestamp;
  String factorId;
  String uid;
  String? phoneNumber;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['displayName'] = displayName;
    pigeonMap['enrollmentTimestamp'] = enrollmentTimestamp;
    pigeonMap['factorId'] = factorId;
    pigeonMap['uid'] = uid;
    pigeonMap['phoneNumber'] = phoneNumber;
    return pigeonMap;
  }

  static PigeonMultiFactorInfo decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PigeonMultiFactorInfo(
      displayName: pigeonMap['displayName'] as String?,
      enrollmentTimestamp: pigeonMap['enrollmentTimestamp']! as double,
      factorId: pigeonMap['factorId']! as String,
      uid: pigeonMap['uid']! as String,
      phoneNumber: pigeonMap['phoneNumber'] as String?,
    );
  }
}

class _MultiFactorUserHostApiCodec extends StandardMessageCodec {
  const _MultiFactorUserHostApiCodec();
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

class MultiFactorUserHostApi {
  /// Constructor for [MultiFactorUserHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  MultiFactorUserHostApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _MultiFactorUserHostApiCodec();

  Future<void> enrollPhone(
      String arg_appName,
      PigeonPhoneMultiFactorAssertion arg_assertion,
      String? arg_displayName) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MultiFactorUserHostApi.enrollPhone', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap = await channel
            .send(<Object?>[arg_appName, arg_assertion, arg_displayName])
        as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<PigeonMultiFactorSession> getSession(String arg_appName) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MultiFactorUserHostApi.getSession', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_appName]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as PigeonMultiFactorSession?)!;
    }
  }

  Future<void> unenroll(String arg_appName, String? arg_factorUid) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MultiFactorUserHostApi.unenroll', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap = await channel
        .send(<Object?>[arg_appName, arg_factorUid]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<List<PigeonMultiFactorInfo?>> getEnrolledFactors(
      String arg_appName) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MultiFactorUserHostApi.getEnrolledFactors', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_appName]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as List<Object?>?)!
          .cast<PigeonMultiFactorInfo?>();
    }
  }
}

class _MultiFactoResolverHostApiCodec extends StandardMessageCodec {
  const _MultiFactoResolverHostApiCodec();
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

class MultiFactoResolverHostApi {
  /// Constructor for [MultiFactoResolverHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  MultiFactoResolverHostApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _MultiFactoResolverHostApiCodec();

  Future<Map<String?, Object?>> resolveSignIn(String arg_resolverId,
      PigeonPhoneMultiFactorAssertion arg_assertion) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MultiFactoResolverHostApi.resolveSignIn', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_resolverId, arg_assertion])
            as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as Map<Object?, Object?>?)!
          .cast<String?, Object?>();
    }
  }
}

class _GenerateInterfacesCodec extends StandardMessageCodec {
  const _GenerateInterfacesCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PigeonMultiFactorInfo) {
      buffer.putUint8(128);
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

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class GenerateInterfaces {
  /// Constructor for [GenerateInterfaces].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  GenerateInterfaces({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _GenerateInterfacesCodec();

  Future<void> generateInterfaces(PigeonMultiFactorInfo arg_info) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.GenerateInterfaces.generateInterfaces', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_info]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }
}

class _MultiFactoResolverHostApiCodec extends StandardMessageCodec {
  const _MultiFactoResolverHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PigeonMultiFactorInfo) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
    if (value is PigeonMultiFactorSession) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else 
    if (value is PigeonPhoneMultiFactorAssertion) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else 
{
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

class MultiFactoResolverHostApi {
  /// Constructor for [MultiFactoResolverHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  MultiFactoResolverHostApi({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _MultiFactoResolverHostApiCodec();

  Future<Map<String?, Object?>> resolveSignIn(String arg_resolverId, PigeonPhoneMultiFactorAssertion arg_assertion) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MultiFactoResolverHostApi.resolveSignIn', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_resolverId, arg_assertion]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as Map<Object?, Object?>?)!.cast<String?, Object?>();
    }
  }
}

class _GenerateInterfacesCodec extends StandardMessageCodec {
  const _GenerateInterfacesCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PigeonMultiFactorInfo) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return PigeonMultiFactorInfo.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}

class GenerateInterfaces {
  /// Constructor for [GenerateInterfaces].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  GenerateInterfaces({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _GenerateInterfacesCodec();

  Future<void> generateInterfaces(PigeonMultiFactorInfo arg_info) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.GenerateInterfaces.generateInterfaces', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_info]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }
}
