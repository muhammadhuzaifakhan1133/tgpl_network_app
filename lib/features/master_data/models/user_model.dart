class UserModel {
  final int userId;
  final String userName;
  final String fullName;
  final int companyId;
  final String companyDisplayName;
  final int positionId;
  final String email;
  final String contact;
  final String treePath;
  final bool isSuperAdmin;
  final bool hasSurveyFormAccess;
  final bool hasTrafficTradeFormAccess;


   UserModel({
    required this.userId,
    required this.userName,
    required this.fullName,
    required this.companyId,
    required this.companyDisplayName,
    required this.positionId,
    required this.email,
    required this.contact,
    required this.treePath,
    required this.isSuperAdmin,
    required this.hasSurveyFormAccess,
    required this.hasTrafficTradeFormAccess,
  });

  factory UserModel.fromAPIResponseMap(Map<String, dynamic> json) {
    return UserModel(
      userId: json['UserId'] ?? 0,
      userName: json['UserName'] ?? '',
      fullName: json['FullName'] ?? '',
      companyId: json['CompanyId'] ?? 0,
      companyDisplayName: json['CompanyDisplayName'] ?? '',
      positionId: json['PositionId'] ?? 0,
      email: json['Email'] ?? '',
      contact: json['Contact'] ?? '',
      treePath: json['TreePath'] ?? '',
      isSuperAdmin: json['IsSuperAdmin'] ?? false,
      hasSurveyFormAccess: _hasSurveyFormAccess(List<Map<String, dynamic>>.from(json['UserMenu'] ?? [])),
      hasTrafficTradeFormAccess: _hasTrafficTradeFormAccess(List<Map<String, dynamic>>.from(json['UserMenu'] ?? [])),
    );
  }

  static bool _hasSurveyFormAccess(List<Map<String, dynamic>> userMenus) {
    for (var menu in userMenus) {
      if (menu['FormReportName'] == 'list_Survey' &&
          (menu['AccessLevel'] ?? 0) > 2) {
        return true;
      }
    }
    return false;
  }

  static bool _hasTrafficTradeFormAccess(List<Map<String, dynamic>> userMenus) {
    for (var menu in userMenus) {
      if (menu['FormReportName'] == 'list_Surveytrafictrade' &&
          (menu['AccessLevel'] ?? 0) > 2) {
        return true;
      }
    }
    return false;
  }

  Map<String, dynamic> toDatabaseMap() {
    return {
      'userId': userId,
      'userName': userName,
      'fullName': fullName,
      'companyId': companyId,
      'companyDisplayName': companyDisplayName,
      'positionId': positionId,
      'email': email,
      'contact': contact,
      'treePath': treePath,
      'isSuperAdmin': isSuperAdmin ? 1 : 0,
      'hasSurveyFormAccess': hasSurveyFormAccess ? 1 : 0,
      'hasTrafficTradeFormAccess': hasTrafficTradeFormAccess ? 1 : 0,
    };
  }

  factory UserModel.fromDatabaseMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? 0,
      userName: map['userName'] ?? '',
      fullName: map['fullName'] ?? '',
      companyId: map['companyId'] ?? 0,
      companyDisplayName: map['companyDisplayName'] ?? '',
      positionId: map['positionId'] ?? 0,
      email: map['email'] ?? '',
      contact: map['contact'] ?? '',
      treePath: map['treePath'] ?? '',
      isSuperAdmin: (map['isSuperAdmin'] ?? 0) == 1,
      hasSurveyFormAccess: (map['hasSurveyFormAccess'] ?? 0) == 1,
      hasTrafficTradeFormAccess: (map['hasTrafficTradeFormAccess'] ?? 0) == 1,
    );
  }
}