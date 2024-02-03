// ignore_for_file: require_trailing_commas
// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

@JS('firebase_core')
library firebase_interop.core.app;

import 'dart:js_interop' as js_interop;

import 'package:js/js.dart';

import 'core_interop.dart';

@js_interop.JS('FirebaseApp')
@js_interop.staticInterop
abstract class AppJsImpl {}

extension AppJsImplExtension on AppJsImpl {
  external js_interop.JSString get name;
  external FirebaseOptions get options;
}
