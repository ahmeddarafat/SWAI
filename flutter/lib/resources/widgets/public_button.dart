import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/resources/widgets/public_text.dart';
import '../styles/app_colors.dart';

class PublicButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double width;
  final double borderRadius;
  final double? titleSize;
  final Color titleColor;
  final double verticalpadding;

  const PublicButton({
    Key? key,
    required this.onPressed,
    this.titleSize,
    this.title = "",
    this.width = double.infinity,
    this.borderRadius = 24,
    this.titleColor = Colors.white,
    this.verticalpadding = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightBlue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalpadding),
          child: PublicText(
            txt: title,
            size: titleSize ?? 18.sp,
            color: titleColor,
            fw: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
