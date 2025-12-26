import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';

final modulesProvider = Provider<List<ModuleModel>>((ref) {
  return [
    ModuleModel(
      title: "Site Screening",
      count: 545,
      color: AppColors.nextStep1Color,
      icon: AppImages.locationIconSvg,
      subModules: [
        SubModuleModel(title: "Open Applications", count: 45),
        SubModuleModel(title: "Survey & Dealer Profile", count: 45),
        SubModuleModel(title: "Traffic & Trade", count: 45),
      ],
    ),
    ModuleModel(
      title: "Feasibility",
      count: 545,
      color: AppColors.nextStep2Color,
      icon: AppImages.feasibilityIconSvg,
      subModules: [
        SubModuleModel(title: "Feasibility", count: 45),
        SubModuleModel(title: "Negotiations", count: 45),
        SubModuleModel(title: "Feasibility Finalizations", count: 45),
      ],
    ),
    ModuleModel(
      title: "Approvals",
      count: 545,
      color: AppColors.inProcessCountColor,
      icon: AppImages.inauguratedIconSvg,
      subModules: [
        SubModuleModel(title: "MOU Sign Off", count: 45),
        SubModuleModel(title: "Joining Fee", count: 45),
        SubModuleModel(title: "Franchise Agreement", count: 45),
      ],
    ),
    ModuleModel(
      title: "Layouts",
      count: 545,
      color: AppColors.emailUsIconColor,
      icon: AppImages.layoutIconSvg,
      subModules: [
        SubModuleModel(title: "Government Layout", count: 45),
        SubModuleModel(title: "Issuance of Drawings", count: 45),
        SubModuleModel(title: "Topography", count: 45),
        SubModuleModel(title: "Drawings", count: 45),
        SubModuleModel(title: "Capex", count: 45),
      ],
    ),
    ModuleModel(
      title: "Documents",
      count: 545,
      color: AppColors.nextStep1Color,
      icon: AppImages.applyNewStationIconSvg,
      subModules: [
        SubModuleModel(title: "Applied in Explosive", count: 45),
        SubModuleModel(title: "DC NOC", count: 45),
        SubModuleModel(title: "Lease Agreement", count: 45),
      ],
    ),
    ModuleModel(
      title: "Construction",
      count: 545,
      color: AppColors.nextStep2Color,
      icon: AppImages.constructionIconSvg,
      subModules: [SubModuleModel(title: "Construction Activity", count: 45)],
    ),
    ModuleModel(
      title: "Commissioning",
      count: 545,
      color: AppColors.commissioningColor,
      icon: AppImages.commissionIconSvg,
      subModules: [
        SubModuleModel(title: "HOTO", count: 45),
        SubModuleModel(title: "Inaugurations", count: 45),
      ],
    ),
    ModuleModel(
      title: "History",
      count: 545,
      color: AppColors.emailUsIconColor,
      icon: AppImages.historyIconSvg,
      subModules: [
        SubModuleModel(title: "Inaugurated List", count: 45),
        SubModuleModel(title: "Hold By Dealer", count: 45),
        SubModuleModel(title: "Hold By TGPL", count: 45),
        SubModuleModel(title: "Rejected By Dealer", count: 45),
        SubModuleModel(title: "Rejected By TGPL", count: 45),
      ],
    ),
  ];
});
