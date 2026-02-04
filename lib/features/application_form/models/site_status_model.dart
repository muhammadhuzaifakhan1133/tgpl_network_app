class SiteStatusModel {
  static const String alias = 'site';

   final int? id;
  final int siteStatusId;
  final String name;

  SiteStatusModel({this.id, required this.siteStatusId, required this.name});

  factory SiteStatusModel.fromAPIResponseMap(Map<String, dynamic> map) {
    return SiteStatusModel(siteStatusId: map['Id'], name: map['Name']);
  }

  factory SiteStatusModel.fromDatabaseMap(Map<String, dynamic> map) {
    return SiteStatusModel(id: map['id'], siteStatusId: map['siteStatusId'], name: map['name']);
  }

  Map<String, dynamic> toDatabaseMap() {
    return {'id': id, 'siteStatusId': siteStatusId, 'name': name};
  }
}