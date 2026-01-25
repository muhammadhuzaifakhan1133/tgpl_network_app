import 'package:flutter_riverpod/flutter_riverpod.dart';

final dealerInvolvementNamesProvider = Provider<List<String>>((ref) {
  return [
    'High (4-6 hours on site daily)',
    'Medium (2-3 hours on site daily)',
    'Low (less than 1 hours on site daily)',
    'Not Involve (Absentee Dealer)',
  ];
});