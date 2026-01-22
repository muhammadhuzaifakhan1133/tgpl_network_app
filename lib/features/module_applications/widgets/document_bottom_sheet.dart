import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:tgpl_network/common/models/application_model.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/features/master_data/providers/applications_provider.dart';
import 'package:tgpl_network/features/module_applications/application_document_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/get_all_submodules_names.dart';

Future<dynamic> documentBottomSheet({
  required BuildContext context,
  required ApplicationLegacyModel application,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        minChildSize: 0.85,
        initialChildSize: 0.95,
        builder: (context, scrollController) {
          return Consumer(
            builder: (context, ref, _) {
              final controller = ref.read(
                applicationDocumentControllerProvider(application.id).notifier,
              );

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 19, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Documents",
                          style: AppTextstyles.googleInter700black28.copyWith(
                            fontSize: 24,
                            color: AppColors.black2Color,
                          ),
                        ),
                        actionContainer(
                          icon: AppImages.crossIconSvg,
                          onTap: () {
                            ref.read(goRouterProvider).pop();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Divider(color: AppColors.lightGrey),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        // controller: scrollController,
                        children: [
                          Row(
                            children: [
                              actionContainer(
                                leftMargin: 0,
                                icon: AppImages.uploadIconSvg,
                                onTap: () {},
                                iconColor: AppColors.nextStep1Color,
                                backgroundColor: AppColors.nextStep1Color
                                    .withOpacity(0.1),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Upload New Document",
                                style: AppTextstyles.googleInter700black28
                                    .copyWith(
                                      fontSize: 20,
                                      color: AppColors.black2Color,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Consumer(
                            builder: (context, ref, child) {
                              final SubModuleModel? selectedType = ref.watch(
                                applicationDocumentControllerProvider(
                                  application.id,
                                ).select((state) => state.selectedDocumentType),
                              );
                              return CustomDropDown<SubModuleModel>(
                                hintText: "Select Document Type",
                                items: getAllSubmodulesList(ref),
                                displayString: (item) {
                                  return item.title;
                                },
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.onDocumentTypeChange(value);
                                  }
                                },
                                selectedItem: selectedType,
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: "Document Title",
                            showClearButton: true,
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: "Document Detail",
                            multiline: true,
                            maxLines: 3,
                            showClearButton: true,
                          ),
                          const SizedBox(height: 8),
                          Consumer(
                            builder: (context, ref, _) {
                              final state = ref.watch(
                                applicationDocumentControllerProvider(
                                  application.id,
                                ),
                              );
                              final controller = ref.read(
                                applicationDocumentControllerProvider(
                                  application.id,
                                ).notifier,
                              );

                              return GestureDetector(
                                onTap: controller.pickFile,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.lightGrey,
                                    ),
                                  ),
                                  child: Center(
                                    child: state.fileName == null
                                        ? Wrap(
                                            children: [
                                              SvgPicture.asset(
                                                AppImages.uploadIconSvg,
                                                color: AppColors
                                                    .extraInformationColor,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                "Tap to upload document (Max 15 MB)",
                                                style: AppTextstyles
                                                    .googleInter500LabelColor14,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.insert_drive_file,
                                                color: AppColors.nextStep1Color,
                                              ),
                                              const SizedBox(width: 8),
                                              Flexible(
                                                child: Text(
                                                  state.fileName!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextstyles
                                                      .googleInter500LabelColor14,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 8),
                          Text(
                            "Supported formats: PDF, DOC, DOCX, JPG, PNG",
                            style: AppTextstyles.googleInter400black16.copyWith(
                              color: AppColors.subHeadingColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Consumer(
                            builder: (context, ref, _) {
                              final controller = ref.read(
                                applicationDocumentControllerProvider(
                                  "APP-2025-001",
                                ).notifier,
                              );
                              final hasFile = ref.watch(
                                applicationDocumentControllerProvider(
                                  "APP-2025-001",
                                ).select((s) => s.pickedFile != null),
                              );

                              return CustomButton(
                                onPressed: hasFile
                                    ? controller.uploadDocument
                                    : null,
                                text: "Upload Document",
                                backgroundColor: hasFile
                                    ? AppColors.nextStep1Color
                                    : AppColors.inactiveStatusColor,
                              );
                            },
                          ),

                          const SizedBox(height: 8),
                          Divider(color: AppColors.lightGrey),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              actionContainer(
                                leftMargin: 0,
                                icon: AppImages.applicationsInactiveSvg,
                                onTap: () {},
                                iconColor: AppColors.nextStep2Color,
                                backgroundColor: AppColors.nextStep2Color
                                    .withOpacity(0.1),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Document List",
                                style: AppTextstyles.googleInter700black28
                                    .copyWith(
                                      fontSize: 20,
                                      color: AppColors.black2Color,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Consumer(
                            builder: (context, ref, child) {
                              final state = ref.watch(
                                documentAsyncControllerProvider("APP-2025-001"),
                              );
                              return state.when(
                                data: (data) => ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 6),
                                  itemBuilder: (context, index) {
                                    final document = data[index];
                                    return ListTile(
                                      tileColor: AppColors.lightGrey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      leading: actionContainer(
                                        icon: AppImages.applicationsInactiveSvg,
                                        onTap: () {},
                                        iconColor: AppColors.nextStep1Color,
                                        backgroundColor: AppColors.white,
                                        padding: 12,
                                      ),
                                      title: Text(document.title),
                                      subtitle: Text(
                                        "${document.type} • ${document.size} • ${document.uploadedDate}",
                                      ),
                                      trailing: actionContainer(
                                        icon: AppImages.downloadIconSvg,
                                        onTap: () {},
                                        iconColor: AppColors.nextStep1Color,
                                        padding: 12,
                                        backgroundColor: AppColors
                                            .nextStep1Color
                                            .withOpacity(0.1),
                                      ),
                                    );
                                  },
                                ),
                                error: (e, s) => Text("Error: $e"),
                                loading: () => CircularProgressIndicator(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}
