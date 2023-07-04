import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/category_model.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/public_text.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  const CategoryCard({
    super.key,
    required this.index,
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
                categories[index].icon,
                color: AppColors.lightBlue,
                height: 35.h,
                width: 35.h,
              ),
              PublicText(
                txt: categories[index].name,
                size: 14.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
