import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../resources/constants/app_strings.dart';
import '../../../resources/extensions/extensions.dart';
import '../../../resources/router/app_router.dart';

import '../../../data/model/measurements_model.dart';
import '../../../data/model/rate_data_model.dart';
import '../../../logic/dashboard/dashboard_cubit.dart';
import '../../../resources/styles/app_colors.dart';
import '../../../resources/widgets/public_text.dart';

class MeasurmentCard extends StatelessWidget {
  final String title;
  final String icon;
  final String unit;
  final int index;
  final Color color;
  const MeasurmentCard({
    super.key,
    required this.title,
    required this.icon,
    required this.index,
    required this.unit,
    this.color = AppColors.darkBlue,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (_, __) {},
      builder: (context, state) {
        var cubit = DashboardCubit.get(context);
        double measurement = _getMeasurement(index, cubit.measurements);
        return InkWell(
          onTap: () => _navigateTo(context, title, measurement),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            color: color,
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                              text: "${measurement.orAbout()} ",
                              style: TextStyle(fontSize: 25.sp)),
                          TextSpan(
                            text: unit,
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Image.asset(
                    icon,
                    color: Colors.white,
                    height: 60.h,
                    // width: 50.h,
                  ),
                  SizedBox(height: 20.h),
                  PublicText(
                    txt: title,
                    color: Colors.white,
                    size: 16.sp,
                    fw: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double _getMeasurement(int index, MeasurementsModel model) {
    switch (index) {
      case 0:
        return model.heartRate;
      case 1:
        return model.temperature;
      case 2:
        return model.oxygenRate;
      case 3:
        return model.glucoseRate;
      default:
        return 0;
    }
  }

  void _navigateTo(BuildContext context, String title, double measurement) {
    late final RateDataModel dataObject;
    switch (title) {
      case AppStrings.heartRate:
        dataObject = RateDataModel(
          title: title,
          measurement: measurement,
          unit: unit,
          maxRange: 120,
          minRange: 40,
          interval: 20,
        );
        Navigator.pushNamed(context, AppRoutes.rate,
            arguments: dataObject);
        break;
      case AppStrings.temperature:
        dataObject = RateDataModel(
          title: title,
          measurement: measurement,
          unit: unit,
          maxRange: 46,
          minRange: 30,
          interval: 4,
        );
        Navigator.pushNamed(context, AppRoutes.rate,
            arguments: dataObject);
        break;
      case AppStrings.oxygenRate:
        dataObject = RateDataModel(
          title: title,
          measurement: measurement,
          unit: unit,
          maxRange: 110,
          minRange: 70,
          interval: 8,
        );
        Navigator.pushNamed(context, AppRoutes.rate,
            arguments: dataObject);
        break;
      case AppStrings.glucoseRate:
        dataObject = RateDataModel(
          title: title,
          measurement: measurement,
          unit: unit,
          maxRange: 220,
          minRange: 70,
          interval: 30,
        );
        Navigator.pushNamed(context, AppRoutes.rate,
            arguments: dataObject);
        break;
      default:
        break;
    }
  }
}
