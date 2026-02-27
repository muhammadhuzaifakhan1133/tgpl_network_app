import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/audit_perform/presentation/audit_perform_controller.dart';

class AuditPerformPageTitle extends StatelessWidget {
  const AuditPerformPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Icon(Icons.arrow_back_ios, color: AppColors.black),
          ),
          // page title
          Expanded(
            child: InkWell(
              onTap: () {
                List<String> pageTitles = [
                  "Page 1 Title long long long long long long title",
                  "Page 2 Title",
                  "Page 3 Title",
                  "Page 4 Title",
                  "Page 5 Title",
                  "Page 6 Title",
                  "Page 7 Title",
                  "Page 8 Title",
                  "Page 9 Title",
                ];
                tableOfContentsDialog(context, pageTitles);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // I want the title to take as much line as possible to fit -> means title should be move to next line if it is too long
                      Expanded(
                        child: Text(
                          "Title Page long long long long long long title",
                          textAlign: TextAlign.center,
                          style: AppTextstyles.googleInter700black28.copyWith(
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      // dropdown icon
                      Icon(Icons.keyboard_arrow_down, color: AppColors.black),
                    ],
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final state = ref.watch(auditPerformControllerProvider).requireValue;
                      final currentPageIndex = ref.watch(currentAuditPerformPageIndexProvider);
                      final currentPage = state.pages[currentPageIndex];
                      return Text(
                        "Page ${currentPageIndex + 1}/${state.pages.length} - ${currentPage.totalScoreQuestions}/${currentPage.totalScoredQuestions}",
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
                  color: AppColors.primary,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> tableOfContentsDialog(
    BuildContext context,
    List<String> pageTitles,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Table of Contents"),
          // listview to show page titles with page number
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: pageTitles.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    pageTitles[index],
                    style: AppTextstyles.googleInter700black28.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  onTap: () {
                    // navigate to selected page
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
