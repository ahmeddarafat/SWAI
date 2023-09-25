import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/dummy_data/dummy_data.dart';
import 'package:google_solution2/logic/store/store_cubit.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import '../../../../data/model/store/medicine_model.dart';
import '../../../../resources/constants/app_assets.dart';
import '../../../../resources/constants/app_strings.dart';
import '../../../../resources/router/app_router.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/global/public_text.dart';
import '../../../widgets/global/public_text_form_field.dart';

part 'components/medicine_card.dart';

class FindMedicinePage extends StatefulWidget {
  const FindMedicinePage({super.key});

  @override
  State<FindMedicinePage> createState() => _FindMedicinePageState();
}

class _FindMedicinePageState extends State<FindMedicinePage> {
  late final TextEditingController _searchController;

  Future<void> _bind() async {
    if (context.mounted) {
      var cubit = StoreCubit.get(context);
      await cubit.getMedicines();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = StoreCubit.get(context);
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
                        txt: AppStrings.medicalStore,
                        color: AppColors.black,
                        fw: FontWeight.bold,
                        size: 25.sp,
                      ),
                      PublicText(
                        txt: AppStrings.howYouFeel,
                        color: AppColors.grey,
                        size: 14.sp,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.cart),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.darkBlue,
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
                  ),
                ],
              ),
            ),
            40.ph,
            PublicTextFormField(
              showprefixIcon: true,
              prefixIcon: Icons.search,
              hint: AppStrings.search,
              controller: _searchController,
              validator: null,
              borderRadius: 12,
              onChanged: (value) {
                cubit.filterBySearch(value);
              },
            ),
            40.ph,
            Expanded(
              child: BlocBuilder<StoreCubit, StoreState>(
                builder: (context, state) {
                  if (state is StoretLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StoretErrorState) {
                    return const Center(
                      child: PublicText(txt: "Check your network"),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        cubit.getMedicinesRefresh();
                      },
                      child: GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: cubit.medicinesViewed.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15.h,
                          crossAxisSpacing: 15.w,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (_, index) => InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.medicine,
                            arguments: cubit.medicinesViewed[index],
                          ),
                          child: MedicineCard(
                            medicine: cubit.medicinesViewed[index],
                          ),
                        ),
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
