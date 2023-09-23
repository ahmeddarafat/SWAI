
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/article_model.dart';
import 'package:google_solution2/logic/articles/articles_cubit.dart';
import 'package:google_solution2/presentation/widgets/public_text.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';

import '../../resources/router/app_router.dart';

class CustomArticleTile extends StatelessWidget {
  final ArticleModel article;
  const CustomArticleTile({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.articleView,
        arguments: article,
      ),
      child: SizedBox(
        height: 90.h,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              // child: Image.network(
              //   model.image,
              //   height: 110.h,
              //   width: 100.h,
              //   fit: BoxFit.fill,
              // ),
              child: Image.network(
                article.image,
                height: 90.h,
                width: 90.h,
                fit: BoxFit.fill,
              ),
            ),
            10.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PublicText(
                        txt: article.publishedAt,
                        color: AppColors.grey,
                        size: 15.sp,
                      ),
                      BlocBuilder<ArticlesCubit, ArticlesState>(
                        buildWhen: (_, current) {
                          if (current is ArticlesBookMarkState &&
                              current.id == article.id) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        builder: (context, state) {
                          var cubit = ArticlesCubit.get(context);
                          return InkWell(
                            onTap: () {
                              cubit.bookmarkArticle(article.id);
                            },
                            child: Icon(
                              article.isMarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: AppColors.lightBlue,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  PublicText(
                    txt: article.title,
                    color: AppColors.darkBlue,
                    max: 2,
                    size: 16.sp,
                    align: TextAlign.start,
                  ),
                  PublicText(
                    txt: article.author,
                    color: AppColors.grey,
                    size: 15.sp,
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


/// Draft
  // RichText(
  //   text: TextSpan(
  //     style: TextStyle(
  //       color: AppColors.grey,
  //       fontSize: 14.sp,
  //     ),
  //     children: [
  //       TextSpan(text: model.author.capitalizd),
  //       const TextSpan(text: "  *  "),
  //       TextSpan(
  //         text: DateFormat("MMM dd, yyyy").format(
  //           DateFormat("yyyy-MM-dd").parse(model.publishedAt),
  //         ),
  //       ),
  //     ],
  //   ),
  // ),