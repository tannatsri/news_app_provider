import 'package:flutter/material.dart';

extension StringX on String? {
  bool hasPrefix(String pattern) {
    if (isNullOrEmpty()) {
      return false;
    } else {
      final match = pattern.matchAsPrefix(this!);
      return match != null;
    }
  }

  String toHumanReadable() {

    DateTime dateTime = DateTime.parse(this ?? "");

    String day = dateTime.day.toString().padLeft(2, '0');
    String month = _getMonthAbbreviation(dateTime.month);
    String year = dateTime.year.toString().substring(2);
    String time = _formatTime(dateTime.hour, dateTime.minute);

    return '$day $month\'$year, $time';
  }

  String _getMonthAbbreviation(int month) {
    const List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[month - 1];
  }

  String _formatTime(int hour, int minute) {
    String period = hour >= 12 ? 'pm' : 'am';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour; // Adjust hour for 12-hour format
    String minuteStr = minute.toString().padLeft(2, '0');
    return '$hour:$minuteStr $period';
  }

  /// this extension checks for whether the string is null or empty.
  bool isNullOrEmpty() {
    if (this == null || this?.isEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  /// this extension is used to get [CrossAxisAlignment] based on value provided.
  CrossAxisAlignment get getCrossAxisAlignment {
    if (isNullOrEmpty() == false) {
      switch (this?.toUpperCase()) {
        case "CENTER":
          return CrossAxisAlignment.center;
        case "START":
          return CrossAxisAlignment.start;
        case "BASELINE":
          return CrossAxisAlignment.baseline;
        case "END":
          return CrossAxisAlignment.end;
        case "STRETCH":
          return CrossAxisAlignment.stretch;
        default:
          return CrossAxisAlignment.start;
      }
    } else {
      return CrossAxisAlignment.start;
    }
  }

  BoxFit? get getBoxFit {
    if (isNullOrEmpty()) return null;
    switch (this?.toUpperCase()) {
      case "CONTAIN":
        return BoxFit.contain;
      case "COVER":
        return BoxFit.cover;
      case "FILL":
        return BoxFit.fill;
      case "FIT_HEIGHT":
        return BoxFit.fitHeight;
      case "FIT_WIDTH":
        return BoxFit.fitWidth;
      case "NONE":
        return BoxFit.none;
      case "SCALE_DOWN":
        return BoxFit.scaleDown;
      default:
        return null;
    }
  }

  /// this extension is used to get [MainAxisAlignment] based on value provided.
  MainAxisAlignment get getMainAxisAlignment {
    if (isNullOrEmpty() == false) {
      switch (this?.toUpperCase()) {
        case "CENTER":
          return MainAxisAlignment.center;
        case "START":
          return MainAxisAlignment.start;
        case "SPACE_AROUND":
          return MainAxisAlignment.spaceAround;
        case "SPACE_BETWEEN":
          return MainAxisAlignment.spaceBetween;
        case "SPACE_EVENLY":
          return MainAxisAlignment.spaceEvenly;
        case "END":
          return MainAxisAlignment.end;
        default:
          return MainAxisAlignment.start;
      }
    } else {
      return MainAxisAlignment.start;
    }
  }

  /// This function formats the given integer to Indian locale currency term.
  ///
  /// It return a string that is formatted in INR format with required separation.
  ///
  /// eg->
  ///
  ///[INPUT] = [200000] , [Output] = [20K]
  ///
  /// [INPUT] = [2000000] , [Output] = [20L]
  ///
  /// [INPUT] = [200000000] , [Output] = [20Cr]
  String get formatToLocalIndianCurrencyValue {
    int? amount = int.tryParse(this ?? "");
    if (amount == null) {
      return '';
    } else if (amount < 1000) {
      return '₹$amount';
    } else if (amount < 100000) {
      double result = amount / 1000.0;
      return '₹${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2)}K';
    } else if (amount < 10000000) {
      double result = amount / 100000.0;
      return '₹${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2)}L';
    } else {
      double result = amount / 10000000.0;
      return '₹${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2)}Cr';
    }
  }

  String toStringOrEmpty() {
    if (this == null || this?.isEmpty == true) {
      return "";
    } else {
      return toString();
    }
  }

  /// This function removes all non integer value (including negative sign).
  ///
  /// It return a string that is formatted in INR format with required separation.
  String rupeeFormatString({required String prefix, bool? formatString}) {
    if (this == null) {
      return '';
    } else {
      String sanitisedValue = (this ?? '').sanitisedNumberString();
      List<String> chars = sanitisedValue.split('').reversed.join().split('');
      String newString = '';
      List<int> commaPlace = [3, 5, 7, 9, 11, 13];
      for (int i = 0; i < chars.length; i++) {
        if (commaPlace.contains(i)) newString += ',';
        newString += chars[i];
      }
      return prefix + newString.split('').reversed.join();
    }
  }

  /// This function removes all non integer value (including negative sign).
  ///
  /// It return a string that completely contains integer values.
  String sanitisedNumberString() {
    if (isNullOrEmpty()) {
      return '';
    } else {
      final negativeSign = (this?.substring(0, 1) == '-') ? '-' : '';
      String thisString = (this ?? '')
          .replaceAll(',', '')
          .replaceAll(' ', '')
          .replaceAll('.', '')
          .replaceAll('-', '');
      var sanitisedValue = '';
      for (int i = 0; i < thisString.length; ++i) {
        if (thisString[i].contains(RegExp(r'[0-9]'))) {
          sanitisedValue = sanitisedValue + thisString[i];
        }
      }
      return negativeSign + sanitisedValue;
    }
  }

  /// This function checks for equality of strings.
  ///
  /// If [ignoreCase] is marked as [true] then, it will not match case.
  bool isEquals(String text, {bool ignoreCase = false}) {
    if (!ignoreCase) {
      return text == this;
    } else {
      return this?.toUpperCase() == text.toUpperCase();
    }
  }

  AlignmentGeometry get alignmentBasedOnValue {
    if (isNullOrEmpty()) {
      return Alignment.center;
    } else if (isEquals("top-left", ignoreCase: true)) {
      return Alignment.topLeft;
    } else if (isEquals("top-center", ignoreCase: true)) {
      return Alignment.topCenter;
    } else if (isEquals("top-right", ignoreCase: true)) {
      return Alignment.topRight;
    } else if (isEquals("center-left", ignoreCase: true)) {
      return Alignment.centerLeft;
    } else if (isEquals("center", ignoreCase: true)) {
      return Alignment.center;
    } else if (isEquals("center-right", ignoreCase: true)) {
      return Alignment.centerRight;
    } else if (isEquals("bottom-left", ignoreCase: true)) {
      return Alignment.bottomLeft;
    } else if (isEquals("bottom-center", ignoreCase: true)) {
      return Alignment.bottomCenter;
    } else if (isEquals("bottom-right", ignoreCase: true)) {
      return Alignment.bottomRight;
    } else {
      return Alignment.center;
    }
  }

  Alignment getAlignmentBasedOnValue(String? alignment) {
    if (alignment.isNullOrEmpty()) {
      return Alignment.center;
    } else if (alignment.isEquals("top-left", ignoreCase: true)) {
      return Alignment.topLeft;
    } else if (alignment.isEquals("top-center", ignoreCase: true)) {
      return Alignment.topCenter;
    } else if (alignment.isEquals("top-right", ignoreCase: true)) {
      return Alignment.topRight;
    } else if (alignment.isEquals("center-left", ignoreCase: true)) {
      return Alignment.centerLeft;
    } else if (alignment.isEquals("center", ignoreCase: true)) {
      return Alignment.center;
    } else if (alignment.isEquals("center-right", ignoreCase: true)) {
      return Alignment.centerRight;
    } else if (alignment.isEquals("bottom-left", ignoreCase: true)) {
      return Alignment.bottomLeft;
    } else if (alignment.isEquals("bottom-center", ignoreCase: true)) {
      return Alignment.bottomCenter;
    } else if (alignment.isEquals("bottom-right", ignoreCase: true)) {
      return Alignment.bottomRight;
    } else {
      return Alignment.center;
    }
  }

  TextInputType getTextInputType(String? type) {
    if (type.isNullOrEmpty()) {
      return TextInputType.text;
    } else if (type.isEquals("number", ignoreCase: true) ||
        type.isEquals("number-without-formatting", ignoreCase: true)) {
      return TextInputType.number;
    } else if (type.isEquals("email", ignoreCase: true)) {
      return TextInputType.emailAddress;
    } else if (type.isEquals("phone", ignoreCase: true)) {
      return TextInputType.phone;
    } else if (type.isEquals("name", ignoreCase: true)) {
      return TextInputType.name;
    } else if (type.isEquals("url", ignoreCase: true)) {
      return TextInputType.url;
    }
    return TextInputType.text;
  }

  TextAlign getTextAlignmentType(String? alignment) {
    if (alignment.isNullOrEmpty()) {
      return TextAlign.left;
    } else if (alignment.isEquals("left", ignoreCase: true)) {
      return TextAlign.left;
    } else if (alignment.isEquals("center", ignoreCase: true)) {
      return TextAlign.center;
    } else if (alignment.isEquals("right", ignoreCase: true)) {
      return TextAlign.right;
    } else if (alignment.isEquals("top-left", ignoreCase: true)) {
      return TextAlign.left;
    } else if (alignment.isEquals("top-center", ignoreCase: true)) {
      return TextAlign.center;
    } else if (alignment.isEquals("top-right", ignoreCase: true)) {
      return TextAlign.right;
    } else if (alignment.isEquals("center-left", ignoreCase: true)) {
      return TextAlign.left;
    } else if (alignment.isEquals("center", ignoreCase: true)) {
      return TextAlign.center;
    } else if (alignment.isEquals("center-right", ignoreCase: true)) {
      return TextAlign.right;
    } else if (alignment.isEquals("bottom-left", ignoreCase: true)) {
      return TextAlign.left;
    } else if (alignment.isEquals("bottom-center", ignoreCase: true)) {
      return TextAlign.center;
    } else if (alignment.isEquals("bottom-right", ignoreCase: true)) {
      return TextAlign.right;
    }
    return TextAlign.left;
  }
}
