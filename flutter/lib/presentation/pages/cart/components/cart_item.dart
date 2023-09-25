part of '../cart_page.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80.h,
          height: 80.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "https://images.theconversation.com/files/321639/original/file-20200319-22610-18gca3.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
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
              txt: "Oblix",
              color: AppColors.darkBlue,
              size: 17.sp,
            ),
            5.ph,
            const PublicText(
              txt: "15 Table",
              color: AppColors.grey,
            ),
            5.ph,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.remove),
                ),
                10.pw,
                const PublicText(txt: "2"),
                10.pw,
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.add),
                )
              ],
            ),
          ],
        ),
        const Spacer(),
        PublicText(
          txt: "\$ 80",
          color: AppColors.darkBlue,
          size: 15.sp,
        ),
      ],
    );
  }
}
