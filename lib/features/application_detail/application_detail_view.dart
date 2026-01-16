import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/features/application_detail/widgets/applicant_info_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/contact_dealer_tgpl_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/dealer_profile_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/feasibility_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/site_detail_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/recommendation_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/traffic_count_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/volum_and_financial_estimation_card.dart';

class ApplicationDetailView extends StatelessWidget {
  final String appId;
  final int statusId;
  const ApplicationDetailView({
    super.key,
    required this.appId,
    required this.statusId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: appId,
            subtitle: "Application Details",
            showBackButton: true,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                ApplicantInfoCard(
                  applicantName: "Huzaifa",
                  contactPerson: "Basit",
                  currentPresence: "Karachi",
                  emergencyContactPerson: "Abu Bakar",
                  whatsappNumber: "03001234567",
                ),
                const SizedBox(height: 20),
                SiteDetailCard(
                  entryCode: "TGPL-0001",
                  dateConducted: "2023-10-01",
                  googleLocation: "https://maps.google.com/?q=24.8607,67.0011",
                  city: "Karachi",
                  district: "Karachi South",
                  priority: "High",
                  locationAddress: "Sufi CNG, Shahdapur",
                  landmark: "The Citizen English Grammer School",
                  plotArea: "300",
                  plotFront: "150",
                  plotDepth: "150",
                  nearestDepo: "Habibabad",
                  distanceFromDepo: "593.00",
                  typeOfTrade: "High Populated Urban Area",
                ),
                const SizedBox(height: 20),
                ContactDealerTGPLCard(
                  npName: "Shadman",
                  source: "NW Manager (North & KPK)",
                  sourceName: "Shadman Khattak",
                  conductedBy: "Shadman",
                  dealerName: "Qamar Alam",
                  dealerContact: "03001234567",
                  referenceBy: "Basit",
                ),
                const SizedBox(height: 20),
                DealerProfileCard(
                  isDealer: "Yes",
                  platform: "MF-DO (Rental)",
                  otherDealerBusinesses: "0",
                  dealerInvolvementInBusiness:
                      "Low (Less than 1 hour on site daily)",
                  isReadyToInjectCapital: "Yes",
                  reasonForConversion: "0",
                  currentAttendantSalary: "0",
                  isAgreedToFollowStandards: "Yes",
                ),
                const SizedBox(height: 20),
                RecommendationCard(
                  tm: "TM Hyderabad(TM)",
                  tmRecommend: "Yes",
                  tmRemarks: "Good Site",
                  rm: "RM Hyderabad(RM)",
                  rmRecommend: "Yes",
                  rmRemarks: "It has Potential",
                ),
                if (statusId >= 3) ...[
                  const SizedBox(height: 20),
                  TrafficCountCard(cars: "1,250", bikes: "850", trucks: "320"),
                  const SizedBox(height: 20),
                  VolumAndFinancialEstimationCard(
                    estimatedDailyDieselSales: "0",
                    estimatedDailySuperSales: "0",
                    estimatedDailyLubricantSales: "0",
                    dealerExpectationOfLeaseRentalPerMonth: "0",
                    truckPortPotential: "No",
                    salamMartPotential: "No",
                    restaurantPotential: "No",
                  ),
                  const SizedBox(height: 20),
                  RecommendationCard(
                    tm: "TM Hyderabad(TM)",
                    tmRecommend: "Yes",
                    tmRemarks: "Good Site",
                    rm: "RM Hyderabad(RM)",
                    rmRecommend: "Yes",
                    rmRemarks: "It has Potential",
                  ),
                ],
                if (statusId >= 4) ...[
                  const SizedBox(height: 20),
                  FeasibilityCard(
                    isConversionPump: "Yes",
                    currentOMCName: "PSO",
                    isDealerInvestedSite: "Yes",
                    numberOfOperationYear: "5 Years",
                    isCurrentlyOperational: "Yes",
                    currentLeaseExpired: "Dec 2025",
                    dieselUGTSizeLitre: "5000",
                    superUGTSizeLitre: "3000",
                    numberOfDieselDispenser: "4",
                    numberOfSuperDispenser: "2",
                    currentlyCanopyCondition: "Good",
                    conditionOfDispensors: "Good",
                    conditionOfForecourt: "Good",
                    recommendation: "Recommended",
                    recommendationDetail: "",
                  ),
                ],
                // button for view on map
                const SizedBox(height: 20),
                CustomButton(text: "View on Map", onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
