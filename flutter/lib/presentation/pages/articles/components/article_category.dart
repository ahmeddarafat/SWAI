part of '../articles_page.dart';


class ArticleCategory extends StatefulWidget {
  final int index;
  const ArticleCategory({
    super.key,
    required this.index,
  });

  @override
  State<ArticleCategory> createState() => _ArticleCategoryState();
}

class _ArticleCategoryState extends State<ArticleCategory> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: "Logic" - filtering articles
        // setState(() {
        //   selectedIndex = widget.index;
        // });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constants.articleCategories[widget.index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == widget.index
                    ? AppColors.lightBlue
                    : AppColors.grey,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 2,
              width: 25,
              decoration: BoxDecoration(
                color: selectedIndex == widget.index
                    ? AppColors.darkBlue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(64),
              ),
            ),
          ],
        ),
      ),
    );
  }
}