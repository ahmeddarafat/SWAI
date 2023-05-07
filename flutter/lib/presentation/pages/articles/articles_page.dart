import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/article_model.dart';
import 'package:google_solution2/logic/articles/articles_logic.dart';
import 'package:google_solution2/resources/constants/app_strings.dart';
import 'package:google_solution2/resources/di/di.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_format.dart';
import '../../../resources/widgets/public_text.dart';

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

class ArticleTile extends StatelessWidget {
  final ArticleModel model;
  const ArticleTile({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              model.image,
              height: 110.h,
              width: 100.h,
              fit: BoxFit.fill,
            ),
          ),
          10.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PublicText(
                  txt: model.title,
                  max: 2,
                  size: 17.sp,
                  align: TextAlign.start,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14.sp,
                    ),
                    children: [
                      TextSpan(text: model.author.capitalizd),
                      const TextSpan(text: "  *  "),
                      TextSpan(
                        text: DateFormat("MMM dd, yyyy").format(
                          DateFormat("yyyy-MM-dd").parse(model.publishedAt),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
