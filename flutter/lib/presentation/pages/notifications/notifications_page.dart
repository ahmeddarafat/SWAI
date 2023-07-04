import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';

import '../../../resources/constants/app_strings.dart';
import '../../../resources/styles/app_colors.dart';
import '../../widgets/public_text.dart';
import 'components/notfication_tile.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: PublicText(
            txt: AppStrings.notifications,
            color: AppColors.darkBlue,
            fw: FontWeight.bold,
            size: 20.sp,
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.darkBlue,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: AppColors.darkBlue,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (_, index) {
              return const NotificationTile();
            },
            itemBuilder: (_, index) {
              return 30.ph;
            },
          ),
        ),
      ),
    );
  }
}


