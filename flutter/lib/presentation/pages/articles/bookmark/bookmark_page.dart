import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/logic/articles/articles_cubit.dart';
import 'package:google_solution2/presentation/widgets/public_article_tile.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';

import '../../../../resources/constants/app_strings.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/public_text.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ArticlesCubit.get(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: PublicText(
            txt: AppStrings.bookmark,
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
            itemCount: cubit.articlesbookmark.length,
            itemBuilder: (_, index) {
              return CustomArticleTile(article: cubit.articlesbookmark[index]);
            },
            separatorBuilder: (_, __) => 10.ph,
          ),
        ),
      ),
    );
  }
}
