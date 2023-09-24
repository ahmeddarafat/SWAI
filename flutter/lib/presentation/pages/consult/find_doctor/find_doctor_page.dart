import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/dummy_data/dummy_data.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/data/repository/repository.dart';
import 'package:google_solution2/logic/consult/consult_cubit.dart';
import 'package:google_solution2/resources/constants/app_constants.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import '../../../../resources/constants/app_assets.dart';
import '../../../../resources/constants/app_strings.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/global/public_text.dart';
import '../../../widgets/global/public_text_form_field.dart';
import 'components/category_card.dart';
import 'components/doctor_list_tile.dart';

class ConsultPage extends StatefulWidget {
  const ConsultPage({super.key});

  @override
  State<ConsultPage> createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {
  late final TextEditingController _searchController;

  Future<void> _bind() async {
    if (context.mounted) {
      var cubit = ConsultCubit.get(context);
      await cubit.getDoctors();
      cubit.changePysics();
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _bind();
  }

  @override
  void dispose() {
    _searchController.dispose();
    if (context.mounted) {
      var cubit = ConsultCubit.get(context);
      cubit.dipose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = ConsultCubit.get(context);
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
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.chats),
                    child: Image.asset(
                      AppIcons.messenger,
                      color: AppColors.grey,
                      height: 20.h,
                      width: 20.h,
                    ),
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
                  onTap: () {
                    cubit.removeFilter();
                  },
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
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: Constants.categories.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    cubit.filterDoctorsByLabel(
                      Constants.categories[index].label,
                    );
                  },
                  child: CategoryCard(category: Constants.categories[index]),
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
              onChanged: (value) {
                cubit.filterDoctorBySearch(value);
              },
            ),
            15.ph,
            Expanded(
              child: BlocBuilder<ConsultCubit, ConsultState>(
                builder: (context, state) {
                  if (state is ConsultLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ConsultErrorState) {
                    return const Center(
                      child: PublicText(txt: "Check your network"),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        cubit.getDoctorsRefresh();
                      },
                      child: ListView.separated(
                        physics: cubit.physics,
                        controller: cubit.controller,
                        itemCount: cubit.doctorsViewed.length,
                        itemBuilder: (_, index) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.doctorProfile,
                              arguments: cubit.doctorsViewed[index],
                            );
                          },
                          child: DoctorListTile(
                              doctor: cubit.doctorsViewed[index]),
                        ),
                        separatorBuilder: (_, __) => 5.ph,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
