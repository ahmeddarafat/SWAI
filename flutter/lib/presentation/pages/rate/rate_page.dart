import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/logic/rate/rate_logic.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/di/di.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';
import 'package:google_solution2/resources/widgets/public_text.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../data/data_object/data_object.dart';

import '../../widgets/heart_rate/measurement_column.dart';

class RatePage extends StatefulWidget {
  final RateDataObject dataObject;
  const RatePage({super.key, required this.dataObject});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  final logic = getIt<RateLogic>();

  @override
  void initState() {
    super.initState();
    logic.getPoints();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.dataObject;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: PublicText(txt: data.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h, right: 15.w, left: 10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.h),
                  FlutterDatePickerTimeline(
                    startDate: DateTime.now().subtract(const Duration(days: 2)),
                    endDate: DateTime(2024, 12, 30),
                    initialSelectedDate: DateTime.now(),
                    selectedItemBackgroundColor:
                        AppColors.lightBlue.withOpacity(0.2),
                    selectedItemTextStyle: const TextStyle(
                        color: AppColors.lightBlue,
                        fontWeight: FontWeight.bold),
                    unselectedItemTextStyle: const TextStyle(
                        color: AppColors.whiteGrey,
                        fontWeight: FontWeight.bold),
                    onSelectedDateChange: (DateTime? dateTime) {
                      // TODO: impelement onSelectedDateChange
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
                            text: "${data.measurement} ",
                            style: TextStyle(
                                fontSize: 30.sp, fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: data.unit,
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SfCartesianChart(
                    primaryXAxis: DateTimeAxis(
                      maximum: DateTime(0, 0, 0, 24, 0),
                      minimum: DateTime(0, 0, 0, 0, 0),
                      interval: 6,
                      dateFormat: DateFormat.Hm(),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      maximum: data.maxRange,
                      minimum: data.minRange,
                      interval: data.interval,
                    ),
                    series: [
                      SplineSeries<RateData, DateTime>(
                          // Bind data source
                          dataSource: rateDataSource,
                          xValueMapper: (RateData measurement, _) =>
                              measurement.time,
                          yValueMapper: (RateData measurement, _) =>
                              measurement.number)
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.darkBlue,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MeasurementColumn(
                        number: data.avg,
                        type: AppStrings.avg,
                        unit: data.unit,
                      ),
                      MeasurementColumn(
                        number: data.min,
                        type: AppStrings.min,
                        unit: data.unit,
                      ),
                      MeasurementColumn(
                        number: data.max,
                        type: AppStrings.max,
                        unit: data.unit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<RateData> rateDataSource = [
  RateData(DateTime(0, 0, 0, 0), 60),
  RateData(DateTime(0, 0, 0, 5), 80),
  RateData(DateTime(0, 0, 0, 6), 65),
  RateData(DateTime(0, 0, 0, 7), 40),
  RateData(DateTime(0, 0, 0, 8), 90),
  RateData(DateTime(0, 0, 0, 11), 78),
  // HeartRateData('16:00', 80),
  // HeartRateData('17:00', 180),
  RateData(DateTime(0, 0, 0, 17), 100),
  RateData(DateTime(0, 0, 0, 23), 80),
];



// TODO: SfCartesianChart
// -------------------- SfCartesianChart -------------------------
// ---------------------------------------------------------------
// [1] It's a data visualization library for creating beautiful, animated and high-performance charts
// ---------------------------------------------------------------