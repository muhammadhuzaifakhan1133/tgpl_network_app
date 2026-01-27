import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

extension DatetimeExtension on DateTime {
  String formatToDDMMYYY() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    return '$day/$month/$year';
  }
}

extension StrDateTimeExtension2 on String? {
   bool isValidDate() {
    if (isNullOrEmpty) return false;
    try {
      DateTime.parse(this!);
      return true;
    } catch (e) {
      return false;
    }
  }
}

extension StrDateTimeExtension on String {
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
