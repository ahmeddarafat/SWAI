import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/logic/cart/cart_cubit.dart';
import 'package:google_solution2/presentation/widgets/global/public_text.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';

import '../../../../data/model/store/medicine_model.dart';
import '../../../../resources/constants/app_strings.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/global/public_button.dart';

class MedicinePage extends StatelessWidget {
  final MedicineModel medicine;
  const MedicinePage({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // To make the stack take all screen
            const SizedBox(
              height: double.infinity,
              width: double.infinity,
            ),
            SizedBox(
              height: 270.h,
              width: double.infinity,
              child: Image.network(
                medicine.image,
                fit: BoxFit.cover,
              ),
            ),

            /// the back arrow
            Positioned(
              top: 15.h,
              left: 15.w,
              child: Container(
                height: 35.h,
                width: 35.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.lightBlue,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 240.h,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 20.h,
                            left: 15.w,
                            right: 15.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      PublicText(
                                        txt: medicine.name,
                                        color: AppColors.darkBlue,
                                        fw: FontWeight.bold,
                                        size: 22.sp,
                                      ),
                                      10.ph,
                                      PublicText(
                                        txt:
                                            "${medicine.noType} ${medicine.type}",
                                        color: AppColors.grey,
                                        size: 18.sp,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.darkBlue,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: PublicText(
                                      txt: "\$${medicine.price}",
                                      color: Colors.white,
                                      fw: FontWeight.bold,
                                      size: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                              20.ph,
                              PublicText(
                                txt: AppStrings.generalUsage,
                                color: AppColors.darkBlue,
                                size: 18.sp,
                              ),
                              10.ph,
                              PublicText(
                                txt: medicine.generalUsage,
                                color: AppColors.grey,
                                size: 16.sp,
                                max: 10,
                              ),
                              20.ph,
                              PublicText(
                                txt: AppStrings.composition,
                                color: AppColors.darkBlue,
                                size: 18.sp,
                              ),
                              10.ph,
                              PublicText(
                                txt: medicine.composition,
                                color: AppColors.grey,
                                size: 16.sp,
                                max: 10,
                              ),
                              20.ph,
                              PublicText(
                                txt: AppStrings.usageInstructions,
                                color: AppColors.darkBlue,
                                size: 18.sp,
                              ),
                              10.ph,
                              PublicText(
                                txt: medicine.usageInstructions,
                                color: AppColors.grey,
                                size: 16.sp,
                                max: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// The buttons of the bottom
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
                          BlocBuilder<CartCubit, CartState>(
                              buildWhen: (_, current) =>
                                  current is AddToCartState,
                              builder: (context, state) {
                                bool isAdded = false;
                                if (state is AddToCartState) {
                                  isAdded = state.id == medicine.id;
                                }
                                return Container(
                                  height: 47.h,
                                  width: 47.h,
                                  decoration: BoxDecoration(
                                    color: isAdded
                                        ? AppColors.lightBlue
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.lightBlue,
                                      width: 1,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      CartCubit.get(context)
                                          .addToCart(medicine);
                                    },
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: isAdded
                                          ? AppColors.white
                                          : AppColors.lightBlue,
                                    ),
                                  ),
                                );
                              }),
                          15.pw,
                          Expanded(
                            child: PublicButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, AppRoutes.cart),
                              title: AppStrings.buy,
                              borderRadius: 12,
                              verticalpadding: 14.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
