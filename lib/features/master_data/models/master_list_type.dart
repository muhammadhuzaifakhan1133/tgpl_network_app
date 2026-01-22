// lib/features/master_data/data/models/master_list_type.dart
import 'package:tgpl_network/constants/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';

enum MasterListType {
  nearestDepo,
  tradeAreaType,
  dealerInvestmentType,
  gfbList,
  recommendationList,
  shiftHourList,
  hmlList,
  ynList,
  ynnList,
  nfrList,
}

class MasterListTypeTable {
  static String get databaseColName => 'listType';

  static String get createSQLTableQuery {
    final idType = DatabaseHelper.idType;
    final textType = DatabaseHelper.textType;
    return '''
      CREATE TABLE ${AppDatabase.masterListsTable} (
        id $idType,
        $databaseColName $textType,
        listValues $textType
      )
    ''';
  }
}

extension MasterListTypeX on MasterListType {

  String get key {
    switch (this) {
      case MasterListType.nearestDepo:
        return 'NearestDepo';
      case MasterListType.tradeAreaType:
        return 'TradeAreaType';
      case MasterListType.dealerInvestmentType:
        return 'DealerInvestmentType';
      case MasterListType.gfbList:
        return 'GFBList';
      case MasterListType.recommendationList:
        return 'RecommendationList';
      case MasterListType.shiftHourList:
        return 'ShiftHourList';
      case MasterListType.hmlList:
        return 'HMLList';
      case MasterListType.ynList:
        return 'YNList';
      case MasterListType.ynnList:
        return 'YNNList';
      case MasterListType.nfrList:
        return 'NFRList';
    }
  }
}


