// Copyright 2019, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'firebase_core/firebase_core_e2e_test.dart' as firebase_core;
import 'firebase_crashlytics/firebase_crashlytics_e2e_test.dart'
    as firebase_crashlytics;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterFire', () {
    firebase_core.main();
    firebase_crashlytics.main();
  });
}
