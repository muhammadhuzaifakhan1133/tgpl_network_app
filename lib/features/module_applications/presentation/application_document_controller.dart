import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/module_applications/models/document_model.dart';
import 'package:tgpl_network/features/master_data/models/attachment_category_model.dart';
import 'package:tgpl_network/features/module_applications/data/module_applications_data_source.dart';

final applicationDocumentControllerProvider = NotifierProvider.family
    .autoDispose<
      ApplicationDocumentController,
      ApplicationDocumentState,
      String
    >((applicationId) {
      return ApplicationDocumentController(applicationId);
    });

class ApplicationDocumentState {
  final AttachmentCategoryModel? selectedDocumentType;
  final File? pickedFile;
  final String? fileName;
  final bool isUploading;
  final double uploadProgress;
  final bool? uploadSuccess;
  final String? uploadErrorMessage;

  ApplicationDocumentState({
    this.selectedDocumentType,
    this.pickedFile,
    this.fileName,
    this.isUploading = false,
    this.uploadProgress = 0.0,
    this.uploadSuccess,
    this.uploadErrorMessage, // add this
  });

  ApplicationDocumentState copyWith({
    AttachmentCategoryModel? selectedDocumentType,
    File? pickedFile,
    String? fileName,
    bool? isUploading,
    double? uploadProgress,
    bool? uploadSuccess,
    String? uploadErrorMessage,
    bool clearFile = false,
    bool clearCategory = false,
  }) {
    return ApplicationDocumentState(
      selectedDocumentType: clearCategory ? null : selectedDocumentType ?? this.selectedDocumentType,
      pickedFile: clearFile ? null : pickedFile ?? this.pickedFile,
      fileName: clearFile ? null : fileName ?? this.fileName,
      isUploading: isUploading ?? this.isUploading,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      uploadSuccess: uploadSuccess ?? this.uploadSuccess,
      uploadErrorMessage: uploadErrorMessage ?? this.uploadErrorMessage,
    );
  }
}

class ApplicationDocumentController extends Notifier<ApplicationDocumentState> {
  String applicationId;
  ApplicationDocumentController(this.applicationId);

  @override
  ApplicationDocumentState build() {
    return ApplicationDocumentState();
  }

  void onDocumentTypeChange(AttachmentCategoryModel newType) {
    state = state.copyWith(selectedDocumentType: newType);
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['pdf', 'jpg', 'png', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      state = state.copyWith(
        pickedFile: file,
        fileName: result.files.single.name,
      );
    }
  }

  Future<void> uploadDocument({
  required String title,
  required String detail,
  required String userName,
}) async {
  if (state.pickedFile == null || state.selectedDocumentType == null) return;

  state = state.copyWith(isUploading: true, uploadProgress: 0.0, uploadSuccess: null);

  try {
    final success = await ref
        .read(moduleApplicationsDataSourceProvider)
        .uploadDocument(
          applicationId: applicationId,
          categoryId: state.selectedDocumentType!.id.toString(),
          title: title,
          detail: detail,
          userName: userName,
          file: state.pickedFile!,
          onSendProgress: (sent, total) {
            if (total != -1) {
              state = state.copyWith(uploadProgress: sent / total);
            }
          },
        );

    if (success) {
      // Clear everything on success
      state = ApplicationDocumentState(uploadSuccess: true);
      ref.invalidate(documentAsyncControllerProvider(applicationId));
    } else {
      state = state.copyWith(
        isUploading: false,
        uploadSuccess: false,
        uploadErrorMessage: 'Upload failed. Please try again.',
      );
    }
  } catch (e) {
    state = state.copyWith(
      isUploading: false,
      uploadSuccess: false,
      uploadErrorMessage: e.toString(),
    );
  }
}
}

final documentAsyncControllerProvider =
    AsyncNotifierProvider.family<
      DocumentAsyncController,
      List<DocumentModel>,
      String
    >((applicationId) {
      return DocumentAsyncController(applicationId);
    });

class DocumentAsyncController extends AsyncNotifier<List<DocumentModel>> {
  final String applicationId;
  DocumentAsyncController(this.applicationId);

  @override
  FutureOr<List<DocumentModel>> build() {
    return getApplicationDocuments();
  }

  Future<List<DocumentModel>> getApplicationDocuments() {
    return ref.read(moduleApplicationsDataSourceProvider).getApplicationDocuments(applicationId);
  }
}

class DownloadDocumentState {
  final bool isDownloading;
  final double progress;
  final File? downloadedFile;
  final bool? isSuccess;
  final String? errorMessage;

  const DownloadDocumentState({
    this.isDownloading = false,
    this.progress = 0.0,
    this.downloadedFile,
    this.isSuccess,
    this.errorMessage,
  });

  DownloadDocumentState copyWith({
    bool? isDownloading,
    double? progress,
    File? downloadedFile,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return DownloadDocumentState(
      isDownloading: isDownloading ?? this.isDownloading,
      progress: progress ?? this.progress,
      downloadedFile: downloadedFile ?? this.downloadedFile,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Add this provider + notifier
final downloadDocumentProvider = NotifierProvider.family<DownloadDocumentNotifier, DownloadDocumentState, String>(
      (documentId) => DownloadDocumentNotifier(documentId),
    );

class DownloadDocumentNotifier extends Notifier<DownloadDocumentState> {
  final String documentId;
  DownloadDocumentNotifier(this.documentId);

  @override
  DownloadDocumentState build() => const DownloadDocumentState();

  Future<void> downloadDocument(String documentUrl, String fileName) async {
    state = const DownloadDocumentState(isDownloading: true, progress: 0.0);

    try {
      final file = await ref
          .read(moduleApplicationsDataSourceProvider)
          .downloadDocument(
            documentUrl,
            fileName,
            onReceiveProgress: (received, total) {
              debugPrint('Download progress for document $documentId: received=$received, total=$total');
              if (total != -1) {
                state = state.copyWith(progress: received / total);
              }
            },
          );
      debugPrint('Download completed: ${file?.path}');
      state = state.copyWith(
        isDownloading: false,
        downloadedFile: file,
        isSuccess: file != null,
        errorMessage: file == null ? 'Download failed' : null,
      );
    } catch (e) {
      debugPrint('Download error for document $documentId: $e');
      state = state.copyWith(
        isDownloading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}