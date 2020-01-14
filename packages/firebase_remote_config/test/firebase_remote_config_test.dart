// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final int lastFetchTime = 1520618753782;
  Map<String, dynamic> getDefaultInstance() {
    return <String, dynamic>{
      'lastFetchTime': lastFetchTime,
      'lastFetchStatus': 'success',
      'inDebugMode': true,
      'parameters': <String, dynamic>{
        'param1': <String, dynamic>{
          'source': 'static',
          'value': <int>[118, 97, 108, 49], // UTF-8 encoded 'val1'
        },
      },
    };
  }

  group('$RemoteConfig', () {
    final List<MethodCall> log = <MethodCall>[];

    setUp(() async {
      RemoteConfig.channel
          .setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'RemoteConfig#instance':
            return getDefaultInstance();
          default:
            return true;
        }
      });
    });

    test('instance', () async {
      final RemoteConfig remoteConfig = await RemoteConfig.instance;
      expect(
        log,
        <Matcher>[
          isMethodCall('RemoteConfig#instance', arguments: null),
        ],
      );
      expect(remoteConfig.remoteConfigSettings.debugMode, true);
      expect(remoteConfig.lastFetchTime,
          DateTime.fromMillisecondsSinceEpoch(lastFetchTime));
      expect(remoteConfig.lastFetchStatus, LastFetchStatus.values[0]);
    });

    test('doubleInstance', () async {
      final List<Future<RemoteConfig>> futures = <Future<RemoteConfig>>[
        RemoteConfig.instance,
        RemoteConfig.instance,
      ];
      Future.wait(futures).then((List<RemoteConfig> remoteConfigs) {
        // Check that both returned Remote Config instances are the same.
        expect(remoteConfigs[0], remoteConfigs[1]);
      });
    });
  });

  group('$RemoteConfig', () {
    final List<MethodCall> log = <MethodCall>[];

    final int lastFetchTime = 1520618753782;
    RemoteConfig remoteConfig;

    setUp(() async {
      RemoteConfig.channel
          .setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'RemoteConfig#setDefaults':
            return null;
          case 'RemoteConfig#fetch':
            return <String, dynamic>{
              'lastFetchTime': lastFetchTime,
              'lastFetchStatus': 'success',
            };
          case 'RemoteConfig#instance':
            return getDefaultInstance();
          case 'RemoteConfig#activate':
            return <String, dynamic>{
              'parameters': <String, dynamic>{
                'param1': <String, dynamic>{
                  'source': 'remote',
                  'value': <int>[118, 97, 108, 49], // UTF-8 encoded 'val1'
                },
                'param2': <String, dynamic>{
                  'source': 'remote',
                  'value': <int>[49, 50, 51, 52, 53], // UTF-8 encoded '12345'
                },
                'param3': <String, dynamic>{
                  'source': 'default',
                  'value': <int>[51, 46, 49, 52], // UTF-8 encoded '3.14'
                },
                'param4': <String, dynamic>{
                  'source': 'remote',
                  'value': <int>[116, 114, 117, 101], // UTF-8 encoded 'true'
                },
                'param5': <String, dynamic>{
                  'source': 'default',
                  'value': <int>[
                    102,
                    97,
                    108,
                    115,
                    101
                  ], // UTF-8 encoded 'false'
                },
                'param6': <String, dynamic>{'source': 'default', 'value': null}
              },
              'newConfig': true,
            };
          case 'RemoteConfig#setConfigSettings':
            return null;
          default:
            return true;
        }
      });
      remoteConfig = await RemoteConfig.instance;
      log.clear();
    });

    test('setDefaults', () async {
      await remoteConfig.setDefaults(<String, dynamic>{
        'foo': 'bar',
      });
      expect(log, <Matcher>[
        isMethodCall(
          'RemoteConfig#setDefaults',
          arguments: <String, dynamic>{
            'defaults': <String, dynamic>{
              'foo': 'bar',
            },
          },
        ),
      ]);
    });

    test('fetch', () async {
      await remoteConfig.fetch(expiration: const Duration(hours: 1));
      expect(
        log,
        <Matcher>[
          isMethodCall(
            'RemoteConfig#fetch',
            arguments: <String, dynamic>{
              'expiration': 3600,
            },
          ),
        ],
      );
    });

    test('activate', () async {
      final bool newConfig = await remoteConfig.activateFetched();
      expect(
        log,
        <Matcher>[
          isMethodCall(
            'RemoteConfig#activate',
            arguments: null,
          ),
        ],
      );
      expect(newConfig, true);
      expect(remoteConfig.getString('param1'), 'val1');
      expect(remoteConfig.getInt('param2'), 12345);
      expect(remoteConfig.getDouble('param3'), 3.14);
      expect(remoteConfig.getBool('param4'), true);
      expect(remoteConfig.getBool('param5'), false);
      expect(remoteConfig.getInt('param6'), 0);

      remoteConfig.getAll().forEach((String key, RemoteConfigValue value) {
        switch (key) {
          case 'param1':
            expect(value.asString(), 'val1');
            break;
          case 'param2':
            expect(value.asInt(), 12345);
            break;
          case 'param3':
            expect(value.asDouble(), 3.14);
            break;
          case 'param4':
            expect(value.asBool(), true);
            break;
          case 'param5':
            expect(value.asBool(), false);
            break;
          case 'param6':
            expect(value.asInt(), 0);
            break;
          default:
        }
      });

      final Map<String, ValueSource> resultAllSources = remoteConfig
          .getAll()
          .map((String key, RemoteConfigValue value) =>
              MapEntry<String, ValueSource>(key, value.source));
      expect(resultAllSources, <String, ValueSource>{
        'param1': ValueSource.valueRemote,
        'param2': ValueSource.valueRemote,
        'param3': ValueSource.valueDefault,
        'param4': ValueSource.valueRemote,
        'param5': ValueSource.valueDefault,
        'param6': ValueSource.valueDefault,
      });
    });

    test('fallback', () {
      final key = 'not_existing_key';
      // String
      expect(remoteConfig.getString(key, orElse: () => 'result'), 'result');
      expect(remoteConfig.getString(key), RemoteConfig.defaultValueForString);
      // int
      expect(remoteConfig.getInt(key, orElse: () => 111), 111);
      expect(remoteConfig.getInt(key), RemoteConfig.defaultValueForInt);
      // double
      expect(remoteConfig.getDouble(key, orElse: () => 1.23), 1.23);
      expect(remoteConfig.getDouble(key), RemoteConfig.defaultValueForDouble);
      // bool
      expect(remoteConfig.getBool(key, orElse: () => true), true);
      expect(remoteConfig.getBool(key), RemoteConfig.defaultValueForBool);
      // RemoteConfigValue
      final List<int> aSymbol = [97]; // utf8 encoded "a" character
      final fallbackValue = remoteConfig.getValue(key, orElse: () => aSymbol);
      expect(fallbackValue.asString(), 'a');
      expect(fallbackValue.source, ValueSource.valueDefault);

      final defaultValue = remoteConfig.getValue(key);
      expect(defaultValue.asString(), RemoteConfig.defaultValueForString);
      expect(defaultValue.source, ValueSource.valueStatic);
    });

    test('setConfigSettings', () async {
      expect(remoteConfig.remoteConfigSettings.debugMode, true);
      final RemoteConfigSettings remoteConfigSettings =
          RemoteConfigSettings(debugMode: false);
      await remoteConfig.setConfigSettings(remoteConfigSettings);
      expect(
        log,
        <Matcher>[
          isMethodCall(
            'RemoteConfig#setConfigSettings',
            arguments: <String, dynamic>{
              'debugMode': false,
            },
          ),
        ],
      );
      expect(remoteConfig.remoteConfigSettings.debugMode, false);
    });
  });
}
