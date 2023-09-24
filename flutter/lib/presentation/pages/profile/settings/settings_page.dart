import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/presentation/widgets/global/public_switch_list_tile.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/global/public_divider.dart';
import '../../../widgets/global/public_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: PublicText(
            txt: "Settings",
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
          child: const Column(
            children: [
              PublicSwitchListTile(
                title: "Notificaitons",
                swithcer: Switchers.notifications,
              ),
              PublicDivider(width:double.infinity),
              PublicSwitchListTile(
                title: "Remember me",
                swithcer: Switchers.rememberMe,
              ),
              PublicDivider(width:double.infinity),
              PublicSwitchListTile(
                title: "Dark Mode",
                swithcer: Switchers.darkMode,
              ),
              PublicDivider(width:double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}
