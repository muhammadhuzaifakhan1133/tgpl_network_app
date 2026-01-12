import 'package:flutter_riverpod/flutter_riverpod.dart';

final yesNoNaValuesProvider = Provider<List<String>>((ref) {
  return [
    'Yes',
    'No',
    'N/A',
  ];
});

final yesNoValuesProvider = Provider<List<String>>((ref) {
  return [
    'Yes',
    'No',
  ];
});