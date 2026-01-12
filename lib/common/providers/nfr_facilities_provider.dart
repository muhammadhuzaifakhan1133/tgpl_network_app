import 'package:flutter_riverpod/flutter_riverpod.dart';

final nfrFacilitiesProvider = Provider<List<String>>((ref) {
  return [
    'Electricity',
    'Water Supply',
    'Sewage System',
    'Road Access',
    'Telecommunication',
    'Waste Management',
    'Fire Safety Measures',
    'Security Services',
  ];
});