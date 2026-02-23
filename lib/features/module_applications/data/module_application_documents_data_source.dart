import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/module_applications/models/document_model.dart';
import 'package:tgpl_network/constants/app_apis.dart';

class ModuleApplicationDocumentsDataSource {
  final DioClient _dioClient;
  ModuleApplicationDocumentsDataSource(this._dioClient);
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

final moduleApplicationDocumentsDataSourceProvider =
    Provider<ModuleApplicationDocumentsDataSource>((ref) {
      return ModuleApplicationDocumentsDataSource(ref.watch(dioClientProvider));
    });
