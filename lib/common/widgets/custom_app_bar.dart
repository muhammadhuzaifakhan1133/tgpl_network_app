import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/sync_status_provider.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/home_shell/presentation/home_shell_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';

class CustomAppBar extends ConsumerStatefulWidget {
  final String title;
  final Widget? subtitleWidget;
  final String subtitle;
  final bool showBackButton;
  final bool showSearchIcon;
  final bool showFilterIcon;
  final void Function()? onTapFilterIcon;
  final void Function()? onTapBackButton;
  final List<Widget> actions;
  final bool showResyncButton;
  final void Function(String)? onSearchChanged;
  final void Function()? onCrossSearch;
  final void Function()? onCancelSearchField;
  final int countofActiveFilters;
  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitleWidget,
    required this.subtitle,
    this.showBackButton = false,
    this.showSearchIcon = false,
    this.showFilterIcon = false,
    this.onTapFilterIcon,
    this.onTapBackButton,
    this.actions = const <Widget>[],
    this.showResyncButton = false,
    this.onSearchChanged,
    this.onCrossSearch,
    this.onCancelSearchField,
    this.countofActiveFilters = 0,
  });

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  bool isSearchFieldActive = false;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Row(
        children: [
          if (widget.showBackButton)
            actionContainer(
              icon: AppImages.backIconSvg,
              onTap:
                  widget.onTapBackButton ??
                  () {
                    ref.read(goRouterProvider).pop();
                  },
              padding: 12,
            ),
          const SizedBox(width: 12),
          if (!isSearchFieldActive)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextstyles.googleInter700black28.copyWith(
                            fontSize: 20,
                            color: AppColors.black2Color,
                          ),
                        ),
                        widget.subtitleWidget ??
                            Text(
                              widget.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextstyles.googleInter400Grey14
                                  .copyWith(fontSize: 16),
                            ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      if (widget.showSearchIcon)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSearchFieldActive = true;
                            });
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _searchFocusNode.requestFocus();
                            });
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: AppColors.actionContainerColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.search,
                                color: AppColors.subHeadingColor,
                              ),
                            ),
                          ),
                        ),
                      if (widget.showFilterIcon) ...[
                        const SizedBox(width: 8),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: widget.onTapFilterIcon,
                              child: Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.actionContainerColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.filter_alt_outlined,
                                    color: AppColors.subHeadingColor,
                                  ),
                                ),
                              ),
                            ),
                            if (widget.countofActiveFilters > 0)
                              Positioned(
                                right: 4,
                                top: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.emailUsIconColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.white,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    widget.countofActiveFilters.toString(),
                                    style: AppTextstyles.googleInter700black28
                                        .copyWith(
                                          fontSize: 10,
                                          color: AppColors.white,
                                        ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                      if (widget.showResyncButton) ...[
                        Consumer(
                          builder: (context, ref, _) {
                            final syncStatus = ref.watch(syncStatusProvider);
                            return ElevatedButton.icon(
                              onPressed: () {
                                ref
                                    .read(homeShellControllerProvider.notifier)
                                    .getMasterDataAndSaveLocally(
                                      forcefulSync: true,
                                    );
                              },
                              label: const Text("Resync"),
                              icon: syncStatus == SyncStatus.syncing
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        color: AppColors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.refresh, size: 20),
                              style: ElevatedButton.styleFrom(
                                // backgroundColor: AppColors.primary,
                                backgroundColor: AppColors.headerDarkBlueColor,
                                foregroundColor: AppColors.white,
                                textStyle: AppTextstyles.neutra700black32
                                    .copyWith(
                                      fontSize: 16,
                                      color: AppColors.white,
                                    ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                      ...widget.actions,
                    ],
                  ),
                ],
              ),
            ),
          if (isSearchFieldActive)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Search",
                      height: 50,
                      backgroundColor: AppColors.actionContainerColor,
                      focusNode: _searchFocusNode,
                      showClearButton: true,
                      onChanged: widget.onSearchChanged,
                      onClear: widget.onCrossSearch,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      widget.onCancelSearchField?.call();
                      setState(() {
                        isSearchFieldActive = false;
                      });
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
