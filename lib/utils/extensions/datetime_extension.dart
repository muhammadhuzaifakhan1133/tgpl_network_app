extension DatetimeExtension on DateTime {
  String formatToDDMMYYY() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    return '$day/$month/$year';
  }
}

extension StrDateTimeExtension on String {
  String formatTod_MMM_yyyy() {
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
      'Dec'
    ];
    final month = monthNames[dateTime.month - 1];
    final year = dateTime.year;
    return '$day $month, $year';
    } catch (e) {
      return this;
    }
  }
}
