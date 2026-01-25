import 'package:flutter_riverpod/flutter_riverpod.dart';

final prioritiesProvider = Provider<List<String>>((ref) {
  return ["High", "Medium", "Low"];
});