// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of firebase.database_interop;

@JS('DataSnapshot')
@staticInterop
@anonymous
abstract class DataSnapshotJsImpl {
  external JSString get key;

  external ReferenceJsImpl get ref;

  external JSAny /* JSString | num | null*/ get priority;

  external JSNumber get size;

  external DataSnapshotJsImpl child(JSString path);

  external JSBoolean exists();

  external dynamic exportVal();

  external JSAny forEach(JSFunction action);

  external dynamic getPriority();

  external JSBoolean hasChild(JSString path);

  external JSBoolean hasChildren();

  external JSObject toJSON();

  external JSAny val();
}
