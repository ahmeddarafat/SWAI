import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/logic/articles/articles_logic.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/di/di.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';
import '../../widgets/public_text.dart';
import 'components/article_tile.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  var logic = getIt<ArticleLogic>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 10.w,
        left: 10.w,
        top: 20.h,
        bottom: 5.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PublicText(
            txt: AppStrings.discover,
            size: 40.sp,
            fw: FontWeight.bold,
          ),
          5.ph,
          PublicText(
            txt: AppStrings.articlesSubtitle,
            color: AppColors.grey,
            size: 14.sp,
          ),
          20.ph,
          Expanded(
            child: FutureBuilder(
              future: logic.getArticles(),
              builder: (context, snapshot) {
                log(snapshot.hasData.toString());
                log(snapshot.data.toString());
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return ArticleTile(model: snapshot.data![index]);
                    },
                    separatorBuilder: (_, __) {
                      return 10.ph;
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.lightBlue,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
