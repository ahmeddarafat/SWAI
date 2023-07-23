import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';

import '../../../data/dummy_data/dummy_data.dart';
import '../../../resources/constants/app_strings.dart';
import '../../../resources/styles/app_colors.dart';
import '../../widgets/public_text.dart';
import '../articles/articles_page.dart';
import '../../../logic/articles/articles_cubit.dart';

class TrendArticles extends StatelessWidget {
  const TrendArticles({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ArticlesCubit.get(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: PublicText(
            txt: AppStrings.trending,
            color: AppColors.darkBlue,
            fw: FontWeight.bold,
            size: 20.sp,
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.darkBlue,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: cubit.articlesTrending.length,
            itemBuilder: (_, index) {
              return PublicArticleTile(article: cubit.articlesTrending[index]);
            },
            separatorBuilder: (_, __) => 10.ph,
          ),
        ),
      ),
    );
  }
}
