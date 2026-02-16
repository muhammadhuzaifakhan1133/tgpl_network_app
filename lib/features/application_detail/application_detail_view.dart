import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/error_widget.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/common/widgets/application_fields_shimmer_widget.dart';
import 'package:tgpl_network/features/application_detail/application_stages_view.dart';
import 'package:tgpl_network/features/application_detail/widgets/applicant_info_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/application_stage_shimmer_view.dart';
import 'package:tgpl_network/features/application_detail/widgets/contact_dealer_tgpl_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/dealer_profile_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/feasibility_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/site_detail_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/recommendation_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/traffic_count_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/volum_and_financial_estimation_card.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/utils/map_utils.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

class ApplicationDetailView extends ConsumerStatefulWidget {
  final String applicationId;
  const ApplicationDetailView({super.key, required this.applicationId});

  @override
  ConsumerState<ApplicationDetailView> createState() =>
      _ApplicationDetailViewState();
}

class _ApplicationDetailViewState extends ConsumerState<ApplicationDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      applicationDetailAsyncControllerProvider(widget.applicationId),
    );
    // return state.when(
    //   data: (details) => _buildDetailView(context, ref, details.application),
    //   loading: () => ApplicationFieldsShimmer(title: "Application Details"),
    //   error: (error, stack) => Scaffold(body: errorWidget(error.toString())),
    // );
    final areAllCardsExpanded = ref.watch(
      applicationDetailControllerProvider.select(
        (state) => state.areAllCardsExpanded,
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: state.when(
              data: (details) =>
                  details.application.entryCode ?? "Application Details",
              loading: () => "Loading...",
              error: (error, stack) => "Application Details",
            ),
            subtitle: "Application Details",
            showBackButton: true,
            actions: [
              // Show expand/collapse only on Details tab
              AnimatedBuilder(
                animation: _tabController,
                builder: (context, child) {
                  if (_tabController.index == 0) {
                    return IconButton(
                      icon: Icon(
                        areAllCardsExpanded
                            ? Icons.unfold_less
                            : Icons.unfold_more,
                      ),
                      tooltip: areAllCardsExpanded
                          ? 'Collapse All'
                          : 'Expand All',
                      onPressed: () {
                        ref
                            .read(applicationDetailControllerProvider.notifier)
                            .toggleAllCards();
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              // Sync button
              IconButton(
                icon: const Icon(Icons.sync),
                tooltip: 'Sync application with server',
                onPressed: () =>
                    _syncApplicationData(context, ref, widget.applicationId),
              ),
            ],
          ),
          // TabBar
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Details'),
                Tab(text: 'Stages'),
              ],
            ),
          ),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Details Tab
                state.when(
                  data: (details) =>
                      _buildDetailsTab(context, details.application),
                  loading: () => ApplicationFieldContainersShimmer(),
                  error: (error, stack) =>
                      Scaffold(body: errorWidget(error.toString())),
                ),
                // Stages Tab
                state.when(
                  data: (details) => ApplicationStagesView(
                    applicationId: widget.applicationId,
                  ),
                  loading: () => ApplicationStagesShimmer(),
                  error: (error, stack) =>
                      Scaffold(body: errorWidget(error.toString())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Extract sync logic to a reusable method
  Future<void> _syncApplicationData(
    BuildContext context,
    WidgetRef ref,
    String applicationId,
  ) async {
    // Show loading indicator
    showSnackBar(context, 'Syncing application data...');

    // Trigger sync
    await ref
        .read(applicationDetailAsyncControllerProvider(applicationId).notifier)
        .syncApplicationData();

    // Show success message
    if (context.mounted) {
      showSnackBar(
        context,
        'Application synced successfully!',
        bgColor: AppColors.onlineStatusColor,
      );
    }
  }

  Widget _buildDetailsTab(BuildContext context, ApplicationModel application) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      children: [
        ApplicantInfoCard(
          applicantName: application.applicantName ?? "",
          contactPerson: application.contactPersonName ?? "",
          currentPresence: application.currentlyPresence ?? "",
          contactNumber: application.contactNumber ?? "",
          whatsappNumber: application.whatsAppNumber ?? "",
        ),
        SizedBox(height: 20.h),
        SiteDetailCard(
          entryCode: application.entryCode ?? "",
          googleLocation: application.googleLocation ?? "",
          city: application.cityName ?? "",
          district: application.district ?? "",
          priority: application.priority ?? "",
          locationAddress: application.siteAddress ?? "",
          landmark: application.landmark ?? "",
          plotArea: application.plotAreaValue.toString(),
          plotFront: application.plotFront?.toString() ?? "",
          plotDepth: application.plotDepth?.toString() ?? "",
          nearestDepo: application.nearestDepo ?? "",
          distanceFromDepo: application.distanceFromDepo?.toString() ?? "",
          typeOfTrade: application.typeOfTradeArea ?? "",
        ),
        SizedBox(height: 20.h),
        ContactDealerTGPLCard(
          npName: application.npPersonName ?? "",
          source: application.source ?? "",
          sourceName: application.sourceName ?? "",
          conductedBy: application.preparedBy ?? "",
          dealerName: application.applicantName ?? "",
          dealerContact: application.contactNumber ?? "",
          referenceBy: application.referedBy ?? "",
        ),
        SizedBox(height: 20.h),
        DealerProfileCard(
          isDealer: application.isThisDealerSite ?? "",
          platform: application.platForm ?? "",
          otherDealerBusinesses: application.whatOtherBusiness ?? "",
          dealerInvolvementInBusiness:
              application.howInvolveDealerInPetrol ?? "",
          isReadyToInjectCapital:
              application.isDealerReadyToCapitalInvestment ?? "",
          reasonForConversion: application.whyDoesTaj ?? "",
          currentAttendantSalary:
              application.managerCurrentSalary?.toString() ?? "",
          isAgreedToFollowStandards: application.isAgreeToTGPLStandard ?? "",
        ),
        SizedBox(height: 20.h),
        RecommendationCard(
          tm: application.ssRecommendationTMName ?? "",
          tmRecommend: application.sstmRecommendation ?? "",
          tmRemarks: application.sstmRemarks ?? "",
          rm: application.ssRecommendationRMName ?? "",
          rmRecommend: application.ssrmRecommendation ?? "",
          rmRemarks: application.ssrmRemarks ?? "",
        ),
        // is traffic trade done?
        if (application.trafficTradeDone == 1) ...[
          SizedBox(height: 20.h),
          TrafficCountCard(
            cars: application.carCount?.toString() ?? "",
            bikes: application.bikeCount?.toString() ?? "",
            // TODO: add truck count in API and model
            // trucks: application.truck?.toString() ?? "",
            trucks: "",
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
                application.expectedLeaseRentPerManth?.toString() ?? "0",
            truckPortPotential: application.truckPortPotential ?? "",
            salamMartPotential: application.salamMartPotential ?? "",
            restaurantPotential: application.resturantPotential ?? "",
          ),
          SizedBox(height: 20.h),
          RecommendationCard(
            tm: application.ttRecommendationTMName ?? "",
            tmRecommend: application.tttmRecommendation ?? "",
            tmRemarks: application.tttmRemarks ?? "",
            rm: application.ttRecommendationRMName ?? "",
            rmRecommend: application.ttrmRecommendation ?? "",
            rmRemarks: application.ttrmRemarks ?? "",
          ),
        ],
        if (application.feasibilityDone == 1) ...[
          SizedBox(height: 20.h),
          FeasibilityCard(
            isConversionPump: application.isThisConversionPump ?? "",
            currentOMCName: application.currentOMCName ?? "",
            isDealerInvestedSite: application.isThisDealerInvestedSite ?? "",
            numberOfOperationYear:
                application.numberOfOperationYear?.toString() ?? "",
            isCurrentlyOperational: application.isCurrentlyOperational ?? "",
            currentLeaseExpired: application.currentLeaseExpried ?? "",
            dieselUGTSizeLitre:
                application.dieselUGTSizeLiter?.toString() ?? "",
            superUGTSizeLitre: application.superUGTSizeLiter?.toString() ?? "",
            numberOfDieselDispenser:
                application.numberOfDieselDispenser?.toString() ?? "",
            numberOfSuperDispenser:
                application.numberOfSuperDispenser?.toString() ?? "",
            currentlyCanopyCondition:
                application.currentlyCanopyCondition ?? "",
            conditionOfDispensors: application.conditionOfDispensors ?? "",
            conditionOfForecourt: application.conditionOfForecourt ?? "",
            recommendation: application.recommendation ?? "",
            recommendationDetail: application.recommendationDetail ?? "",
          ),
        ],
        SizedBox(height: 20.h),
        // Sync button at bottom - more prominent
        CustomButton(
          text: "",
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sync, color: Colors.white),
              SizedBox(width: 8.w),
              const Text(
                "Sync Application Data",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          onPressed: () =>
              _syncApplicationData(context, ref, widget.applicationId),
        ),
        SizedBox(height: 10.h),
        CustomButton(
          text: "View on Map",
          onPressed: () {
            MapUtils.openGoogleMap(application.latitude, application.longitude);
          },
        ),
      ],
    );
  }
}
