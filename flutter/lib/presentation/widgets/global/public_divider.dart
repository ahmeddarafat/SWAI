import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';

class PublicDivider extends StatelessWidget {
  final double? width;
  const PublicDivider({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteGrey,
      height: 0.8,
      width: width ?? 100.w,
    );
  }
}
