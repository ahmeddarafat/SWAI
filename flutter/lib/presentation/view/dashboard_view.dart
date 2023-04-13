import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/presentation/resources/constants/app_assets.dart';
import 'package:google_solution2/presentation/resources/widgets/public_text.dart';
import 'package:intl/intl.dart';

import '../resources/styles/app_colors.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
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
                      const Text("23 C"),
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
                    childAspectRatio: 200/190,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.w,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      color: AppColors.white,
                      elevation: 5,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppIcons.heart,
                              color: AppColors.purple,
                              height: 20.h,
                              width: 20.h,
                            ),
                            SizedBox(height: 10.h),
                            PublicText(
                              txt: "Heart Rate",
                              color: AppColors.purple,
                              size: 18.sp,
                              fw: FontWeight.bold,
                            ),
                            SizedBox(height: 10.h),
                            const Spacer(),
                            RichText(
                              text:  TextSpan(
                                style: const TextStyle(
                                    color: AppColors.purple,
                                    fontWeight: FontWeight.bold,),
                                children: [
                                  TextSpan(text: "80 ",style: TextStyle(fontSize: 35.sp)),
                                  TextSpan(text: "BPM",style: TextStyle(fontSize: 20.sp)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
