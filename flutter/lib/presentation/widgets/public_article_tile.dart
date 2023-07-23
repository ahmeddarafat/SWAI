part of '../pages/articles/articles_page.dart';

class PublicArticleTile extends StatelessWidget {
  final ArticleModel article;
  const PublicArticleTile({
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