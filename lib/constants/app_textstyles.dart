import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tgpl_network/constants/app_colors.dart';

class AppTextstyles {
  static const TextStyle neutra500white32 = TextStyle(
                    fontFamily: 'NeutraText',
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  );
  static const TextStyle neutra700black32 = TextStyle(
                    fontFamily: 'NeutraText',
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  );
  static const TextStyle neutra500white22 = TextStyle(
                    fontFamily: 'NeutraText',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  );
  static const TextStyle neutra500white18 = TextStyle(
                    fontFamily: 'NeutraText',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  );
  static TextStyle googleInter700black28 = GoogleFonts.inter(
              fontSize: 28,
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            );

  static TextStyle googleInter400black16 = GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            );

  static TextStyle googleInter400Grey14 = GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.subHeadingColor,
              fontWeight: FontWeight.w400,
            );

  static TextStyle googleJakarta500Grey12 = GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: AppColors.textFieldLabelColor,
              fontWeight: FontWeight.w500,
            );
}