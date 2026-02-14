import 'package:equatable/equatable.dart';

class TmRmModel extends Equatable {
  final String id;
  final String name;

  TmRmModel({
    required this.id,
    required this.name,
  });

  factory TmRmModel.fromApiMap(Map<String, dynamic> map) {
    return TmRmModel(
      id: map['Id'] as String,
      name: map['Name'] as String,
    );
  }

  Map<String, dynamic> toDatabaseTmMap() {
    return {
      'tmId': id,
      'name': name,
    };
  }

  Map<String, dynamic> toDatabaseRmMap() {
    return {
      'rmId': id,
      'name': name,
    };
  }

  factory TmRmModel.fromDatabaseTmMap(Map<String, dynamic> map) {
    return TmRmModel(
      id: map['tmId'] as String,
      name: map['name'] as String,
    );
  }

  factory TmRmModel.fromDatabaseRmMap(Map<String, dynamic> map) {
    return TmRmModel(
      id: map['rmId'] as String,
      name: map['name'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name];
} 