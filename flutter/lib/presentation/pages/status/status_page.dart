import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../resources/constants/app_assets.dart';
import '../../../resources/di/di.dart';

import '../../../data/repository/repository.dart';
import '../../../logic/dashboard/dashboard_cubit.dart';
import '../../../resources/constants/app_strings.dart';
import '../../../resources/styles/app_colors.dart';
import '../../../resources/widgets/public_text.dart';
import '../../widgets/status/measurment_card.dart';
import '../../../resources/constants/app_constants.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final repo = getIt<RepositoryImpl>();

  void request(BuildContext context) {
    DashboardCubit.get(context).getMeasurements(repo);
  }

  void requestStream(BuildContext context) async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (context.mounted) {
        request(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: use request stream
    // requestStream(context);
    // request(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          right: 20.w,
          left: 20.w,
          top: 30.h,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PublicText(
                        txt: AppStrings.healthStatus,
                        color: AppColors.black,
                        fw: FontWeight.bold,
                        size: 25.sp,
                      ),
                      PublicText(
                        txt: AppStrings.checkHealth,
                        color: AppColors.grey,
                        size: 14.sp,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    AppIcons.messenger,
                    color: AppColors.grey,
                    height: 20.h,
                    width: 20.h,
                  ),
                  SizedBox(width: 20.w),
                  CircleAvatar(
                    maxRadius: 20.w,
                    backgroundImage: const AssetImage(AppImages.profile),
                  )
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 150 / 200,
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 5.w,
                ),
                itemBuilder: (context, index) {
                  return MeasurmentCard(
                    title: UIConstants.titles[index],
                    icon: UIConstants.icons[index],
                    unit: UIConstants.units[index],
                    index: index,
                    color: index % 3 == 0
                        ? AppColors.lightBlue
                        : AppColors.darkBlue,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// TODO: Archive
// Card(
//               color: AppColors.white,
//               elevation: 5,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.sunny,
//                       color: Colors.yellow,
//                     ),
//                     SizedBox(width: 5.w),
//                     const Text("23 ${AppStrings.temperatureUnit}"),
//                     const Spacer(),
//                     Text(DateFormat("dd MMM yyyy").format(DateTime.now()))
//                   ],
//                 ),
//               ),
//             ),