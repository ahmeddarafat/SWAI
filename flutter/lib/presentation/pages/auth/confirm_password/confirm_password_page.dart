import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';

import '../../../../resources/constants/app_assets.dart';
import '../../../../resources/constants/app_strings.dart';
import '../../../../resources/router/app_router.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/global/public_button.dart';
import '../../../widgets/global/public_text.dart';

class ConfirmPasswordPage extends StatelessWidget {
  const ConfirmPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(30.w),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppImages.auth,
                  height: 250.h,
                  width: double.infinity,
                ),
                30.ph,
                PublicText(
                  txt: AppStrings.confirmPassContent,
                  color: AppColors.darkBlue,
                  size: 17.sp,
                  align: TextAlign.center,
                ),
                30.ph,
                PublicButton(
                  title: AppStrings.login,
                  onPressed: () {
                    // TODO: "data" - request to change pass
                    // demo code
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
