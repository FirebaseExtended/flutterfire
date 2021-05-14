// @dart = 2.9

// Copyright 2020, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'package:drive/drive.dart' as drive;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'instance_e2e.dart';
import 'list_result_e2e.dart';
import 'reference_e2e.dart';
import 'task_e2e.dart';
import 'test_utils.dart';

// Requires that an emulator is running locally
// `melos run firebase:emulator`
bool useEmulator = true;

void testsMain() {
  setUpAll(() async {
    await Firebase.initializeApp();
    if (useEmulator) {
      await FirebaseStorage.instance
          .useEmulator(host: testEmulatorHost, port: testEmulatorPort);
    }
  });

  runInstanceTests();
  runListResultTests();
  runReferenceTests();
  runTaskTests();
}

void main() => drive.main(testsMain);
