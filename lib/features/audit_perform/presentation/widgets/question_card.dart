import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/audit_perform/models/audit_question.dart';
import 'package:tgpl_network/features/audit_perform/models/question_type.dart';

class QuestionCard extends ConsumerStatefulWidget {
  final AuditQuestion question;
  const QuestionCard({super.key, required this.question});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionCardState();
}

class _QuestionCardState extends ConsumerState<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (widget.question.isRequired ? "* " : "") +
                widget.question.questionText,
            style: AppTextstyles.googleInter400black16,
          ),
          SizedBox(height: 30.h),
          _buildAnswerOptions(),
          SizedBox(height: 30.h),
          _showAttachedImages(),
          SizedBox(height: 20.h),
          _showAttachedNote(),
          SizedBox(height: 20.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _showAttachedNote() {
    return Text(
      "This is a sample note attached to the question. It can be multiple lines long and should be displayed in a way that is easy to read.",
      style: AppTextstyles.googleInter400black16.copyWith(
        fontSize: 14.sp,
        color: AppColors.grey[700],
      ),
    );
  }

  Widget _showAttachedImages() {
    // show sample attached images
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: List.generate(
        7,
        (index) => Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.grey[300],
          ),
          child: Icon(Icons.image, color: AppColors.grey[600]),
        ),
      ),
    );
  }

  Row _buildActionButtons() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // add note action
            _questionCardAction(
              onTap: () {},
              text: "Add Note",
              icon: Icons.post_add_rounded,
            ),
            // add media action
            _questionCardAction(
              onTap: () {},
              text: "Add Media",
              icon: Icons.add_photo_alternate_outlined,
            ),
            // add action action
            _questionCardAction(
              onTap: () {},
              text: "Add Action",
              icon: Icons.add_box_rounded,
            ),
          ],
        );
  }

  Widget _questionCardAction({
    required VoidCallback onTap,
    required String text,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.black),
          SizedBox(width: 5.w),
          Container(
            constraints: BoxConstraints(maxWidth: 80.w),
            child: Text(
              text,
              style: AppTextstyles.googleInter400black16.copyWith(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions() {
    switch (widget.question.questionType) {
      case QuestionType.datetime:
        return _buildOptionForDateTime();
      case QuestionType.location:
        return _buildOptionForLocation();
      case QuestionType.media:
        return _buildOptionForMedia();
      case QuestionType.preparedBy:
        return _buildOptionForPreparedBy();
      case QuestionType.site:
        return _buildOptionForSite();
      case QuestionType.shortText:
        return _buildOptionForShortText();
      case QuestionType.paragraph:
        return _buildOptionForParagraph();
      case QuestionType.multipleChoice:
        return _buildOptionForMultipleChoice();
      case QuestionType.multipleChoiceMultiSelection:
        return _buildOptionForMultipleChoiceMultiSelection();
      case QuestionType.number:
        return _buildOptionForNumber();
      case QuestionType.signature:
        return _buildOptionForSignature();
    }
  }

  Widget _buildOptionForDateTime() {
    return SizedBox.shrink();
  }

  Widget _buildOptionForLocation() {
    return SizedBox.shrink();
  }

  Widget _buildOptionForMedia() {
    return SizedBox.shrink();
  }

  Widget _buildOptionForPreparedBy() {
    return SizedBox.shrink();
  }

  Widget _buildOptionForSite() {
    return SizedBox.shrink();
  }

  Widget _buildOptionForShortText() {
    return CustomTextField(
      hintText: "Enter your answer here",
    );
  }

  Widget _buildOptionForParagraph() {
    return CustomTextField(
      hintText: "Enter your answer here",
      maxLines: 3,
    );
  }

  Widget _buildOptionForMultipleChoice() {
    return SizedBox.shrink();
  }

  Widget _buildOptionForMultipleChoiceMultiSelection() {
    return SizedBox.shrink();
  }

  Widget _buildOptionForNumber() {
    return SizedBox.shrink();
  }

  Widget _buildOptionForSignature() {
    return SizedBox.shrink();
  }

}
