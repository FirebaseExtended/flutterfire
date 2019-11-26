// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of firebase_auth;

class GithubAuthProvider {
  static const String providerId = 'github.com';

  static GithubAuthCredential getCredential({@required String token}) {
    return GithubAuthCredential(token: token);
  }
}
