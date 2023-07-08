// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/dummy_data/dummy_data.dart';
import 'package:google_solution2/resources/constants/app_constants.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';

import '../../../data/model/article_model.dart';
import '../../widgets/public_text.dart';

part 'components/article_tile.dart';
part 'components/trend_article_tile.dart';
part 'components/article_category.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: PublicText(
            txt: AppStrings.articles,
            color: AppColors.darkBlue,
            fw: FontWeight.bold,
            size: 20.sp,
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                // TODO: "logic,data" - search bar
              },
              icon: const Icon(
                Icons.search,
                color: AppColors.darkBlue,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.bookmark),
              icon: const Icon(
                Icons.bookmark_outline,
                color: AppColors.darkBlue,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row of Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PublicText(
                    txt: AppStrings.trending,
                    size: 18.sp,
                    fw: FontWeight.w500,
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.trendArticles),
                    child: PublicText(
                      txt: AppStrings.veiwAll,
                      size: 14.sp,
                      color: AppColors.lightBlue,
                    ),
                  ),
                ],
              ),
              10.ph,

              /// Trending Categores
              SizedBox(
                height: 200.h,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (_, int index) {
                    return TrendArticleTile(article: articleModel);
                  },
                  separatorBuilder: (_, __) {
                    return 15.pw;
                  },
                ),
              ),
              30.ph,

              /// Row of Categories
              SizedBox(
                height: 30.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: UIConstants.articleCategories.length,
                  itemBuilder: (_, index) {
                    return ArticleCategory(index: index);
                  },
                ),
              ),
              10.ph,

              /// Normal Articles
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (_, index) {
                    return ArticleTile(article: articleModel);
                  },
                  separatorBuilder: (_, __) => 10.ph,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Draft

// class ArticlesPage extends StatefulWidget {
//   const ArticlesPage({super.key});

//   @override
//   State<ArticlesPage> createState() => _ArticlesPageState();
// }

// class _ArticlesPageState extends State<ArticlesPage> {
//   var logic = getIt<ArticleLogic>();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         right: 10.w,
//         left: 10.w,
//         top: 20.h,
//         bottom: 5.h,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           PublicText(
//             txt: AppStrings.discover,
//             size: 40.sp,
//             fw: FontWeight.bold,
//           ),
//           5.ph,
//           PublicText(
//             txt: AppStrings.articlesSubtitle,
//             color: AppColors.grey,
//             size: 14.sp,
//           ),
//           20.ph,
//           Expanded(
//             child: FutureBuilder(
//               future: logic.getArticles(),
//               builder: (context, snapshot) {
//                 log(snapshot.hasData.toString());
//                 log(snapshot.data.toString());
//                 if (snapshot.hasData) {
//                   return ListView.separated(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (_, index) {
//                       return ArticleTile(model: snapshot.data![index]);
//                     },
//                     separatorBuilder: (_, __) {
//                       return 10.ph;
//                     },
//                   );
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: AppColors.lightBlue,
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// ListView.separated(
//   physics: const BouncingScrollPhysics(),
//   scrollDirection: Axis.horizontal,
//   itemCount: 6,
//   itemBuilder: (_, index){
//     return
//   },
//   separatorBuilder: (_, __)=> 10.pw,
// ),
