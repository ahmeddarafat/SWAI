import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';

import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/public_text.dart';

// TODO: "Date" - make notification model
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.lightBlue.withOpacity(0.1),
              ),
              child:  Icon(
                CupertinoIcons.exclamationmark_circle,
                color: AppColors.lightBlue,
                size: 18.sp,
              ),
            ),
            10.pw,
            PublicText(
              txt: "Your order is arrived",
              color: AppColors.darkBlue,
              fw: FontWeight.bold,
              size: 18.sp,
            ),
            const Spacer(),
            PublicText(
              txt: "30m",
              color: AppColors.darkGrey,
              size: 18.sp,
            ),
          ],
        ),
        10.ph,
        const PublicText(
          txt:
              "Your notifcation is arraial to you when Your order is arrived, Your order is arrived don't do it",
          color: AppColors.grey,
          align: TextAlign.start,
          max: 2,
        ),
      ],
    );
  }
}
