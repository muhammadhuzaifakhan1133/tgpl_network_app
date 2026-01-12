import 'package:flutter_riverpod/flutter_riverpod.dart';

final depoNamesProvider = Provider<List<String>>((ref) {
  return [
    'Depo A',
    'Depo B',
    'Depo C',
    'Depo D',
    'Depo E',
  ];
});