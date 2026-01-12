import 'package:flutter/material.dart';

Future<void> customDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  required void Function(DateTime) onUserSelectedDate,
}) async {
  final selectedDate = await showDatePicker(
    context: context,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    initialDate: initialDate,
  );
  if (selectedDate != null) {
    onUserSelectedDate(selectedDate);
  }
}
