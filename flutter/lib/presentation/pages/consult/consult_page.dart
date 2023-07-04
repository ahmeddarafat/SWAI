import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/dummy_data/dummy_data.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import '../../../resources/constants/app_assets.dart';
import '../../../resources/constants/app_strings.dart';
import '../../../resources/styles/app_colors.dart';
import '../../widgets/public_text.dart';
import '../../widgets/public_text_form_field.dart';
import 'components/category_card.dart';
import 'components/doctor_list_tile.dart';

class ConsultPage extends StatefulWidget {
  const ConsultPage({super.key});

  @override
  State<ConsultPage> createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PublicText(
                        txt: AppStrings.findDoctor,
                        color: AppColors.black,
                        fw: FontWeight.bold,
                        size: 25.sp,
                        align: TextAlign.start,
                      ),
                      PublicText(
                        txt: AppStrings.theSuitableForYourCase,
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
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.myProfile),
                    child: CircleAvatar(
                      maxRadius: 20.w,
                      backgroundImage: const AssetImage(AppImages.profile),
                    ),
                  )
                ],
              ),
            ),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PublicText(
                  txt: AppStrings.categories,
                  size: 18.sp,
                  fw: FontWeight.w500,
                ),
                InkWell(
                  onTap: () {},
                  child: PublicText(
                    txt: AppStrings.veiwAll,
                    size: 14.sp,
                    color: AppColors.lightBlue,
                  ),
                )
              ],
            ),
            15.ph,
            SizedBox(
              height: 100.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {},
                  child: CategoryCard(index: index),
                ),
                separatorBuilder: (_, __) => 5.pw,
              ),
            ),
            20.ph,
            PublicTextFormField(
              showprefixIcon: true,
              prefixIcon: Icons.search,
              hint: "Search",
              controller: _searchController,
              validator: null,
              borderRadius: 12,
            ),
            15.ph,
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.doctorProfile,
                        arguments: doctorInfo);
                  },
                  child: DoctorListTile(doctor: doctorInfo),
                ),
                separatorBuilder: (_, __) => 5.ph,
              ),
            )
          ],
        ),
      ),
    );
  }
}
