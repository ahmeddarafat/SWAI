part of '../articles_page.dart';

class TrendArticleTile extends StatelessWidget {
  final ArticleModel article;
  const TrendArticleTile({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    log("trend article tile build");
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.articleView,
        arguments: article,
      ),
      child: SizedBox(
        height: 200.h,
        width: 270.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // useless line
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                article.image,
                fit: BoxFit.cover,
                height: 120.h,
                width: 270.w,
              ),
            ),
            10.ph,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PublicText(
                        txt: article.title,
                        color: AppColors.darkBlue,
                        max: 2,
                        size: 16.sp,
                        align: TextAlign.start,
                      ),
                      10.ph,
                      PublicText(
                        txt: article.author,
                        color: AppColors.grey,
                        size: 15.sp,
                      ),
                    ],
                  ),
                ),
                20.pw,
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
          ],
        ),
      ),
    );
  }
}
