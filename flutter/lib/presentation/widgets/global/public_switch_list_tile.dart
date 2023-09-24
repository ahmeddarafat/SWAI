import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/presentation/widgets/global/public_text.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';


enum Switchers {
  darkMode,
  rememberMe,
  notifications
}

class PublicSwitchListTile extends StatefulWidget {
  final String title;
  final Switchers swithcer;
  final Icon? icon;
  const PublicSwitchListTile({
    super.key,
    required this.title,
    required this.swithcer,
    this.icon,
  });

  @override
  State<PublicSwitchListTile> createState() => _PublicSwitchListTileState();
}

class _PublicSwitchListTileState extends State<PublicSwitchListTile> {
  bool switcherValue = false;
  // final appPrefs = getIt<AppPrefs>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: widget.icon,
      title: PublicText(
        txt: widget.title,
        color: AppColors.black,
        fw: FontWeight.w500,
        size: 16.sp,
      ),
      trailing: Transform.scale(
        scale: 0.8,
        child: CupertinoSwitch(
          onChanged: (value) {
            setState(() {
              switcherValue = value;
            });
            setSwitches(widget.swithcer, switcherValue);
          },
          value: switcherValue,
          activeColor: AppColors.lightBlue,
        ),
      ),
    );
  }

  // helper methods
  void setSwitches(Switchers switcher, bool value) {
    switch (switcher) {
      case Switchers.rememberMe:
        // appPrefs.setUserLoggedIn(value);
        break;
      default:
    }
  }
}
