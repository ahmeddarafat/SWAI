part of "../stores_page.dart";

// TODO: "Data" - Drug model
class MedicineCard extends StatelessWidget {
  final MedicineModel medicine;
  const MedicineCard({super.key, required this.medicine});

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
              child: Image.network(
                medicine.image,
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
                  txt: medicine.name,
                  color: AppColors.darkBlue,
                  size: 17.sp,
                ),
                5.ph,
                PublicText(
                  txt: "${medicine.noType} ${medicine.type}",
                  color: AppColors.grey,
                ),
                5.ph,
                PublicText(
                  txt: "\$${medicine.price}",
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
