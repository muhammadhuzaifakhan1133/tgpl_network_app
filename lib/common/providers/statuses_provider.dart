import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/app_status_category.dart';

final statusesProvider = Provider<List<AppStatusCategory>>((ref) {
  return [
    AppStatusCategory(
      type: AppStatusCategoryType.all,
      statusIds: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17],
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.inProcess,
      statusIds: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.inaugurated,
      statusIds: [13],
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.rejectedByTGPL,
      statusIds: [14],
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.holdByDealer,
      statusIds: [15],
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.holdByTGPL,
      statusIds: [16],
    ),
    AppStatusCategory(
      type: AppStatusCategoryType.rejectedByDealer,
      statusIds: [17],
    ),
  ];
});

