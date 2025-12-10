class AppConverter {
  static String formatDurationToTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String hours = twoDigits(duration.inHours);
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours == 0) return "$minutes:$seconds";
    return "$hours:$minutes:$seconds";
  }

  static DateTime? convertToDateTime(String? timestampStr) {
    if ((timestampStr ?? '').isNotEmpty) {
      final int timestamp = int.parse(timestampStr!);
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return dateTime;
    } else {
      return null;
    }
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}초 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}주 전';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}달 전';
    } else {
      return '${(difference.inDays / 365).floor()}년 전';
    }
  }

  static String customFormatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final int year = dateTime.year;
    final int month = dateTime.month;
    final int day = dateTime.day;
    final int hour = dateTime.hour;
    final int minute = dateTime.minute;
    final String period = hour >= 12 ? "오후" : "오전";
    final int formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final String monthStr = month.toString().padLeft(2, '0');
    final String dayStr = day.toString().padLeft(2, '0');
    final String minuteStr = minute.toString().padLeft(2, '0');

    return "$year.$monthStr.$dayStr $period $formattedHour:$minuteStr";
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('+82')) {
      phoneNumber = phoneNumber.replaceAll('+82', '0');
    }
    if (phoneNumber.length > 10) {
      return phoneNumber.replaceAllMapped(
        RegExp(r'(\d{3})(\d{4})(\d{4})'),
        (Match match) => '${match[1]}-${match[2]}-${match[3]}',
      );
    } else {
      return phoneNumber.replaceAllMapped(
        RegExp(r'(\d{3})(\d{3})(\d{4})'),
        (Match match) => '${match[1]}-${match[2]}-${match[3]}',
      );
    }
  }
}
