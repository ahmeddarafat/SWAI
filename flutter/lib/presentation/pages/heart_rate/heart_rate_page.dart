import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';
import 'package:google_solution2/resources/widgets/public_text.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HeartRatePage extends StatelessWidget {
  final int measurement;
  const HeartRatePage({super.key, required this.measurement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const PublicText(txt: AppStrings.heartRate),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              FlutterDatePickerTimeline(
                startDate: DateTime.now().subtract(const Duration(days: 2)),
                endDate: DateTime(2024, 12, 30),
                initialSelectedDate: DateTime.now(),
                selectedItemBackgroundColor:
                    AppColors.lightBlue.withOpacity(0.2),
                selectedItemTextStyle: const TextStyle(
                    color: AppColors.lightBlue, fontWeight: FontWeight.bold),
                unselectedItemTextStyle: const TextStyle(
                    color: AppColors.whiteGrey, fontWeight: FontWeight.bold),
                onSelectedDateChange: (DateTime? dateTime) {
                  log(dateTime.toString());
                },
              ),
              SizedBox(height: 30.h),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: const TextStyle(
                    color: AppColors.darkBlue,
                  ),
                  children: [
                    TextSpan(
                        text: "$measurement ",
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: AppStrings.heartRateUnit,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                child: SfCartesianChart(
                  
                  primaryXAxis: CategoryAxis(
                  ),
                  primaryYAxis: NumericAxis(
                    maximum: 240,
                    minimum: 40,
                    interval: 40,

                  ),
                  series: [
                    SplineSeries<HeartRateData, String>(
                        // Bind data source
                        dataSource: heartRateDataSource,
                        xValueMapper: (HeartRateData measurement, _) =>
                            measurement.time,
                        yValueMapper: (HeartRateData measurement, _) =>
                            measurement.number)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HeartRateData {
  HeartRateData(this.time, this.number);
  final String time;
  final double number;
}

List<HeartRateData> heartRateDataSource = [
  HeartRateData('00:00', 80),
  HeartRateData('06:00', 130),
  HeartRateData('12:00', 100),
  // HeartRateData('16:00', 80),
  // HeartRateData('17:00', 180),
  HeartRateData('18:00', 140),
  HeartRateData('24:00', 90),
];
