import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';
import 'package:google_solution2/presentation/widgets/global/public_button.dart';
import 'package:google_solution2/presentation/widgets/global/public_text.dart';

import '../../../../resources/constants/app_assets.dart';
import '../../../../resources/constants/app_constants.dart';

class DoctorProfilePage extends StatelessWidget {
  final DoctorInfoModel doctor;
  const DoctorProfilePage({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: <Widget>[
                SizedBox(
                  height: 280.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                    child: Image.network(
                      doctor.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 15.h,
                  left: 15.w,
                  child: Container(
                    height: 35.h,
                    width: 35.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.lightBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.ph,
                      PublicText(
                        txt: doctor.name,
                        size: 24.sp,
                        fw: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                      5.ph,
                      Row(
                        children: [
                          Image.asset(
                            generateSpecialtyImage(doctor.specialty),
                            height: 12.h,
                            width: 12.h,
                            color: AppColors.darkBlue,
                          ),
                          5.pw,
                          PublicText(
                            txt: doctor.specialty,
                            size: 18.sp,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                      10.ph,
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: AppColors.grey,
                            size: 18.sp,
                          ),
                          5.pw,
                          PublicText(
                            txt: "${doctor.patients}",
                            size: 16.sp,
                            color: AppColors.grey,
                          ),
                          const Spacer(),
                          Icon(
                            Icons.badge,
                            color: AppColors.grey,
                            size: 16.sp,
                          ),
                          5.pw,
                          PublicText(
                            txt: "${doctor.experience} Years",
                            size: 16.sp,
                            color: AppColors.grey,
                          ),
                          const Spacer(),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16.sp,
                          ),
                          5.pw,
                          PublicText(
                            txt: "${doctor.rate}",
                            size: 16.sp,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                      20.ph,
                      PublicText(
                        txt: AppStrings.availableTime,
                        size: 18.sp,
                        color: AppColors.darkBlue,
                        fw: FontWeight.w500,
                      ),
                      10.ph,
                      SizedBox(
                        height: 80.h,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          itemBuilder: (_, index) => SizedBox(
                            height: 80.h,
                            width: 80.w,
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PublicText(
                                        txt: Constants.weekDays[index],
                                        color: AppColors.darkBlue,
                                        size: 16.sp),
                                    PublicText(
                                      txt: doctor.availableTime[index],
                                      size: 14.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (_, __) => 5.pw,
                        ),
                      ),
                      20.ph,
                      PublicText(
                        txt: AppStrings.description,
                        size: 18.sp,
                        color: AppColors.darkBlue,
                        fw: FontWeight.w500,
                      ),
                      10.ph,
                      PublicText(
                        txt: doctor.description,
                        color: AppColors.grey,
                        max: 20,
                        size: 14.sp,
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: PublicButton(
                onPressed: () {},
                title: AppStrings.makeAppointment,
                borderRadius: 12,
                verticalpadding: 16.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String generateSpecialtyImage(String specialty) {
    switch (specialty) {
      case AppStrings.dentist:
        return AppIcons.tooth;
      case AppStrings.ophthalmologist:
        return AppIcons.eye;
      case AppStrings.otolaryngologist:
        return AppIcons.ear;
      case AppStrings.pharmacist:
        return AppIcons.drugs;
      case AppStrings.nutritionist:
        return AppIcons.nutrition;
      case AppStrings.neurologist:
        return AppIcons.brain;
      case AppStrings.cardiologist:
        return AppIcons.heartAttack;
      default:
        return AppIcons.pharmacy;
    }
  }
}
