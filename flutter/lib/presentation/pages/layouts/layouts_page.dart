import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/presentation/pages/consult/consult_page.dart';
import 'package:google_solution2/presentation/pages/home/home_page.dart';
import 'package:google_solution2/presentation/pages/status/status_page.dart';
import 'package:google_solution2/presentation/pages/stores/stores_page.dart';
import 'package:google_solution2/resources/constants/app_assets.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';

import '../articles/articles_page.dart';

class LayoutsPage extends StatefulWidget {
  const LayoutsPage({super.key});

  @override
  State<LayoutsPage> createState() => _LayoutsPageState();
}

class _LayoutsPageState extends State<LayoutsPage> {
  int _currentIndex = 2;

  List<Widget> pages = [
    const HomePage(),
    const ConsultPage(),
    const StatusPage(),
    const StoresPage(),
    const ArticlesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight: 0),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.lightBlue,
          unselectedItemColor: AppColors.whiteGrey,
          showUnselectedLabels: false,
          iconSize: 25.h,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
             BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage(AppIcons.home),
                size: 25.h,
              ),
              label: AppStrings.home,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage(
                  AppIcons.blogger,
                ),
                size: 25.h,
              ),
              label: AppStrings.consult,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage(AppIcons.pharmacy),
                size: 25.h,
              ),
              label: AppStrings.status,
            ),
             BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage(AppIcons.doctorBag),
                size: 25.h,
              ),
              label: AppStrings.store,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage(AppIcons.news),
                size: 25.h,
              ),
              label: AppStrings.articles,
            ),
          ],
        ),
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
