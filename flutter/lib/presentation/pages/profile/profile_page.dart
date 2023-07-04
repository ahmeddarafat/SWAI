import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_solution2/presentation/widgets/public_text.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';

import '../../../resources/constants/app_assets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: PublicText(
            txt: AppStrings.profile,
            color: AppColors.darkBlue,
            fw: FontWeight.bold,
            size: 20.sp,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 35.w,
                      backgroundImage: const AssetImage(AppImages.profile),
                    ),
                    20.pw,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PublicText(
                          txt: "Ahmed Arafat",
                          color: AppColors.darkBlue,
                          size: 22.sp,
                          fw: FontWeight.bold,
                        ),
                        PublicText(
                          txt: "ahmed.arafat@gmail.com",
                          color: AppColors.grey,
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                40.ph,
                ListTile(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.myProfile),
                  leading: const Icon(
                    CupertinoIcons.person,
                    color: AppColors.darkBlue,
                  ),
                  title: const PublicText(
                    txt: AppStrings.myProfile,
                    color: AppColors.darkBlue,
                    align: TextAlign.start,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.settings,
                    color: AppColors.darkBlue,
                  ),
                  title: const PublicText(
                    txt: AppStrings.settings,
                    color: AppColors.darkBlue,
                    align: TextAlign.start,
                  ),
                ),
                ListTile(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.notifications),
                  leading: const Icon(
                    CupertinoIcons.bell,
                    color: AppColors.darkBlue,
                  ),
                  title: const PublicText(
                    txt: AppStrings.notifications,
                    color: AppColors.darkBlue,
                    align: TextAlign.start,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    CupertinoIcons.list_bullet,
                    color: AppColors.darkBlue,
                  ),
                  title: const PublicText(
                    txt: AppStrings.transactionHistroy,
                    color: AppColors.darkBlue,
                    align: TextAlign.start,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.help_outline_rounded,
                    color: AppColors.darkBlue,
                  ),
                  title: const PublicText(
                    txt: AppStrings.fqa,
                    color: AppColors.darkBlue,
                    align: TextAlign.start,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    CupertinoIcons.exclamationmark_circle,
                    color: AppColors.darkBlue,
                  ),
                  title: const PublicText(
                    txt: AppStrings.aboutApp,
                    color: AppColors.darkBlue,
                    align: TextAlign.start,
                  ),
                ),
                30.ph,
                ListTile(
                  onTap: () {
                    // TODO: "Data" - logout
                  },
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: const PublicText(
                    txt: AppStrings.logout,
                    color: AppColors.darkBlue,
                    align: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
