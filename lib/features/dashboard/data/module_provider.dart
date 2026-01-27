import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/core/database/modules_db_conditions.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';

final modulesProvider = Provider<List<ModuleModel>>((ref) {
  final dashboardData = ref
      .watch(dashboardAsyncControllerProvider)
      .requireValue;
  return [
    ModuleModel(
      title: "Site Screening",
      count: dashboardData.counts.siteScreening,
      color: AppColors.nextStep1Color,
      icon: AppImages.locationIconSvg,
      subModules: [
        SubModuleModel(
          title: "Open Applications",
          count: dashboardData.counts.openApplications,
          moduleName: "Site Screening",
          moduleColor: AppColors.nextStep1Color,
          moduleIcon: AppImages.locationIconSvg,
          dbCondition: ModulesDbConditions.siteScreeningOpenApplications,
        ),
        SubModuleModel(
          title: "Survey & Dealer Profile",
          count: dashboardData.counts.surveyAndDealerProfile,
          moduleName: "Site Screening",
          moduleColor: AppColors.nextStep1Color,
          moduleIcon: AppImages.locationIconSvg,
          dbCondition: ModulesDbConditions.siteScreeningSurveyAndDealerProfile,
        ),
        SubModuleModel(
          title: "Traffic & Trade",
          count: dashboardData.counts.trafficAndTrade,
          moduleName: "Site Screening",
          moduleColor: AppColors.nextStep1Color,
          moduleIcon: AppImages.locationIconSvg,
          dbCondition: ModulesDbConditions.siteScreeningTrafficAndTrade,
        ),
      ],
    ),
    ModuleModel(
      title: "Feasibility",
      count: dashboardData.counts.feasibility,
      color: AppColors.nextStep2Color,
      icon: AppImages.feasibilityIconSvg,
      subModules: [
        SubModuleModel(
          title: "Feasibility",
          count: dashboardData.counts.feasibilityFeasibility,
          moduleName: "Feasibility",
          moduleColor: AppColors.nextStep2Color,
          moduleIcon: AppImages.feasibilityIconSvg,
          dbCondition: ModulesDbConditions.feasibilityFeasibility,
        ),
        SubModuleModel(
          title: "Negotiations",
          count: dashboardData.counts.negotiations,
          moduleName: "Feasibility",
          moduleColor: AppColors.nextStep2Color,
          moduleIcon: AppImages.feasibilityIconSvg,
          dbCondition: ModulesDbConditions.feasibilityNegotiations,
        ),
        SubModuleModel(
          title: "Feasibility Finalizations",
          count: dashboardData.counts.feasibilityFinalization,
          moduleName: "Feasibility",
          moduleColor: AppColors.nextStep2Color,
          moduleIcon: AppImages.feasibilityIconSvg,
          dbCondition: ModulesDbConditions.feasibilityFeasibilityFinalizations,
        ),
      ],
    ),
    ModuleModel(
      title: "Approvals",
      count: dashboardData.counts.approvals,
      color: AppColors.inProcessCountColor,
      icon: AppImages.inauguratedIconSvg,
      subModules: [
        SubModuleModel(
          title: "MOU Sign Off",
          count: dashboardData.counts.mouSignOff,
          moduleName: "Approvals",
          moduleColor: AppColors.inProcessCountColor,
          moduleIcon: AppImages.inauguratedIconSvg,
          dbCondition: ModulesDbConditions.approvalsMouSignOff,
        ),
        SubModuleModel(
          title: "Joining Fee",
          count: dashboardData.counts.joiningFee,
          moduleName: "Approvals",
          moduleColor: AppColors.inProcessCountColor,
          moduleIcon: AppImages.inauguratedIconSvg,
          dbCondition: ModulesDbConditions.approvalsJoiningFee,
        ),
        SubModuleModel(
          title: "Franchise Agreement",
          count: dashboardData.counts.franchiseAgreement,
          moduleName: "Approvals",
          moduleColor: AppColors.inProcessCountColor,
          moduleIcon: AppImages.inauguratedIconSvg,
          dbCondition: ModulesDbConditions.approvalsFranchiseAgreement,
        ),
      ],
    ),
    ModuleModel(
      title: "Layouts",
      count: dashboardData.counts.layouts,
      color: AppColors.emailUsIconColor,
      icon: AppImages.layoutIconSvg,
      subModules: [
        SubModuleModel(
          title: "Government Layout",
          count: dashboardData.counts.governmentLayout,
          moduleName: "Layouts",
          moduleColor: AppColors.emailUsIconColor,
          moduleIcon: AppImages.layoutIconSvg,
          dbCondition: ModulesDbConditions.layoutsGovernmentLayout,
        ),
        SubModuleModel(
          title: "Issuance of Drawings",
          count: dashboardData.counts.issuanceOfDrawings,
          moduleName: "Layouts",
          moduleColor: AppColors.emailUsIconColor,
          moduleIcon: AppImages.layoutIconSvg,
          dbCondition: ModulesDbConditions.layoutsIssuanceOfDrawings,
        ),
        SubModuleModel(
          title: "Topography",
          count: dashboardData.counts.topography,
          moduleName: "Layouts",
          moduleColor: AppColors.emailUsIconColor,
          moduleIcon: AppImages.layoutIconSvg,
          dbCondition: ModulesDbConditions.layoutsTopography,
        ),
        SubModuleModel(
          title: "Drawings",
          count: dashboardData.counts.drawing,
          moduleName: "Layouts",
          moduleColor: AppColors.emailUsIconColor,
          moduleIcon: AppImages.layoutIconSvg,
          dbCondition: ModulesDbConditions.layoutsDrawing,
        ),
        SubModuleModel(
          title: "Capex",
          count: dashboardData.counts.capex,
          moduleName: "Layouts",
          moduleColor: AppColors.emailUsIconColor,
          moduleIcon: AppImages.layoutIconSvg,
          dbCondition: ModulesDbConditions.layoutsCapex,
        ),
      ],
    ),
    ModuleModel(
      title: "Documents",
      count: dashboardData.counts.documents,
      color: AppColors.nextStep1Color,
      icon: AppImages.applyNewStationIconSvg,
      subModules: [
        SubModuleModel(
          title: "Applied in Explosive",
          count: dashboardData.counts.appliedInExplosive,
          moduleName: "Documents",
          moduleColor: AppColors.nextStep1Color,
          moduleIcon: AppImages.applyNewStationIconSvg,
          dbCondition: ModulesDbConditions.documentsAppliedInExplosive,
        ),
        SubModuleModel(
          title: "DC NOC",
          count: dashboardData.counts.dcNoc,
          moduleName: "Documents",
          moduleColor: AppColors.nextStep1Color,
          moduleIcon: AppImages.applyNewStationIconSvg,
          dbCondition: ModulesDbConditions.documentsDcNoc,
        ),
        SubModuleModel(
          title: "Lease Agreement",
          count: dashboardData.counts.leaseAgreement,
          moduleName: "Documents",
          moduleColor: AppColors.nextStep1Color,
          moduleIcon: AppImages.applyNewStationIconSvg,
          dbCondition: ModulesDbConditions.documentsLeaseAgreement,
        ),
      ],
    ),
    ModuleModel(
      title: "Construction",
      count: dashboardData.counts.construction,
      color: AppColors.nextStep2Color,
      icon: AppImages.constructionIconSvg,
      subModules: [
        SubModuleModel(
          title: "Construction Activity",
          count: dashboardData.counts.construction,
          moduleName: "Construction",
          moduleColor: AppColors.nextStep2Color,
          moduleIcon: AppImages.constructionIconSvg,
          dbCondition: ModulesDbConditions.construction,
        ),
      ],
    ),
    ModuleModel(
      title: "Commissioning",
      count: dashboardData.counts.commissioning,
      color: AppColors.commissioningColor,
      icon: AppImages.commissionIconSvg,
      subModules: [
        SubModuleModel(
          title: "HOTO",
          count: dashboardData.counts.hoto,
          moduleName: "Commissioning",
          moduleColor: AppColors.commissioningColor,
          moduleIcon: AppImages.commissionIconSvg,
          dbCondition: ModulesDbConditions.commissioningHoto,
        ),
        SubModuleModel(
          title: "Inaugurations",
          count: dashboardData.counts.inauguration,
          moduleName: "Commissioning",
          moduleColor: AppColors.commissioningColor,
          moduleIcon: AppImages.commissionIconSvg,
          dbCondition: ModulesDbConditions.commissioningInaugrations,
        ),
      ],
    ),
    ModuleModel(
      title: "History",
      count: dashboardData.counts.hisotry,
      color: AppColors.emailUsIconColor,
      icon: AppImages.historyIconSvg,
      subModules: [
        SubModuleModel(
          title: "Inaugurated List",
          count: dashboardData.counts.inaugurated,
          moduleName: "History",
          moduleColor: AppColors.emailUsIconColor,
          moduleIcon: AppImages.historyIconSvg,
          dbCondition: ModulesDbConditions.inaugurated,
        ),
        SubModuleModel(
          title: "Hold By Dealer",
          count: dashboardData.counts.holdByDealer,
          moduleName: "History",
          moduleColor: AppColors.emailUsIconColor,
          moduleIcon: AppImages.historyIconSvg,
          dbCondition: ModulesDbConditions.holdByDealer,
        ),
        SubModuleModel(
          title: "Hold By TGPL",
          count: dashboardData.counts.holdByTgpl,
          moduleName: "History",
          moduleColor: AppColors.emailUsIconColor,
          moduleIcon: AppImages.historyIconSvg,
          dbCondition: ModulesDbConditions.holdByTgpl,
        ),
        SubModuleModel(
          title: "Rejected By Dealer",
          count: dashboardData.counts.rejectedByDealer,
          moduleName: "History",
          moduleColor: AppColors.emailUsIconColor,
          moduleIcon: AppImages.historyIconSvg,
          dbCondition: ModulesDbConditions.rejectedByDealer,
        ),
        SubModuleModel(
          title: "Rejected By TGPL",
          count: dashboardData.counts.rejectedByTgpl,
          moduleName: "History",
          moduleColor: AppColors.emailUsIconColor,
          moduleIcon: AppImages.historyIconSvg,
          dbCondition: ModulesDbConditions.rejectedByTgpl,
        ),
      ],
    ),
  ];
});

List<SubModuleModel> getAllSubmodulesList(ref) {
  final List<ModuleModel> modules = ref.read(modulesProvider);
  final List<SubModuleModel> submodules = [];
  for (var mod in modules) {
    submodules.addAll(mod.subModules);
  }
  return submodules;
}
