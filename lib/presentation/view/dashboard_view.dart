import 'package:flutter/material.dart';
import 'package:google_solution2/presentation/resources/app_assets.dart';
import 'package:google_solution2/presentation/resources/app_colors.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.notifications_rounded),
          ),
          InkWell(
            onTap: (){},
            child:const  CircleAvatar(
              backgroundImage: AssetImage(AppAssets.profile),
            ),
          )
        ],

      ),
      body: null,
    );
  }
}