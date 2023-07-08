part of '../articles_page.dart';

class ArticleTile extends StatelessWidget {
  final ArticleModel article;
  const ArticleTile({
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
              child: Image.asset(
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
                      InkWell(
                        onTap: () {
                          // TODO: "Logic" - add or remove to bookmark page
                        },
                        child: Icon(
                          Icons.bookmark_outline,
                          color: AppColors.lightBlue,
                          size: 18.sp,
                        ),
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