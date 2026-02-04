import 'package:flutter_riverpod/flutter_riverpod.dart';

final statusesProvider = Provider<Map<String, String>>((ref) {
  return {
    "Inprocess": "0,1,2,3,4,5,6,7,8,9,10,11,12",
    "Inaugurated": "13",
    "Rejected By TGPL": "14",
    "Hold By Dealer": "15",
    "Hold By TGPL": "16",
    "Rejected By Dealer": "17",
  };
});

String getStatusById(int id, Map<String, String> statuses) {
  try {
    return statuses.entries
        .firstWhere((entry) => entry.value.split(',').contains(id.toString()))
        .key;
  } catch (e) {
    return "Unknown";
  }
}