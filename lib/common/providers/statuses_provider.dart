import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/app_status_category.dart';

final statusesProvider = Provider<List<AppStatusCategory>>((ref) {
  return [
    AppStatusCategory(
      type: AppStatusCategoryType.all,
      statusIds: AppStatusCategoryType.all.statusIds,
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.inProcess,
      statusIds: AppStatusCategoryType.inProcess.statusIds,
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.inaugurated,
      statusIds: AppStatusCategoryType.inaugurated.statusIds,
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.rejectedByTGPL,
      statusIds: AppStatusCategoryType.rejectedByTGPL.statusIds,
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.holdByDealer,
      statusIds: AppStatusCategoryType.holdByDealer.statusIds,
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.holdByTGPL,
      statusIds: AppStatusCategoryType.holdByTGPL.statusIds,
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.rejectedByDealer,
      statusIds: AppStatusCategoryType.rejectedByDealer.statusIds,
    ),
  ];
});

