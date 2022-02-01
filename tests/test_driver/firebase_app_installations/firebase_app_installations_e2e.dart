// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:drive/drive.dart';
import '../firebase_default_options.dart';

void setupTests() {
  group(
    'firebase_app_installations',
    () {
      setUpAll(() async {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      });

      test('.getId', () async {
        final id = await FirebaseInstallations.instance.getId();
        expect(id, isNotEmpty);
      });

      test('.delete', () async {
        final id = await FirebaseInstallations.instance.getId();

        // Wait a little so we don't get a delete-pending exception
        await Future.delayed(const Duration(seconds: 8));

        await FirebaseInstallations.instance.delete();

        // Wait a little so we don't get a delete-pending exception
        await Future.delayed(const Duration(seconds: 8));

        final newId = await FirebaseInstallations.instance.getId();
        expect(newId, isNot(equals(id)));
      });

      test('.getToken', () async {
        final token = await FirebaseInstallations.instance.getId();
        expect(token, isNotEmpty);
      });
    },
  );
}
