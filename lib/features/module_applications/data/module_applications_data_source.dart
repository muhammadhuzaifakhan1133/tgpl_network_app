import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tgpl_network/features/module_applications/models/document_model.dart';
import 'package:tgpl_network/common/models/logical_operator_enum.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class ModuleApplicationsDataSource {
  final DatabaseHelper _databaseHelper;
  final DioClient _dioClient;
  ModuleApplicationsDataSource(this._databaseHelper, this._dioClient);

  Future<List<ApplicationModel>> getApplicationsForSubModule({
    required String dbSubModuleCondition,
    String? query,
    int page = 1,
    int? pageSize,
    int? userPositionId,
  }) async {
    pageSize ??= ApplicationModel.pageSize;
    final db = await _databaseHelper.database;

    var whereConditions = <String>[];
    var whereArgs = <dynamic>[];

    if (!query.isNullOrEmpty) {
      final filter = FilterSelectionState.fromSearchQuery(query!);
      final whereData = ApplicationModel.getWhereClauseAndArgs(filter);
      whereConditions = whereData.$1;
      whereArgs = whereData.$2;
    }

    Map<int, LogicalOperator> operators = {
      0: LogicalOperator.and,
      -1: LogicalOperator.or,
    };

    if (userPositionId != null && userPositionId == 6) {
      whereConditions.add("sstmRecommendation IS NULL");
      operators[1] = LogicalOperator.and;
    }

    final mainQuery = SelectDbQueries.buildApplicationQuery(
      whereConditions: [dbSubModuleCondition, ...whereConditions],
      orderBy: ApplicationModel.orderBy,
      limit: pageSize,
      offset: (page - 1) * pageSize,
      operator: operators,
    );

    // debugPrint("Executing Query: \n$mainQuery with args: $whereArgs");
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      mainQuery,
      whereArgs.isNotEmpty ? whereArgs : null,
    );

    return maps.map((map) => ApplicationModel.fromDatabaseMap(map)).toList();
  }

  Future<List<DocumentModel>> getApplicationDocuments(
    String applicationId,
  ) async {
    final response = await _dioClient.get(
      AppApis.getApplicationDocumentsEndpoint(applicationId),
    );
    List<DocumentModel> documents = [];
    for (var doc in response.data) {
      documents.add(DocumentModel.fromApiMap(doc));
    }
    return documents;
  }

  Future<bool> uploadDocument({
    required String applicationId,
    required String categoryId,
    required String title,
    required String detail,
    required String userName,
    required File file,
    ProgressCallback? onSendProgress,
  }) async {
    final fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      'CategoryId': categoryId,
      'ApplicationId': applicationId,
      'Title': title,
      'Detail': detail,
      'UserName': userName,
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final response = await _dioClient.post(
      AppApis.uploadDocumentEndpoint, // add this to your AppApis
      data: formData,
      onSendProgress: onSendProgress,
    );

    return response.data['Success'] == true;
  }

  Future<File?> downloadDocument(
    String documentUrl,
    String fileName, {
    ProgressCallback? onReceiveProgress,
  }) async {
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';

    final dio = Dio();
    final decodedUrl = Uri.decodeFull(documentUrl);

    final response = await dio.get(
      decodedUrl,
      onReceiveProgress: onReceiveProgress,
      options: Options(
        responseType: ResponseType.bytes,
        // Accept both 200 and 404 — server sends file bytes with 404
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    debugPrint(
      'Received response with status code ${response.statusCode} for document download from $documentUrl',
    );
    final bytes = response.data as List<int>?;
    debugPrint(
      'Received ${bytes?.length ?? 0} bytes for document download from $documentUrl',
    );
    debugPrint("Bytes: $bytes");
    // Check we actually got file bytes, not an HTML error page
    // HTML error pages start with "<" (ASCII 60)
    if (bytes != null && bytes.isNotEmpty && bytes.first != 60) {
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      debugPrint('File saved to: $filePath (${bytes.length} bytes)');
      return file;
    }

    debugPrint('Response was an HTML error page, not a file.');
    return null;
  }
}

final moduleApplicationsDataSourceProvider =
    Provider<ModuleApplicationsDataSource>((ref) {
      final dioClient = ref.read(dioClientProvider);
      return ModuleApplicationsDataSource(DatabaseHelper.instance, dioClient);
    });
