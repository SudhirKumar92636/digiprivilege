import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime);
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime.toUtc());
  }

  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('h:mm a | d-MMM-yyyy ').format(dateTime.toLocal());
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static bool isInThisYear(String date) {
    DateTime _currentTime = DateTime.now();
    DateTime _orderTime = isoStringToLocalDate(date);
    return _currentTime.year == _orderTime.year;
  }

  static int getMonthIndex(String date) {
    return isoStringToLocalDate(date).month;
  }

  static String getDateFormTimestamp(Timestamp date) {
    var format = DateFormat('dd MMM yyyy');
    return format.format(date.toDate());
  }

  static String getExpiryDateFormTimestamp(Timestamp date, String days) {
    var format = DateFormat('dd MMM yyyy');
    return format.format(date.toDate().add(Duration(days: int.parse(days))));
  }

  static int convertMonthToDay(String noMonth) {
    return int.parse(noMonth) * 30;
  }
}
