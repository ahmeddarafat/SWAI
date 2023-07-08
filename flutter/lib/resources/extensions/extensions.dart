// import 'dart:developer';

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

extension StringExtension2 on String {
  String toPieces() {
    int j = 0;
    int start = 0;
    StringBuffer result = StringBuffer();
    // use -1 because we use i+1 in it
    for (int i = 0; i < length-1; i++) {
      j++;
      if (j > 200 && this[i] == "." && this[i+1] == " ") {
        result.write(substring(start, i));
        result.write(".\n\n");
        // +2 to skip the "." and " " (space)
        start = i + 2;
        j = 0;
      }
    }
    return result.toString();
  }
}
