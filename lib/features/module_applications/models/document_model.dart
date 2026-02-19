//  {
    //     "Id": 1061,
    //     "ApplicationId": 2803,
    //     "ApplicationStatusId": 7,
    //     "ApplicationStatusName": "MOU Sign Off",
    //     "DocumentTitle": "MOU document for the project",
    //     "DocumentDetail": "MultipartFile",
    //     "FileName": "MOU document for the project_7_2803_0.gif",
    //     "FileType": "image/gif",
    //     "FullPath": "http://192.168.0.61:8087/DocumentRep/MOU document for the project_7_2803_0.gif",
    //     "CompanyId": 0,
    //     "AddBy": "basit",
    //     "AddDate": "2026-02-18T10:08:41.127",
    //     "ApplicationStatusList": null,
    //     "Success": true,
    //     "Message": "",
    //     "RecordId": 0,
    //     "AccessLevel": 4
    // }

class DocumentModel {
  final int id;
  final int applicationId;
  final int applicationStatusId;
  final String applicationStatusName;
  final String documentTitle;
  final String documentDetail;
  final String fileName;
  final String fileType;
  final String fullPath;
  final int companyId;
  final String addBy;
  final DateTime addDate;
  final dynamic applicationStatusList;
  final bool success;
  final String message;
  final int recordId;
  final int accessLevel;

  DocumentModel({
    required this.id,
    required this.applicationId,
    required this.applicationStatusId,
    required this.applicationStatusName,
    required this.documentTitle,
    required this.documentDetail,
    required this.fileName,
    required this.fileType,
    required this.fullPath,
    required this.companyId,
    required this.addBy,
    required this.addDate,
    this.applicationStatusList,
    required this.success,
    required this.message,
    required this.recordId,
    required this.accessLevel,
  });

  factory DocumentModel.fromApiMap(Map<String, dynamic> map) {
    return DocumentModel(
      id: map['Id'] as int,
      applicationId: map['ApplicationId'] as int,
      applicationStatusId: map['ApplicationStatusId'] as int,
      applicationStatusName: map['ApplicationStatusName'] as String,
      documentTitle: map['DocumentTitle'] as String,
      documentDetail: map['DocumentDetail'] as String,
      fileName: map['FileName'] as String,
      fileType: map['FileType'] as String,
      fullPath: map['FullPath'] as String,
      companyId: map['CompanyId'] as int,
      addBy: map['AddBy'] as String,
      addDate: DateTime.parse(map['AddDate'] as String),
      applicationStatusList: map['ApplicationStatusList'],
      success: map['Success'] as bool,
      message: map['Message'] as String,
      recordId: map['RecordId'] as int,
      accessLevel: map['AccessLevel'] as int,
    );
  }
}