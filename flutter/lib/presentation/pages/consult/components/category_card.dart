import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/category_model.dart';
import '../../../../resources/constants/app_constants.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/public_text.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 80.w,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                category.icon,
                color: AppColors.lightBlue,
                height: 35.h,
                width: 35.h,
              ),
              PublicText(
                txt: category.name,
                size: 14.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
