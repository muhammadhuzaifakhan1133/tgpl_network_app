class UserModel {
  final String? id;
  final String? employeeId;
  final String? name;
  final String? email;
  final String? phone;
  final String? region;
  final String? role;


  UserModel({
    this.id,
    this.employeeId,
    this.name,
    this.email,
    this.phone,
    this.region,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      employeeId: json['employeeId'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      region: json['region'] as String?,
      role: json['role'] as String?,
    );
  }
}