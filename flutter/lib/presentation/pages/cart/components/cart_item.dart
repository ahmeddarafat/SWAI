part of '../cart_page.dart';

class CartItem extends StatelessWidget {
  final int index;
  const CartItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);
    
    return Row(
      children: [
        SizedBox(
          width: 80.h,
          height: 80.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              cubit.medicinesCart[index].medicine.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        16.pw,
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PublicText(
              txt: cubit.medicinesCart[index].medicine.name,
              color: AppColors.darkBlue,
              size: 17.sp,
            ),
            5.ph,
            PublicText(
              txt: "${cubit.medicinesCart[index].medicine.noType} ${cubit.medicinesCart[index].medicine.type}",
              color: AppColors.grey,
            ),
            5.ph,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    cubit.decreaseMedicine(index);
                  },
                  child: const Icon(Icons.remove),
                ),
                10.pw,
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return PublicText(txt: cubit.medicinesCart[index].count.toString());
                  },
                ),
                10.pw,
                InkWell(
                  onTap: () {
                    cubit.increaseMedicine(index);
                  },
                  child: const Icon(Icons.add),
                )
              ],
            ),
          ],
        ),
        const Spacer(),
        PublicText(
          txt: "\$ ${cubit.medicinesCart[index].medicine.price}",
          color: AppColors.darkBlue,
          size: 15.sp,
        ),
      ],
    );
  }
}
