import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'integration.g.dart';

@JsonSerializable()
class EmptyModel {
  EmptyModel();

  factory EmptyModel.fromJson(Map<String, dynamic> json) =>
      _$EmptyModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyModelToJson(this);
}

@Collection<EmptyModel>('firestore-example-app/test/config')
final emptyModelRef = EmptyModelCollectionReference();

@Collection<ManualJson>('root')
class ManualJson {
  ManualJson(this.value);

  factory ManualJson.fromJson(Map<String, Object?> json) {
    return ManualJson(json['value']! as String);
  }

  final String value;

  Map<String, Object?> toJson() => {'value': value};
}

@Collection<AdvancedJson>('firestore-example-app/test/advanced')
@JsonSerializable()
class AdvancedJson {
  AdvancedJson({this.firstName, this.lastName, this.ignored});

  final String? firstName;

  @JsonKey(name: 'LAST_NAME')
  final String? lastName;

  @JsonKey(ignore: true)
  final String? ignored;
}

// This tests that the generated code compiles
@Collection<_PrivateAdvancedJson>('firestore-example-app/test/private-advanced')
@JsonSerializable()
class _PrivateAdvancedJson {
  _PrivateAdvancedJson({
    this.firstName,
    this.lastName,
    // ignore: unused_element
    this.ignored,
  });

  final String? firstName;

  @JsonKey(name: 'LAST_NAME')
  final String? lastName;

  @JsonKey(ignore: true)
  final String? ignored;
}
