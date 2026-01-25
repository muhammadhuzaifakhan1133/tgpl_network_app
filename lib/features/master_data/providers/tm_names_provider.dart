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