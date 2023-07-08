import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';
import 'package:google_solution2/presentation/widgets/public_text.dart';

import '../../../data/model/article_model.dart';
import '../../../resources/constants/app_constants.dart';

class ArticlePreViewPage extends StatelessWidget {
  final ArticleModel article;
  const ArticlePreViewPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // to make the stack takes all screen
            const SizedBox(height: double.infinity, width: double.infinity),
            Stack(
              children: <Widget>[
                SizedBox(
                  height: (ScreenSize.height * 0.33).h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                    child: Image.asset(
                      article.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
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
                  top: 15.h,
                  right: 15.w,
                  child: Container(
                    height: 35.h,
                    width: 35.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: InkWell(
                      onTap: () {
                        // TODO: "Logic" - add or remove to/from bookmark page
                      },
                      child: const Icon(
                        Icons.bookmark,
                        color: AppColors.lightBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: (ScreenSize.height * 0.33 - 20).h,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.ph,
                        PublicText(
                          txt: article.title,
                          color: AppColors.darkBlue,
                          fw: FontWeight.bold,
                          size: 16.sp,
                          max: 3,
                        ),
                        10.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PublicText(
                              txt: article.author,
                              color: AppColors.grey,
                              size: 14.sp,
                            ),
                            PublicText(
                              txt: article.publishedAt,
                              color: AppColors.grey,
                              size: 12.sp,
                            ),
                          ],
                        ),
                        30.ph,
                        PublicText(
                          txt: article.description.toPieces(),
                          color: AppColors.grey,
                          size: 16.sp,
                          max: 50,
                        ),
                      ],
                    ),
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
