// Copyright 2019, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'firebase_app_installations/firebase_app_installations_e2e_test.dart'
    as firebase_app_installations;
import 'firebase_core/firebase_core_e2e_test.dart' as firebase_core;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterFire', () {
    firebase_app_installations.main();
    firebase_core.main();
  });
}
