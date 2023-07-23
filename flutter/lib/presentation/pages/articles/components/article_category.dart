part of '../articles_page.dart';

class ArticleCategory extends StatelessWidget {
  final String category;
  final String selectedLabel;
  const ArticleCategory({
    super.key,
    required this.category,
    required this.selectedLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedLabel.toLowerCase() == category.toLowerCase()
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
              color: selectedLabel.toLowerCase() == category.toLowerCase()
                  ? AppColors.darkBlue
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(64),
            ),
          ),
        ],
      ),
    );
  }
}
