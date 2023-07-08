import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/dummy_data/dummy_data.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import '../../../data/model/drug_model.dart';
import '../../../resources/constants/app_assets.dart';
import '../../../resources/constants/app_strings.dart';
import '../../../resources/router/app_router.dart';
import '../../../resources/styles/app_colors.dart';
import '../../widgets/public_text.dart';
import '../../widgets/public_text_form_field.dart';

part 'components/drug_card.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
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
                    onTap: () {
                      // TODO: "logic,data" - add number to card, payment
                    },
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
            // TODO: "Logic" - filtering drugs
            PublicTextFormField(
              showprefixIcon: true,
              prefixIcon: Icons.search,
              hint: AppStrings.search,
              controller: _searchController,
              validator: null,
              borderRadius: 12,
            ),
            40.ph,
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.h,
                  crossAxisSpacing: 15.w,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (_, index) => InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.drug,
                    arguments: drugModel,
                  ),
                  child: DrugCard(
                    drug: drugModel,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
