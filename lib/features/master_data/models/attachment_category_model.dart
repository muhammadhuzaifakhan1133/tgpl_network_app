class AttachmentCategoryModel {
  final int? id;
  final int categoryId;
  final String name;

  AttachmentCategoryModel({
    this.id,
    required this.categoryId,
    required this.name,
  });

  factory AttachmentCategoryModel.fromApiMap(Map<String, dynamic> map) {
    return AttachmentCategoryModel(
      categoryId: map['Id'],
      name: map['Name'],
    );
  }

  factory AttachmentCategoryModel.fromDatabaseMap(Map<String, dynamic> map) {
    return AttachmentCategoryModel(
      id: map['id'],
      categoryId: map['categoryId'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toDatabaseMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
    };
  }
}