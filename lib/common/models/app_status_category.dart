import 'dart:ui';
import 'package:tgpl_network/constants/app_colors.dart';

class AppStatusCategory {
  final AppStatusCategoryType type;
  final List<int> statusIds;

  AppStatusCategory({
    required this.type,
    required this.statusIds,
  });

  static Color allColor = AppColors.grey;
  static Color inProcessColor = AppColors.nextStep1Color;
  static Color inauguratedColor = AppColors.nextStep2Color;
  static Color rejectedByTGPLColor = AppColors.emailUsIconColor;
  static Color holdByDealerColor = AppColors.nextStep3Color;
  static Color holdByTGPLColor = AppColors.nextStep3Color;
  static Color rejectedByDealerColor = AppColors.emailUsIconColor;

  Color get color {
    switch (type) {
      case AppStatusCategoryType.all:
        return allColor;
      case AppStatusCategoryType.inProcess:
        return inProcessColor;
      case AppStatusCategoryType.inaugurated:
        return inauguratedColor;
      case AppStatusCategoryType.rejectedByTGPL:
        return rejectedByTGPLColor;
      case AppStatusCategoryType.holdByDealer:
        return holdByDealerColor;
      case AppStatusCategoryType.holdByTGPL:
        return holdByTGPLColor;
      case AppStatusCategoryType.rejectedByDealer:
        return rejectedByDealerColor;
    }
  }

  static Color getColorForStatusId(int statusId) {
    if (statusId < 13) {
      return inProcessColor;
    } else if (statusId == 13) {
      return inauguratedColor;
    } else if (statusId == 14) {
      return rejectedByTGPLColor;
    } else if (statusId == 15) {
      return holdByDealerColor;
    } else if (statusId == 16) {
      return holdByTGPLColor;
    } else if (statusId == 17) {
      return rejectedByDealerColor;
    } else {
      return allColor; // Default color for unknown status
    }
  }
}

enum AppStatusCategoryType {
  all,
  inProcess,
  inaugurated,
  rejectedByTGPL,
  holdByDealer,
  holdByTGPL,
  rejectedByDealer,
}

extension AppStatusCategoryTypeExtension on AppStatusCategoryType {
  String get displayName {
    switch (this) {
      case AppStatusCategoryType.all:
        return "All";
      case AppStatusCategoryType.inProcess:
        return "In Process";
      case AppStatusCategoryType.inaugurated:
        return "Inaugurated";
      case AppStatusCategoryType.rejectedByTGPL:
        return "Rejected by TGPL";
      case AppStatusCategoryType.holdByDealer:
        return "Hold by Dealer";
      case AppStatusCategoryType.holdByTGPL:
        return "Hold by TGPL";
      case AppStatusCategoryType.rejectedByDealer:
        return "Rejected by Dealer";
    }
  }
}