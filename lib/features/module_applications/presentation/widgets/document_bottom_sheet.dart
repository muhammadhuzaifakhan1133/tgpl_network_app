import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:tgpl_network/common/providers/user_provider.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
import 'package:tgpl_network/common/widgets/error_widget.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/providers/attachment_categories_provider.dart';
import 'package:tgpl_network/features/module_applications/models/document_model.dart';
import 'package:tgpl_network/features/module_applications/presentation/application_document_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

Future<dynamic> documentBottomSheet({
  required BuildContext context,
  required ApplicationModel application,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.85,
      initialChildSize: 0.95,
      builder: (context, scrollController) =>
          _DocumentBottomSheetContent(application: application),
    ),
  );
}

class _DocumentBottomSheetContent extends ConsumerStatefulWidget {
  final ApplicationModel application;
  const _DocumentBottomSheetContent({required this.application});

  @override
  ConsumerState<_DocumentBottomSheetContent> createState() =>
      _DocumentBottomSheetContentState();
}

class _DocumentBottomSheetContentState
    extends ConsumerState<_DocumentBottomSheetContent> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();

  String get _applicationId =>
      widget.application.applicationId?.toString() ?? "";

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 8.h),
          Divider(color: AppColors.lightGrey),
          SizedBox(height: 8.h),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _UploadSection(
                  applicationId: _applicationId,
                  formKey: _formKey,
                  titleController: _titleController,
                  detailController: _detailController,
                ),
                SizedBox(height: 8.h),
                Divider(color: AppColors.lightGrey),
                SizedBox(height: 8.h),
                _DocumentListSection(applicationId: _applicationId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Documents (${widget.application.applicationId})",
          style: AppTextstyles.googleInter700black28.copyWith(
            fontSize: 24.sp,
            color: AppColors.black2Color,
          ),
        ),
        actionContainer(
          icon: AppImages.crossIconSvg,
          onTap: () => ref.read(goRouterProvider).pop(),
        ),
      ],
    );
  }
}

// ─── Upload Section ───────────────────────────────────────────────────────────

class _UploadSection extends ConsumerWidget {
  final String applicationId;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController detailController;

  const _UploadSection({
    required this.applicationId,
    required this.formKey,
    required this.titleController,
    required this.detailController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for upload result
    ref.listen(applicationDocumentControllerProvider(applicationId), (
      previous,
      next,
    ) {
      if (previous?.uploadSuccess == next.uploadSuccess) return;

      if (next.uploadSuccess == true) {
        // Clear text controllers
        titleController.clear();
        detailController.clear();
      } else if (next.uploadSuccess == false) {
        showSnackBar(
          context,
          next.uploadErrorMessage ?? 'Upload failed. Please try again.',
          bgColor: AppColors.emailUsIconColor,
        );
      }
    });
    final state = ref.watch(
      applicationDocumentControllerProvider(applicationId),
    );
    final controller = ref.read(
      applicationDocumentControllerProvider(applicationId).notifier,
    );
    final user = ref.watch(userProvider).value;

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SectionHeader(
            icon: AppImages.uploadIconSvg,
            iconColor: AppColors.nextStep1Color,
            title: "Upload New Document",
          ),
          SizedBox(height: 16.h),
          _DocumentTypeDropdown(applicationId: applicationId),
          SizedBox(height: 8.h),
          CustomTextField(
            hintText: "Document Title",
            showClearButton: true,
            controller: titleController,
            validator: (v) => v.validate(),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            hintText: "Document Detail",
            multiline: true,
            controller: detailController,
            maxLines: 3,
            showClearButton: true,
            validator: (v) => v.validate(),
          ),
          SizedBox(height: 8.h),
          _FilePicker(applicationId: applicationId),
          SizedBox(height: 8.h),
          Text(
            "Supported formats: PDF, DOC, DOCX, JPG, PNG",
            style: AppTextstyles.googleInter400black16.copyWith(
              color: AppColors.subHeadingColor,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 8.h),
          if (state.isUploading) ...[
            LinearProgressIndicator(
              value: state.uploadProgress > 0 ? state.uploadProgress : null,
              color: AppColors.nextStep1Color,
            ),
            SizedBox(height: 4.h),
            Text(
              'Uploading... ${(state.uploadProgress * 100).toInt()}%',
              style: AppTextstyles.googleInter400Grey14,
            ),
            SizedBox(height: 8.h),
          ],
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: (state.pickedFile != null && !state.isUploading)
                      ? () {
                          if (formKey.currentState?.validate() ?? false) {
                            controller.uploadDocument(
                              title: titleController.text,
                              detail: detailController.text,
                              userName: user?.userName ?? '',
                            );
                          }
                        }
                      : null,
                  text: state.isUploading ? "Uploading..." : "Upload Document",
                  backgroundColor:
                      (state.pickedFile != null && !state.isUploading)
                      ? AppColors.nextStep1Color
                      : AppColors.inactiveStatusColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocumentTypeDropdown extends ConsumerWidget {
  final String applicationId;
  const _DocumentTypeDropdown({required this.applicationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(
      applicationDocumentControllerProvider(
        applicationId,
      ).select((state) => state.selectedDocumentType),
    );
    final controller = ref.read(
      applicationDocumentControllerProvider(applicationId).notifier,
    );

    return SmartCustomDropDownWithTitle(
      hintText: "Select Document Type",
      title: "",
      asyncProvider: attachmentCategoriesProvider,
      itemsBuilder: (data) => data,
      displayString: (item) => item.name,
      onChanged: (value) {
        if (value != null) controller.onDocumentTypeChange(value);
      },
      selectedItem: selectedType,
    );
  }
}

class _FilePicker extends ConsumerWidget {
  final String applicationId;
  const _FilePicker({required this.applicationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileName = ref.watch(
      applicationDocumentControllerProvider(
        applicationId,
      ).select((s) => s.fileName),
    );
    final controller = ref.read(
      applicationDocumentControllerProvider(applicationId).notifier,
    );

    return GestureDetector(
      onTap: controller.pickFile,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Center(
          child: fileName == null
              ? Wrap(
                  children: [
                    SvgPicture.asset(
                      AppImages.uploadIconSvg,
                      color: AppColors.extraInformationColor,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Tap to upload document (Max 15 MB)",
                      style: AppTextstyles.googleInter500LabelColor14,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.insert_drive_file,
                      color: AppColors.nextStep1Color,
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        fileName,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextstyles.googleInter500LabelColor14,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ─── Document List Section ────────────────────────────────────────────────────

class _DocumentListSection extends ConsumerWidget {
  final String applicationId;
  const _DocumentListSection({required this.applicationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(documentAsyncControllerProvider(applicationId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          icon: AppImages.applicationsInactiveSvg,
          iconColor: AppColors.nextStep2Color,
          title: "Document List",
          onTap: null,
        ),
        SizedBox(height: 8.h),
        state.when(
          data: (data) => data.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  separatorBuilder: (_, __) => SizedBox(height: 6.h),
                  itemBuilder: (context, index) =>
                      _DocumentTile(document: data[index]),
                )
              : Center(
                  child: Text(
                    "No documents uploaded yet.",
                    style: AppTextstyles.googleInter400black16.copyWith(
                      color: AppColors.subHeadingColor,
                    ),
                  ),
                ),
          error: (e, s) => errorWidget(e.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}

class _DocumentTile extends ConsumerWidget {
  final DocumentModel document;
  const _DocumentTile({required this.document});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      tileColor: AppColors.lightGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      leading: actionContainer(
        icon: AppImages.applicationsInactiveSvg,
        onTap: () {},
        iconColor: AppColors.nextStep1Color,
        backgroundColor: AppColors.white,
        padding: 12,
      ),
      title: Text(document.documentTitle),
      subtitle: Text(
        "${document.applicationStatusName} • ${document.addDate.formatToDDMMYYY()}",
      ),
      trailing: _DownloadTrailing(document: document),
    );
  }
}

class _DownloadTrailing extends ConsumerWidget {
  final DocumentModel document;
  const _DownloadTrailing({required this.document});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadState = ref.watch(
      downloadDocumentProvider(document.id.toString()),
    );
    final notifier = ref.read(
      downloadDocumentProvider(document.id.toString()).notifier,
    );

    // Show error snackbar as a post-frame callback to avoid build-time setState
    ref.listen(downloadDocumentProvider(document.id.toString()), (
      previous,
      next,
    ) {
      if (next.isSuccess == false && previous?.isSuccess != false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            showSnackBar(
              context,
              next.errorMessage ?? "Download failed",
              bgColor: AppColors.emailUsIconColor,
            );
          }
        });
      }
    });

    if (downloadState.isDownloading) {
      return SizedBox(
        width: 44.w,
        height: 44.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: downloadState.progress > 0 ? downloadState.progress : null,
              strokeWidth: 2.5,
              color: AppColors.nextStep1Color,
            ),
            Text(
              '${(downloadState.progress * 100).toInt()}%',
              style: AppTextstyles.googleInter400Grey14.copyWith(
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      );
    }

    if (downloadState.isSuccess == true &&
        downloadState.downloadedFile != null) {
      return actionContainer(
        icon: "",
        iconData: Icons.open_in_new,
        onTap: () async {
          final result = await OpenFile.open(
            downloadState.downloadedFile!.path,
          );
          if (result.type != ResultType.done && context.mounted) {
            showSnackBar(
              context,
              'Could not open the file.',
              bgColor: AppColors.emailUsIconColor,
            );
          }
        },
        iconColor: AppColors.onlineStatusColor,
        padding: 12,
        backgroundColor: AppColors.onlineStatusColor.withOpacity(0.1),
      );
    }

    return actionContainer(
      icon: AppImages.downloadIconSvg,
      onTap: () =>
          notifier.downloadDocument(document.fullPath, document.fileName),
      iconColor: AppColors.nextStep1Color,
      padding: 12,
      backgroundColor: AppColors.nextStep1Color.withOpacity(0.1),
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final String title;
  final VoidCallback? onTap;

  const _SectionHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        actionContainer(
          leftMargin: 0,
          icon: icon,
          onTap: onTap,
          iconColor: iconColor,
          backgroundColor: iconColor.withOpacity(0.1),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: AppTextstyles.googleInter700black28.copyWith(
            fontSize: 20.sp,
            color: AppColors.black2Color,
          ),
        ),
      ],
    );
  }
}
