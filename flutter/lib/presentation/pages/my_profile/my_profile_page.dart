import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/presentation/widgets/public_text.dart';
import 'package:google_solution2/presentation/widgets/public_text_form_field.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';

import '../../../resources/constants/app_assets.dart';
import '../../widgets/public_button.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: PublicText(
            txt: AppStrings.myProfile,
            color: AppColors.darkBlue,
            fw: FontWeight.bold,
            size: 20.sp,
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.darkBlue,
              )),
        ),
        body: Column(
          children: [
            15.ph,
            Stack(
              children: [
                CircleAvatar(
                  maxRadius: 50.w,
                  backgroundImage: const AssetImage(AppImages.profile),
                ),
                Positioned(
                  right: 2.w,
                  bottom: 2.h,
                  child: InkWell(
                    onTap: () {
                      // TODO: "Logic" - image picker
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.lightBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            40.ph,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PublicText(
                        txt: AppStrings.basicDetails,
                        color: AppColors.darkBlue,
                        size: 18.sp,
                        fw: FontWeight.bold,
                      ),
                      20.ph,
                      PublicText(
                        txt: AppStrings.fullName,
                        color: AppColors.grey,
                        size: 14.sp,
                      ),
                      5.ph,
                      PublicTextFormField(
                        hint: "Ahmed Arafat",
                        borderRadius: 12,
                        controller: TextEditingController(),
                        validator: (name) => null,
                      ),
                      20.ph,
                      PublicText(
                        txt: AppStrings.dateOfBirth,
                        color: AppColors.grey,
                        size: 14.sp,
                      ),
                      5.ph,
                      InkWell(
                        onTap: () async {
                          var birthDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.whiteGrey,
                              width: 0.5,
                            ),
                          ),
                          child: PublicText(
                            txt: "7 Jul 2002",
                            align: TextAlign.start,
                            color: Colors.black54,
                            size: 15.sp,
                          ),
                        ),
                      ),
                      20.ph,
                      PublicText(
                        txt: AppStrings.gender,
                        color: AppColors.grey,
                        size: 14.sp,
                      ),
                      5.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: PublicText(
                                txt: "Male",
                                color: AppColors.darkBlue,
                                size: 16.sp,
                                align: TextAlign.start,
                              ),
                              leading: Radio(
                                value: "male",
                                groupValue: "male",
                                onChanged: (value) {
                                  // TODO: Logic: radio button
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: PublicText(
                                txt: "Female",
                                color: AppColors.darkBlue,
                                size: 16.sp,
                                align: TextAlign.start,
                              ),
                              leading: Radio(
                                value: "female",
                                groupValue: "male",
                                onChanged: (value) {
                                  // TODO: Logic: radio button
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      25.ph,
                      PublicText(
                        txt: AppStrings.contactDetails,
                        color: AppColors.darkBlue,
                        size: 18.sp,
                        fw: FontWeight.bold,
                      ),
                      20.ph,
                      PublicText(
                        txt: AppStrings.mobileNumber,
                        color: AppColors.grey,
                        size: 14.sp,
                      ),
                      5.ph,
                      PublicTextFormField(
                        hint: "01060561548",
                        borderRadius: 12,
                        controller: TextEditingController(),
                        validator: (name) => null,
                      ),
                      20.ph,
                      PublicText(
                        txt: AppStrings.address,
                        color: AppColors.grey,
                        size: 14.sp,
                      ),
                      5.ph,
                      PublicTextFormField(
                        hint: "12, Street",
                        borderRadius: 12,
                        controller: TextEditingController(),
                        validator: (name) => null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: PublicButton(
                onPressed: () {
                  // TODO: "Logic,Data" - Validate, save data whithshared prefs
                },
                title: AppStrings.save,
                borderRadius: 12,
                verticalpadding: 16.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
