import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/measurements_model.dart';
import 'package:google_solution2/data/network/api_service.dart';
import 'package:google_solution2/presentation/resources/constants/app_strings.dart';
import 'package:google_solution2/presentation/resources/widgets/public_text.dart';
import 'package:google_solution2/presentation/viewmodel/dashboard/dashboard_cubit.dart';
import 'package:intl/intl.dart';
import 'package:google_solution2/presentation/resources/styles/app_colors.dart';

import '../../data/repository/repo.dart';
import '../resources/constants/app_constants.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final ApiService _apiService = ApiService();
  late final Repo repo;

  void request(BuildContext context) {
    DashboardCubit.get(context).getMeasurements(repo);
  }

  void requestStream(BuildContext context) async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (context.mounted) {
        request(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    repo = Repo(apiService: _apiService);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    requestStream(context);
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        elevation: 0.0,
        title: PublicText(
          txt: "SWAI",
          color: AppColors.purple,
          size: 20.sp,
          fw: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_rounded,
              color: AppColors.purple,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          child: Column(
            children: [
              Card(
                color: AppColors.white,
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.sunny,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 5.w),
                      const Text("23 ${AppStrings.temperatureUnit}"),
                      const Spacer(),
                      Text(DateFormat("dd MMM yyyy").format(DateTime.now()))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: GridView.builder(
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 200 / 190,
                      crossAxisSpacing: 5.w,
                      mainAxisSpacing: 5.w,
                    ),
                    itemBuilder: (context, index) {
                      return MeasurmentCard(
                        title: AppConstants.titles[index],
                        icon: AppConstants.icons[index],
                        unit: AppConstants.units[index],
                        index: index,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeasurmentCard extends StatelessWidget {
  final String title;
  final String icon;
  final String unit;
  final int index;
  const MeasurmentCard({
    super.key,
    required this.title,
    required this.icon,
    required this.index,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (_, __) {},
      builder: (context, state) {
        log("the card is rebuilt");
        var cubit = DashboardCubit.get(context);
        int measurement = getMeasurement(index, cubit.measurements).toInt();
        return Card(
          color: AppColors.white,
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  icon,
                  color: AppColors.purple,
                  height: 20.h,
                  width: 20.h,
                ),
                SizedBox(height: 10.h),
                PublicText(
                  txt: title,
                  color: AppColors.purple,
                  size: 16.sp,
                  fw: FontWeight.bold,
                ),
                SizedBox(height: 10.h),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppColors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                          text: "$measurement ",
                          style: TextStyle(fontSize: 35.sp)),
                      TextSpan(text: unit, style: TextStyle(fontSize: 20.sp)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double getMeasurement(int index, MeasurementsModel model) {
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
}
