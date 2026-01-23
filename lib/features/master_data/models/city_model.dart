class CityModel {
  final int? id;
  final int cityId;
  final String name;

  CityModel({this.id, required this.cityId, required this.name});

  factory CityModel.fromAPIResponseMap(Map<String, dynamic> map) {
    return CityModel(cityId: map['Id'], name: map['Name']);
  }

  factory CityModel.fromDatabaseMap(Map<String, dynamic> map) {
    return CityModel(id: map['id'], cityId: map['cityId'], name: map['name']);
  }

  Map<String, dynamic> toDatabaseMap() {
    return {'id': id, 'cityId': cityId, 'name': name};
  }
}
