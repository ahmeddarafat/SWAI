import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/article_model.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';
import 'package:intl/intl.dart';
import '../../../resources/widgets/public_text.dart';

class ArticleTile extends StatelessWidget {
  final ArticleModel model;
  const ArticleTile({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.articleWebView,
        arguments: model.url,
      ),
      child: SizedBox(
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
      ),
    );
  }
}
