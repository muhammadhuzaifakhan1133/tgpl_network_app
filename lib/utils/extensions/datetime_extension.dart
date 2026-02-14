import 'package:flutter/rendering.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';
import 'package:intl/intl.dart';
extension DatetimeExtension on DateTime {
  // e.g. 25/12/2023
  String formatToDDMMYYY() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    return '$day/$month/$year';
  }
}

extension StrDateTimeExtension2 on String? {
  // 01/02/2026
  bool isValidDate() {
    debugPrint('Checking if "$this" is a valid date string');
    if (isNullOrEmpty) return false;
    try {
      // DateTime.parse(this!);
      DateFormat('dd/MM/yyyy').parseStrict(this!);
      return true;
    } catch (e) {
      return false;
    }
  }
}

extension StrDateTimeExtension on String {
  // Converts "25/12/2023" to ISO date string "2023-12-25T00:00:00.000"
  String formatFromDDMMYYYToIsoDate() {
    try {
      final parts = split('/');
      if (parts.length != 3) return this;
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final dateTime = DateTime(year, month, day);
      return dateTime.toIso8601String();
    } catch (e) {
      return this;
    }
  }

  // Converts ISO date string "2023-12-25T00:00:00.000" to "25/12/2023"
  String formatFromIsoToDDMMYYY() {
    try {
      final dateTime = DateTime.parse(this);
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      final year = dateTime.year;
      return '$day/$month/$year';
    } catch (e) {
      return this;
    }
  }

  // Converts ISO date string "2023-12-25T00:00:00.000" to "25 Dec, 2023"
  String formatTodMMMyyyy() {
    try {
      final dateTime = DateTime.parse(this);
      final day = dateTime.day.toString().padLeft(2, '0');
      final monthNames = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final month = monthNames[dateTime.month - 1];
      final year = dateTime.year;
      return '$day $month, $year';
    } catch (e) {
      return this;
    }
  }
}
