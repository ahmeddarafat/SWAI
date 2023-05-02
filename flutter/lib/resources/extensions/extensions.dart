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
