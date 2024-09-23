part of movies;

class SeedData {
  String name = "seedData";
  SeedData({required this.dataConnect});

  Deserializer<SeedDataData> dataDeserializer = (String json) =>
      SeedDataData.fromJson(jsonDecode(json) as Map<String, dynamic>);

  MutationRef<SeedDataData, void> ref() {
    return dataConnect.mutation(
        this.name, dataDeserializer, emptySerializer, null);
  }

  FirebaseDataConnect dataConnect;
}

class SeedDataTheMatrix {
  late String id;

  SeedDataTheMatrix.fromJson(Map<String, dynamic> json) : id = json['id'] {}

  // TODO(mtewani): Fix up to create a map on the fly
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['id'] = id;

    return json;
  }

  SeedDataTheMatrix({
    required this.id,
  }) {
    // TODO(mtewani): Only show this if there are optional fields.
  }
}

class SeedDataData {
  late SeedDataTheMatrix the_matrix;

  SeedDataData.fromJson(Map<String, dynamic> json)
      : the_matrix = SeedDataTheMatrix.fromJson(json['the_matrix']) {}

  // TODO(mtewani): Fix up to create a map on the fly
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['the_matrix'] = the_matrix.toJson();

    return json;
  }

  SeedDataData({
    required this.the_matrix,
  }) {
    // TODO(mtewani): Only show this if there are optional fields.
  }
}
