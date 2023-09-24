import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';

import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/public_text.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: PublicText(
            txt:"About App",
            fw: FontWeight.bold,
            size: 22.sp,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            color: AppColors.darkBlue,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PublicText(
                  txt: AppStrings.aboutTitle,
                  fw: FontWeight.w500,
                  size: 20.sp,
                ),
                32.ph,
                 PublicText(
                  txt: AppStrings.aboutBody.toPieces(),
                  max: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}