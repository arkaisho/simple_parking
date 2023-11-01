import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_parking/utils/custom_colors.dart';

void printException(String identifier, e, s) {
  log(identifier);
  if (e is DioException) {
    log("${e.requestOptions.baseUrl}${e.requestOptions.path}");
    log(e.response.toString());
    log(e.error.toString());
  }
  log(e.toString());
  log(s.toString());
}

String getReadableCompleteDate(
  DateTime date, {
  bool showSeconds = false,
  bool showTime = true,
}) {
  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${showTime ? _formatTime(date, showSeconds: showSeconds) : ""}';
}

String formatDateTime(DateTime date,
    {bool showSeconds = false, bool showCompleteWeekDay = false}) {
  final now = DateTime.now();
  final difference = now.difference(date);
  var isSameDay =
      date.year == now.year && date.day == now.day && date.month == now.month;

  if (difference.inDays >= 7) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  } else if (!isSameDay) {
    return '${_getWeekdayName(date.weekday)}, ${_formatTime(date, showSeconds: showSeconds)}';
  } else {
    return 'às ${_formatTime(date, showSeconds: showSeconds)}';
  }
}

String _getWeekdayName(int weekday, {bool showCompleteWeekDay = false}) {
  switch (weekday) {
    case DateTime.monday:
      return showCompleteWeekDay ? 'Seg' : 'Segunda';
    case DateTime.tuesday:
      return showCompleteWeekDay ? 'Ter' : 'Terça';
    case DateTime.wednesday:
      return showCompleteWeekDay ? 'Qua' : 'Quarta';
    case DateTime.thursday:
      return showCompleteWeekDay ? 'Qui' : 'Quinta';
    case DateTime.friday:
      return showCompleteWeekDay ? 'Sex' : 'Sexta';
    case DateTime.saturday:
      return showCompleteWeekDay ? 'Sáb' : 'Sábado';
    case DateTime.sunday:
      return showCompleteWeekDay ? 'Dom' : 'Domingo';
    default:
      return '';
  }
}

String _formatTime(
  DateTime dateTime, {
  bool showSeconds = false,
}) {
  final formattedHour = dateTime.hour.toString().padLeft(2, '0');
  final formattedMinute = dateTime.minute.toString().padLeft(2, '0');
  final formattedSecond = dateTime.second.toString().padLeft(2, '0');
  return '$formattedHour:$formattedMinute${showSeconds ? ":$formattedSecond" : ""}';
}

Future<String?> getDownloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS || Platform.environment.containsKey('FLUTTER_TEST')) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    }
  } catch (e, s) {
    printException("misc.getDownloadPath", e, s);
  }
  return directory?.path;
}

showToast({
  required String text,
  bool success = true,
}) {
  if (!Platform.environment.containsKey('FLUTTER_TEST')) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: success ? CustomColors.primary : CustomColors.red,
      textColor: CustomColors.black,
      fontSize: 16.0,
    );
  }
}

dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
