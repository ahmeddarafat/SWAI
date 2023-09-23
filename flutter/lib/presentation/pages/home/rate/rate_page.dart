import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/logic/home/rate/cubit/rate_cubit.dart';
import 'package:google_solution2/logic/home/rate/rate_logic.dart';
import '../../../../data/dummy_data/dummy_data.dart';
import '../../../../data/model/statistics_model.dart';
import '../../../../resources/constants/app_strings.dart';
import '../../../../resources/di/di.dart';
import '../../../../resources/extensions/extensions.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/public_text.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../data/model/point_model.dart';
import '../../../../data/model/rate_data_model.dart';
import 'components/measurement_column.dart';

class RatePage extends StatefulWidget {
  final RateDataModel dataObject;
  const RatePage({super.key, required this.dataObject});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  final logic = getIt<RateLogic>();
  late final RateDataModel data;

  @override
  void initState() {
    super.initState();
    data = widget.dataObject;
  }

  @override
  Widget build(BuildContext context) {
    var cubit = RateCubit.get(context);
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
                    onSelectedDateChange: (DateTime? date) {
                      if (date != null) cubit.changeDate(date);
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
                            text: "${data.measurement.orAbout()} ",
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
                  BlocBuilder<RateCubit, RateState>(
                    builder: (context, state) {
                      return FutureBuilder<List<PointModel>>(
                        future: logic.getPoints(data.title),
                        builder: (context, snapshot) {
                          return SfCartesianChart(
                            primaryXAxis: DateTimeAxis(
                              maximum: DateTime(
                                cubit.selectedDate.year,
                                cubit.selectedDate.month,
                                cubit.selectedDate.day,
                                24,
                                0,
                              ),
                              minimum: DateTime(
                                cubit.selectedDate.year,
                                cubit.selectedDate.month,
                                cubit.selectedDate.day,
                                0,
                                0,
                              ),
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
                              SplineSeries<PointModel, DateTime>(
                                // TODO: remove dummy data
                                // snapshot.data ??
                                dataSource: rateDataSource,
                                xValueMapper: (PointModel measurement, _) =>
                                    measurement.time,
                                yValueMapper: (PointModel measurement, _) =>
                                    measurement.number,
                              )
                            ],
                          );
                        },
                      );
                    },
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
                  child: FutureBuilder<StatisticsModel>(
                      future: logic.getStatistics(data.title),
                      builder: (context, snapshot) {
                        StatisticsModel statistic;
                        if (snapshot.hasData) {
                          statistic = snapshot.data!;
                        } else {
                          statistic = StatisticsModel(max: 0, min: 0, avg: 0);
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MeasurementColumn(
                              number: statistic.avg,
                              type: AppStrings.avg,
                              unit: data.unit,
                            ),
                            MeasurementColumn(
                              number: statistic.min,
                              type: AppStrings.min,
                              unit: data.unit,
                            ),
                            MeasurementColumn(
                              number: statistic.max,
                              type: AppStrings.max,
                              unit: data.unit,
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: SfCartesianChart
// -------------------- SfCartesianChart -------------------------
// ---------------------------------------------------------------
// [1] It's a data visualization library for creating beautiful, animated and high-performance charts
// ---------------------------------------------------------------
