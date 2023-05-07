import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizedBoxExtension on num {
  SizedBox get ph => SizedBox(height: toDouble().h);
  SizedBox get pw => SizedBox(width: toDouble().w);
}

extension DoubleExtension on num {
  num orAbout() {
    if ((this * 10) % 10 == 0) {
      return toInt();
    }
    return this;
  }
}

extension StringExtension on String {
  String get capitalizd {
    String str = "";
    toLowerCase();
    List<String> list = split(" ");
    for (int i = 0; i < list.length; i++) {
      str +=
          "${list[i][0].toUpperCase()}${list[i].substring(1).toLowerCase()} ";
    }
    str = str.replaceRange(str.length - 1, str.length, "");
    return str;
  }
}
