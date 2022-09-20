import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

export 'annotation.dart';
export 'src/firestore_builder.dart' show FirestoreBuilder;
export 'src/firestore_reference.dart'
    show
        FirestoreCollectionReference,
        FirestoreDocumentChange,
        FirestoreDocumentReference,
        FirestoreDocumentSnapshot,
        FirestoreListenable,
        FirestoreQueryDocumentSnapshot,
        FirestoreQuerySnapshot,
        FirestoreReference,
        QueryReference,
        $QueryCursor;

/// A wrapper over [Map] to inject the document ID in a [Map], without having
/// to clone the [Map].
// ignore: invalid_internal_annotation, used by the code-generator and only it
@internal
class $JsonMapWithId extends MapView<String, Object?> {
  $JsonMapWithId(Map<String, Object?> map, this._id, this._idKey) : super(map);

  final String _id;
  final String _idKey;

  @override
  Object? operator [](Object? key) {
    if (key == _idKey) return _id;
    return super[key];
  }

  @override
  void operator []=(String key, Object? value) {
    if (key == _idKey) {
      throw UnsupportedError('Cannot modify the $_idKey');
    }

    super[key] = value;
  }
}

/// The list of all [JsonConverter]s that cloud_firestore_odm offers.
///
/// This list is meant to be passed to [JsonSerializable] as followed:
///
/// ```dart
/// @JsonSerializable(converters: firestoreJsonConverters)
/// ```
const List<JsonConverter<Object?, Object?>> firestoreJsonConverters = [
  FirestoreDateTimeConverter(),
  FirestoreTimestampConverter(),
  FirestoreGeoPointConverter(),
  FirestoreDocumentReferenceConverter(),
];

/// A [JsonConverter] that adds support for [Timestamp] objects within ODM models.
class FirestoreTimestampConverter extends JsonConverter<Timestamp, Timestamp> {
  const FirestoreTimestampConverter();
  @override
  Timestamp fromJson(Timestamp json) => json;

  @override
  Timestamp toJson(Timestamp object) => object;
}

/// A [JsonConverter] that adds support for [GeoPoint] objects within ODM models.
class FirestoreGeoPointConverter extends JsonConverter<GeoPoint, GeoPoint> {
  const FirestoreGeoPointConverter();
  @override
  GeoPoint fromJson(GeoPoint json) => json;

  @override
  GeoPoint toJson(GeoPoint object) => object;
}

/// A [JsonConverter] that adds support for [DateTime] objects within ODM models.
class FirestoreDateTimeConverter extends JsonConverter<DateTime, Timestamp> {
  const FirestoreDateTimeConverter();
  @override
  DateTime fromJson(Timestamp json) => json.toDate();

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}

/// A [JsonConverter] that adds support for [DocumentReference] objects within
/// ODM models.
///
/// The document reference must receive a `Map<String, Object?>` as generic
/// argument. References coming from `withConverter` are not supported.
class FirestoreDocumentReferenceConverter extends JsonConverter<
    DocumentReference<Map<String, dynamic>>,
    DocumentReference<Map<String, dynamic>>> {
  const FirestoreDocumentReferenceConverter();

  @override
  DocumentReference<Map<String, dynamic>> fromJson(
    DocumentReference<Map<String, dynamic>> json,
  ) {
    return json;
  }

  @override
  DocumentReference<Map<String, dynamic>> toJson(
    DocumentReference<Map<String, dynamic>> object,
  ) {
    return object;
  }
}
