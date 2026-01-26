// lib/features/master_data/data/models/master_data_response_model.dart
import 'dart:convert';

import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/models/city_model.dart';
import 'package:tgpl_network/features/master_data/models/dealer_investment_type_model.dart';
import 'package:tgpl_network/features/master_data/models/gfb_model.dart';
import 'package:tgpl_network/features/master_data/models/hml_model.dart';
import 'package:tgpl_network/features/master_data/models/master_list_type.dart';
import 'package:tgpl_network/features/master_data/models/nearest_depo_model.dart';
import 'package:tgpl_network/features/master_data/models/nfr_model.dart';
import 'package:tgpl_network/features/master_data/models/recommendation_model.dart';
import 'package:tgpl_network/features/master_data/models/shift_hour_model.dart';
import 'package:tgpl_network/features/master_data/models/trade_area_type_model.dart';
import 'package:tgpl_network/features/master_data/models/traffic_trades_model.dart';
import 'package:tgpl_network/features/master_data/models/yna_model.dart';

class MasterDataResponseModel {
  final List<ApplicationModel> applicationAndSurveyList;
  final List<TrafficTradesModel> traficTradeSitesList;
  final List<CityModel> userCityList;
  final List<NearestDepoModel> nearestDepo;
  final List<TradeAreaTypeModel> tradeAreaType;
  final List<DealerInvestmentTypeModel> dealerInvestmentType;
  final List<GFBModel> gfbList;
  final List<RecommendationModel> recommendationList;
  final List<ShiftHourModel> shiftHourList;
  final List<HMLModel> hmlList;
  final List<MasterDataYNAModel> ynList;
  final List<MasterDataYNAModel> ynnList;
  final List<NFRModel> nfrList;

  MasterDataResponseModel({
    required this.applicationAndSurveyList,
    required this.traficTradeSitesList,
    required this.userCityList,
    required this.nearestDepo,
    required this.tradeAreaType,
    required this.dealerInvestmentType,
    required this.gfbList,
    required this.recommendationList,
    required this.shiftHourList,
    required this.hmlList,
    required this.ynList,
    required this.ynnList,
    required this.nfrList,
  });

  factory MasterDataResponseModel.fromAPIResponseMap(
    Map<String, dynamic> json,
  ) {
    return MasterDataResponseModel(
      applicationAndSurveyList: List<ApplicationModel>.from(
        json['ApplicationAndSurveyList']?.map(
              (x) => ApplicationModel.fromAPIResponseMap(x),
            ) ??
            [],
      ),
      traficTradeSitesList: List<TrafficTradesModel>.from(
        json['TraficTradeSitesList']?.map(
              (x) => TrafficTradesModel.fromAPIResponseMap(x),
            ) ??
            [],
      ),
      userCityList: List<CityModel>.from(
        json['UserCityList']?.map((x) => CityModel.fromAPIResponseMap(x)) ?? [],
      ),
      nearestDepo: List<NearestDepoModel>.from(
        json['NearestDepo']?.map((x) => NearestDepoModel(x)) ?? [],
      ),
      tradeAreaType: List<TradeAreaTypeModel>.from(
        json['TradeAreaType']?.map((x) => TradeAreaTypeModel(x)) ?? [],
      ),
      dealerInvestmentType: List<DealerInvestmentTypeModel>.from(
        json['DealerInvestmentType']?.map(
              (x) => DealerInvestmentTypeModel(x),
            ) ??
            [],
      ),
      gfbList: List<GFBModel>.from(
        json['GFBList']?.map((x) => GFBModel(x)) ?? [],
      ),
      recommendationList: List<RecommendationModel>.from(
        json['RecommendationList']?.map((x) => RecommendationModel(x)) ?? [],
      ),
      shiftHourList: List<ShiftHourModel>.from(
        json['ShiftHourList']?.map((x) => ShiftHourModel(x)) ?? [],
      ),
      hmlList: List<HMLModel>.from(
        json['HMLList']?.map((x) => HMLModel(x)) ?? [],
      ),
      ynList: List<MasterDataYNAModel>.from(
        json['YNList']?.map((x) => MasterDataYNAModel(x)) ?? [],
      ),
      ynnList: List<MasterDataYNAModel>.from(
        json['YNNList']?.map((x) => MasterDataYNAModel(x)) ?? [],
      ),
      nfrList: List<NFRModel>.from(
        json['NFRList']?.map((x) => NFRModel(x)) ?? [],
      ),
    );
  }

  Map<String, String> listTypeToMap(MasterListType type) {
    late List<String> values;
    switch (type) {
      case MasterListType.nearestDepo:
        values = nearestDepo.map((e) => e.name).toList();
        break;
      case MasterListType.tradeAreaType:
        values = tradeAreaType.map((e) => e.type).toList();
        break;
      case MasterListType.dealerInvestmentType:
        values = dealerInvestmentType.map((e) => e.type).toList();
        break;
      case MasterListType.gfbList:
        values = gfbList.map((e) => e.gfb).toList();
        break;
      case MasterListType.recommendationList:
        values = recommendationList.map((e) => e.recommendation).toList();
        break;
      case MasterListType.shiftHourList:
        values = shiftHourList.map((e) => e.shiftHour).toList();
        break;
      case MasterListType.hmlList:
        values = hmlList.map((e) => e.hml).toList();
        break;
      case MasterListType.ynList:
        values = ynList.map((e) => e.yna).toList();
        break;
      case MasterListType.ynnList:
        values = ynnList.map((e) => e.yna).toList();
        break;
      case MasterListType.nfrList:
        values = nfrList.map((e) => e.nfr).toList();
        break;
    }
    return {
      MasterListTypeTable.databaseColName: type.key,
      'listValues': jsonEncode(values),
    };
  }
}
