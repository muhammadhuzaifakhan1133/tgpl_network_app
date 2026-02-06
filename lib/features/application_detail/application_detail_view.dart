import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/error_widget.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/common/widgets/application_fields_shimmer_widget.dart';
import 'package:tgpl_network/features/application_detail/widgets/contact_dealer_tgpl_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/dealer_profile_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/feasibility_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/site_detail_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/recommendation_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/traffic_count_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/volum_and_financial_estimation_card.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';
import 'package:tgpl_network/utils/map_utils.dart';

class ApplicationDetailView extends ConsumerWidget {
  final String applicationId;
  const ApplicationDetailView({super.key, required this.applicationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      applicationDetailAsyncControllerProvider(applicationId),
    );
    return state.when(
      data: (application) => _buildDetailView(application),
      loading: () => ApplicationFieldsShimmer(
        title: "Application Details",
      ),
      error: (error, stack) => Scaffold(body: errorWidget(error.toString())),
    );
  }

  Widget _buildDetailView(ApplicationModel application) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: application.entryCode ?? '',
            subtitle: "Application Details",
            showBackButton: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                // TODO: Add fields of Application Info
                // ApplicantInfoCard(
                //   applicantName: "Huzaifa",
                //   contactPerson: "Basit",
                //   currentPresence: "Karachi",
                //   emergencyContactPerson: "Abu Bakar",
                //   whatsappNumber: "03001234567",
                // ),
                SizedBox(height: 20.h),
                SiteDetailCard(
                  entryCode: application.entryCode ?? "",
                  dateConducted:
                      application.dateConducted?.formatTodMMMyyyy() ?? "",
                  googleLocation: application.googleLocation ?? "",
                  city: application.cityName ?? "",
                  district: application.district ?? "",
                  priority: application.priority ?? "",
                  locationAddress: application.locationAddress ?? "",
                  landmark: application.landmark ?? "",
                  plotArea: application.plotArea ?? "",
                  plotFront: application.plotFront?.toString() ?? "",
                  plotDepth: application.plotDepth?.toString() ?? "",
                  nearestDepo: application.nearestDepo ?? "",
                  distanceFromDepo:
                      application.distanceFromDetp?.toString() ?? "",
                  typeOfTrade: application.typeOfTradeArea ?? "",
                ),
                SizedBox(height: 20.h),
                ContactDealerTGPLCard(
                  npName: application.npPersonName ?? "",
                  source: application.source ?? "",
                  sourceName: application.sourceName ?? "",
                  // TODO: Add this field in Applicaiton Model
                  conductedBy: "",
                  dealerName: application.dealerName ?? "",
                  dealerContact: application.dealerContact ?? "",
                  referenceBy: application.referedBy ?? "",
                ),
                SizedBox(height: 20.h),
                DealerProfileCard(
                  isDealer: application.isThisDealerSite ?? "",
                  platform: application.platform ?? "",
                  otherDealerBusinesses: application.whatOtherBusiness ?? "",
                  dealerInvolvementInBusiness:
                      application.howInvolveDealerInPetrol ?? "",
                  isReadyToInjectCapital:
                      application.isDealerReadyToCapitalInvestment ?? "",
                  reasonForConversion: application.whyDoesTaj ?? "",
                  currentAttendantSalary:
                      application.managerCurrentSalary?.toString() ?? "",
                  isAgreedToFollowStandards:
                      application.isAgreeToTGPLStandard ?? "",
                ),
                SizedBox(height: 20.h),
                RecommendationCard(
                  tm: application.ssRecommendationTmName ?? "",
                  tmRecommend: application.ssTmRecommendation ?? "",
                  tmRemarks: application.ssTmRemarks ?? "",
                  rm: application.ssRecommendationRmName ?? "",
                  rmRecommend: application.ssRmRecommendation ?? "",
                  rmRemarks: application.ssRmRemarks ?? "",
                ),
                // is traffic trade done?
                if (application.trafficTradeDone == 1) ...[
                  SizedBox(height: 20.h),
                  TrafficCountCard(
                    cars: application.carCount?.toString() ?? "",
                    bikes: application.bikeCount?.toString() ?? "",
                    trucks: application.truckCount?.toString() ?? "",
                  ),
                  SizedBox(height: 20.h),
                  VolumAndFinancialEstimationCard(
                    estimatedDailyDieselSales:
                        application.estimateDailyDieselSale?.toString() ?? "0",
                    estimatedDailySuperSales:
                        application.estimateDailySuperSale?.toString() ?? "0",
                    estimatedDailyLubricantSales:
                        application.estimateLubricantSale?.toString() ?? "0",
                    dealerExpectationOfLeaseRentalPerMonth:
                        application.expectedLeaseRentPerManth?.toString() ??
                        "0",
                    truckPortPotential: application.trucPortPotentail ?? "",
                    salamMartPotential: application.salamMartPotential ?? "",
                    restaurantPotential: application.resturantPotential ?? "",
                  ),
                  SizedBox(height: 20.h),
                  RecommendationCard(
                    tm: application.ttRecommendationTmName ?? "",
                    tmRecommend: application.ttTmRecommendation ?? "",
                    tmRemarks: application.ttTmRemarks ?? "",
                    rm: application.ttRecommendationRmName ?? "",
                    rmRecommend: application.ttRmRecommendation ?? "",
                    rmRemarks: application.ttRmRemarks ?? "",
                  ),
                ],
                if (application.feasibilityDone == 1) ...[
                  SizedBox(height: 20.h),
                  FeasibilityCard(
                    isConversionPump: application.isThisConversionPump ?? "",
                    currentOMCName: application.currentOMCName ?? "",
                    isDealerInvestedSite:
                        application.isThisDealerInvestedSite ?? "",
                    numberOfOperationYear:
                        application.numberOfOperationYear?.toString() ?? "",
                    isCurrentlyOperational:
                        application.isCurrentlyOperational ?? "",
                    currentLeaseExpired: application.currentLeaseExpried ?? "",
                    dieselUGTSizeLitre:
                        application.dieselUGTSizeLiter?.toString() ?? "",
                    superUGTSizeLitre:
                        application.superUGTSizeLiter?.toString() ?? "",
                    numberOfDieselDispenser:
                        application.numberOfDieselDispenser?.toString() ?? "",
                    numberOfSuperDispenser:
                        application.numberOfSuperDispenser?.toString() ?? "",
                    currentlyCanopyCondition:
                        application.currentlyCanopyCondition ?? "",
                    conditionOfDispensors:
                        application.conditionOfDispensors ?? "",
                    conditionOfForecourt:
                        application.conditionOfForecourt ?? "",
                    recommendation: application.recommendation ?? "",
                    recommendationDetail:
                        application.recommendationDetail ?? "",
                  ),
                ],
                // button for view on map
                SizedBox(height: 20.h),
                CustomButton(
                  text: "View on Map",
                  onPressed: () {
                    MapUtils.openGoogleMap(
                      application.latitude,
                      application.longitude,
                    );
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
