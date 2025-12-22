import 'package:flutter_riverpod/flutter_riverpod.dart';

final cityNamesProvider = Provider<List<String>>((ref) {
  return ["Karachi", "Lahore", "Islamabad"];
});