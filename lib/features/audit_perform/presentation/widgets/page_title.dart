import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/audit_perform/presentation/audit_perform_controller.dart';
import 'package:tgpl_network/features/audit_perform/presentation/widgets/table_of_contents_dialog.dart';
import 'package:tgpl_network/routes/app_router.dart';

class AuditPerformPageTitle extends ConsumerWidget {
  final int totalPages;
  const AuditPerformPageTitle({super.key, required this.totalPages});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auditPerformState = ref
        .read(auditPerformControllerProvider)
        .requireValue;
    return Container(
      constraints: BoxConstraints(minHeight: 80.h),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: IconButton(
              onPressed: () {
                ref.read(goRouterProvider).pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
          ),
          // page title
          Expanded(
            child: InkWell(
              onTap: () async {
                List<String> pageTitles = auditPerformState.pages
                    .map((page) => page.title)
                    .toList();
                final selectedIndex = await tableOfContentsDialog(
                  context,
                  pageTitles,
                );
                if (selectedIndex != null) {
                  ref
                      .read(currentAuditPerformPageIndexProvider.notifier)
                      .goToPage(selectedIndex, pageTitles.length);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // I want the title to take as much line as possible to fit -> means title should be move to next line if it is too long
                      Flexible(
                        child: Consumer(
                          builder: (context, ref, _) {
                            return Text(
                              auditPerformState
                                  .pages[ref.watch(
                                    currentAuditPerformPageIndexProvider,
                                  )]
                                  .title,
                              textAlign: TextAlign.center,
                              style: AppTextstyles.googleInter700black28
                                  .copyWith(fontSize: 15.sp),
                            );
                          },
                        ),
                      ),
                      // dropdown icon
                      Icon(Icons.keyboard_arrow_down, color: AppColors.black),
                    ],
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final currentPageIndex = ref.watch(
                        currentAuditPerformPageIndexProvider,
                      );
                      final currentPage = ref
                          .watch(auditPerformControllerProvider.select((s) => s.requireValue.pages[currentPageIndex]));
                      String scoreText;
                      if (currentPage.totalScoreQuestions == 0) {
                        scoreText = "";
                      } else {
                        final score = currentPage.score;
                        scoreText =
                            "- ${currentPage.totalScoredQuestions}/${currentPage.totalScoreQuestions} - (${((score.$2 / score.$1) * 100).toStringAsFixed(0)}%)";
                      }
                      return Text(
                        "Page ${currentPageIndex + 1}/$totalPages $scoreText",
                        style: AppTextstyles.googleInter400black16.copyWith(
                          fontSize: 13.sp,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // save as draft button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Save as Draft",
                style: AppTextstyles.googleInter400black16.copyWith(
                  color: AppColors.nextStep1Color,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
