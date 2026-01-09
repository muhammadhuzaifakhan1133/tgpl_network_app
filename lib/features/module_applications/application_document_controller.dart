import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/document_model.dart';

final applicationDocumentControllerProvider = NotifierProvider.family
    .autoDispose<
      ApplicationDocumentController,
      ApplicationDocumentState,
      String
    >((applicationId) {
      return ApplicationDocumentController(applicationId);
    });

class ApplicationDocumentState {
  final String? selectedDocumentType;
  final File? pickedFile;
  final String? fileName;

  ApplicationDocumentState({this.selectedDocumentType, this.pickedFile, this.fileName});

  ApplicationDocumentState copyWith({String? selectedDocumentType, File? pickedFile, String? fileName}) {
    return ApplicationDocumentState(
      selectedDocumentType: selectedDocumentType ?? this.selectedDocumentType,
      pickedFile: pickedFile ?? this.pickedFile,
      fileName: fileName ?? this.fileName,
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

  void onDocumentTypeChange(String newType) {
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

  Future<void> uploadDocument() async {
    if (state.pickedFile == null) return;
    await Future.delayed(const Duration(seconds: 1));
    state =  ApplicationDocumentState();
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

  List<DocumentModel> getApplicationDocuments() {
    final List<DocumentModel> documents = [
      DocumentModel(
        type: "MOU Sign Off",
        title: "MOU",
        size: "2.5 MB",
        uploadedDate: "15 Jan 2025",
      ),
      DocumentModel(
        type: "Joining Fee",
        title: "Joining Fee Receipt",
        size: "1.2 MB",
        uploadedDate: "16 Jan 2025",
      ),
      DocumentModel(
        type: "Drawings",
        title: "Drawing of Site",
        size: "4 MB",
        uploadedDate: "17 Jan 2025",
      ),
    ];
    return documents;
  }
}
