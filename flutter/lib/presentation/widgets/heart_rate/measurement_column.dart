import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';

import '../../../resources/constants/app_strings.dart';
import '../../../resources/styles/app_colors.dart';
import '../../../resources/widgets/public_text.dart';

class MeasurementColumn extends StatelessWidget {
  final String type;
  final double number;
  final String unit;
  const MeasurementColumn({
    super.key, required this.type, required this.number,required this.unit
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: const TextStyle(
              color: AppColors.white,
            ),
            children: [
              TextSpan(
                text: "${number.orAbout()} ",
                style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: unit,
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
        const Spacer(),
        PublicText(
          txt: type,
          color: Colors.white70,
          size: 15.sp,
        )
      ],
    );
  }
}