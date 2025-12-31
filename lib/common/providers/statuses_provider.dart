import 'package:flutter_riverpod/flutter_riverpod.dart';

final statusesProvider = Provider<List<String>>((ref) {
  return [
    "Rejected By TGPL",
    "Hold By Dealer",
    "Inprocess",
    "Hold By TGPL",
    "Rejected By Dealer",
    "Inaugurated",
  ];
});