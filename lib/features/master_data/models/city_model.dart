class CityModel {
  final int? id;
  final int cityId;
  final String name;

  CityModel({
    this.id,
    required this.cityId,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cityId': cityId,
      'name': name,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'],
      cityId: map['cityId'],
      name: map['name'],
    );
  }
}