import 'package:flutter_riverpod/flutter_riverpod.dart';

final tmNamesProvider = Provider<List<String>>((ref) {
  return [
    'TM 1',
    'TM 2',
    'TM 3',
    'TM 4',
    'TM 5',
  ];
});

final rmNamesProvider = Provider<List<String>>((ref) {
  return [
    'RM 1',
    'RM 2',
    'RM 3',
    'RM 4',
    'RM 5',
  ];
});