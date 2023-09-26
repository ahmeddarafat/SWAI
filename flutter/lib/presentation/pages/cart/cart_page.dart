import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/store/medicine_model.dart';
import 'package:google_solution2/logic/cart/cart_cubit.dart';
import 'package:google_solution2/presentation/widgets/global/public_button.dart';
import 'package:google_solution2/presentation/widgets/global/public_text.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';

import '../../../../resources/styles/app_colors.dart';

part 'components/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: PublicText(
          txt: "Cart",
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          children: [
            Expanded(
              child: cubit.medicinesCart.isEmpty
                  ? const Center(child: PublicText(txt: "Cart is Empty"))
                  : ListView.separated(
                      itemCount: cubit.medicinesCart.length,
                      itemBuilder: (_, index) {
                        return CartItem(index: index);
                      },
                      separatorBuilder: (_, __) => 10.ph,
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PublicText(
                        txt: "Total Price:",
                        color: AppColors.darkBlue,
                        size: 20.sp,
                      ),
                      60.pw,
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return PublicText(
                            txt: "\$ ${cubit.totalPrice.orAbout()}",
                            color: AppColors.lightBlue,
                            size: 22.sp,
                          );
                        },
                      ),
                    ],
                  ),
                  10.ph,
                  PublicButton(
                    onPressed: () {
                      // paymob
                    },
                    title: "Pay",
                    borderRadius: 12,
                    verticalpadding: 14.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
