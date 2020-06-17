// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of firebase_ml;

/// Describes a remote model to be downloaded to the device.
///
/// https://firebase.google.com/docs/reference/android/com/google/
/// firebase/ml/common/modeldownload/FirebaseRemoteModel
abstract class FirebaseRemoteModel {
  final String modelName;

  /// Constructor for [FirebaseRemoteModel] that requires
  /// a model name as an input.
  FirebaseRemoteModel(this.modelName);
}

/// Describes a custom remote model to be downloaded to the device.
///
/// Create a remote model object with the model's name
/// specified by the developer in the cloud console.
///
/// https://firebase.google.com/docs/reference/android/com/google/
/// firebase/ml/custom/FirebaseCustomRemoteModel
class FirebaseCustomRemoteModel extends FirebaseRemoteModel {
  /// Constructor for [FirebaseCustomRemoteModel] that requires
  /// a model name as an input.
  FirebaseCustomRemoteModel(String modelName) : super(modelName);
}
