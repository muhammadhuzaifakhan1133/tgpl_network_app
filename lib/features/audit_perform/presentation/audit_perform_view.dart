import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/features/audit_perform/presentation/audit_perform_controller.dart';
import 'package:tgpl_network/features/audit_perform/presentation/widgets/next_previous_buttons.dart';
import 'package:tgpl_network/features/audit_perform/presentation/widgets/page_title.dart';
import 'package:tgpl_network/features/audit_perform/presentation/widgets/question_card.dart';

class AuditPerformView extends ConsumerWidget {
  const AuditPerformView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auditPerformState = ref.read(auditPerformControllerProvider);
    if (auditPerformState.isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Column(
        children: [
          AuditPerformPageTitle(
            totalPages: auditPerformState.requireValue.pages.length,
          ),
          Consumer(
            builder: (context, ref, _) {
              final currentPageIndex = ref.watch(
                currentAuditPerformPageIndexProvider,
              );
              final pageQuestions = auditPerformState
                  .requireValue
                  .pages[currentPageIndex]
                  .questions;
              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 20.w,
                  ),
                  itemCount: pageQuestions.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final question = pageQuestions[index];
                    return QuestionCard(question: question);
                  },
                ),
              );
            },
          ),
          // next and previous button
          NextPreviousButtons(
            totalPages: auditPerformState.requireValue.pages.length,
          ),
        ],
      ),
    );
  }
}
