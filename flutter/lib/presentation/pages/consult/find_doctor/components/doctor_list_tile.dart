import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import '../../../../../resources/constants/app_assets.dart';
import '../../../../../resources/styles/app_colors.dart';
import '../../../../widgets/global/public_text.dart';

class DoctorListTile extends StatelessWidget {
  final DoctorInfoModel doctor;
  const DoctorListTile({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      width: double.infinity,
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Row(
          children: [
            Container(
              height: 80.h,
              width: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                doctor.image,
                fit: BoxFit.cover,
              ),
            ),
            8.pw,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ...generateStars(doctor.rate),
                    2.pw,
                    PublicText(
                      txt: "(${doctor.reviews} reviews)",
                      size: 12.sp,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                PublicText(
                  txt: doctor.name,
                  size: 18.sp,
                  fw: FontWeight.bold,
                ),
                Row(
                  children: [
                    Image.asset(
                      generateSpecialtyImage(doctor.specialty),
                      color: AppColors.grey,
                      height: 11.h,
                      width: 11.h,
                    ),
                    2.pw,
                    PublicText(
                      txt: "${doctor.specialty}, ",
                      size: 12.sp,
                      color: AppColors.grey,
                    ),
                    3.pw,
                    Image.asset(
                      AppIcons.stethoscope,
                      color: AppColors.grey,
                      height: 13.h,
                      width: 13.h,
                    ),
                    2.pw,
                    PublicText(
                      txt: " +${doctor.experience} years",
                      size: 12.sp,
                      color: AppColors.grey,
                    ),
                    5.pw,
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //* helper methods
  List<Widget> generateStars(double rate) {
    return [
      for (var i = 0; i < rate.round(); i++)
        Icon(
          Icons.star,
          size: 12.sp,
          color: Colors.yellow,
        ),
      for (var i = 0; i < (5 - rate.round()); i++)
        Icon(
          Icons.star_border_outlined,
          size: 12.sp,
          color: Colors.yellow,
        ),
    ];
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
