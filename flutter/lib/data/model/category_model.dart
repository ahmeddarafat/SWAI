import 'package:google_solution2/resources/constants/app_assets.dart';

class CategoryModel {
  final String icon;
  final String name;

  const CategoryModel(this.name, this.icon);
}

const List<CategoryModel> categories = [
  CategoryModel("Eye", AppIcons.eye),
  CategoryModel("Tooth", AppIcons.tooth),
  CategoryModel("Ear", AppIcons.ear),
  CategoryModel("Drugs", AppIcons.drugs),
  CategoryModel("Nutrition", AppIcons.nutrition),
];
