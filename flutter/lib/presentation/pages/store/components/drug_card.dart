part of "../stores_page.dart";

// TODO: "Data" - Drug model
class DrugCard extends StatelessWidget {
  final DrugModel drug;
  const DrugCard({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.whiteGrey,
          width: 0.2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 100.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppImages.ibuprofen,
                fit: BoxFit.cover,
              ),
            ),
          ),
          5.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PublicText(
                  txt: drug.name,
                  color: AppColors.darkBlue,
                  size: 17.sp,
                ),
                5.ph,
                PublicText(
                  txt: "${drug.number} ${drug.type}",
                  color: AppColors.grey,
                ),
                5.ph,
                PublicText(
                  txt: "\$${drug.price}",
                  color: AppColors.darkBlue,
                  size: 15.sp,
                ),
                5.ph,
              ],
            ),
          )
        ],
      ),
    );
  }
}
