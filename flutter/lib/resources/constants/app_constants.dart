import 'app_assets.dart';
import 'app_strings.dart';

class UIConstants {
  // to avoid create instance
  UIConstants._private();

  static const List<String> icons = [
    AppIcons.heartBeat,
    AppIcons.therommeter,
    AppIcons.o2,
    AppIcons.glucose
  ];
  static const List<String> units = [
    AppStrings.heartRateUnit,
    AppStrings.temperatureUnit,
    AppStrings.oxygenUnit,
    AppStrings.glucoseRateUnit,
  ];
  static const List<String> titles = [
    AppStrings.heartRate,
    AppStrings.temperature,
    AppStrings.oxygenRate,
    AppStrings.glucoseRate,
  ];

  static const List<String> weekDays = [
    "Mon",
    "Tues",
    "Wed",
    "Thur",
    "Fri",
    "Sat",
    "Sun",
  ];

  static const List<String> articleCategories = [
    "Newest",
    "Hospital",
    "Life Style",
    "Heath Tips",
    "Nutrition",
    "Covid 19",
  ];
}

class DataConstants {
  // to avoid create instance
  DataConstants._private();

  static const String baseUrl = "https://arafat2.mocklab.io";
  static const String measurementsEndpoint = "/measurements";
  static const String articlesEndpoint = "/articles";

  static const String contentType = "content-type";
  static const String applicationJson = "application/json";
  static const String accept = "accept";
}

class ScreenSize{
  // to avoid create instance
  ScreenSize._private();

  static const double height = 690;
  static const double width = 360;
}