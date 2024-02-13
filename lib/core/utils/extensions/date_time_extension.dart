extension DateTimeExtension on DateTime {
  String get toEmailDate {
    final String day = this.day.toString().padLeft(2, '0');
    final String month = this.month.toString().padLeft(2, '0');
    final String year = this.year.toString();
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');

    return '$day/$month/$year at $hour:$minute';
  }
}
