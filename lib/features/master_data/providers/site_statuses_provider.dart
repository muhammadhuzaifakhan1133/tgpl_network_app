import 'package:flutter_riverpod/flutter_riverpod.dart';

final siteStatusesProvider = Provider<List<String>>((ref) {
  return ["New Plot", "Conversion Case", "CNG"];
});