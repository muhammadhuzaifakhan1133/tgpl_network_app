import 'package:flutter_riverpod/flutter_riverpod.dart';

final tradeAreaNamesProvider = Provider<List<String>>((ref) {
  return [
    'Urban',
    'Suburban',
    'Rural',
    'Highway',
    'Industrial',
    'Commercial',
  ];
});