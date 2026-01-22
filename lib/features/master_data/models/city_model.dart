import 'package:tgpl_network/constants/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';

class CityModel {
  final int? id;
  final int cityId;
  final String name;

  CityModel({this.id, required this.cityId, required this.name});

  factory CityModel.fromAPIResponseMap(Map<String, dynamic> map) {
    return CityModel(cityId: map['Id'], name: map['Name']);
  }

  static String get createSQLTableQuery {
    final idType = DatabaseHelper.idType;
    final textType = DatabaseHelper.textType;
    final intType = DatabaseHelper.intType;
    return '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.cityTable} (
      id $idType,
      cityId $intType,
      name $textType
    )
  ''';
  }

  factory CityModel.fromDatabaseMap(Map<String, dynamic> map) {
    return CityModel(id: map['id'], cityId: map['cityId'], name: map['name']);
  }

  Map<String, dynamic> toDatabaseMap() {
    return {'id': id, 'cityId': cityId, 'name': name};
  }
}
