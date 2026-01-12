import 'package:flutter/material.dart';

class TrafficSiteModel {
  TextEditingController siteNameController = TextEditingController();
  TextEditingController estimatedDailyDieselSaleController =
      TextEditingController();
  TextEditingController estimatedDailySuperSaleController =
      TextEditingController();
  TextEditingController estimatedDailyLubricantSaleController =
      TextEditingController();
  TextEditingController omcNameController = TextEditingController();
  String? isNfrFacility;
  List<String> nfrFacilities = [];

  void dispose() {
    siteNameController.dispose();
    estimatedDailyDieselSaleController.dispose();
    estimatedDailySuperSaleController.dispose();
    estimatedDailyLubricantSaleController.dispose();
    omcNameController.dispose();
  }

  TrafficSiteModel copyWith({
    TextEditingController? siteNameController,
    TextEditingController? estimatedDailyDieselSaleController,
    TextEditingController? estimatedDailySuperSaleController,
    TextEditingController? estimatedDailyLubricantSaleController,
    TextEditingController? omcNameController,
    String? isNfrFacility,
    List<String>? nfrFacilities,
  }) {
    return TrafficSiteModel()
      ..siteNameController =
          siteNameController ?? this.siteNameController
      ..estimatedDailyDieselSaleController =
          estimatedDailyDieselSaleController ??
              this.estimatedDailyDieselSaleController
      ..estimatedDailySuperSaleController =
          estimatedDailySuperSaleController ??
              this.estimatedDailySuperSaleController
      ..estimatedDailyLubricantSaleController =
          estimatedDailyLubricantSaleController ??
              this.estimatedDailyLubricantSaleController
      ..omcNameController = omcNameController ?? this.omcNameController
      ..isNfrFacility = isNfrFacility ?? this.isNfrFacility
      ..nfrFacilities = nfrFacilities ?? this.nfrFacilities;
  }
}
