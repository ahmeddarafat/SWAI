import 'app_assets.dart';
import 'app_strings.dart';

class UIConstants {
  static const List<String> icons = [
    AppIcons.heart,
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
}

class DataConstants {
  static const String baseUrl = "https://ahmeddarafat.mocklab.io";
  static const String measurementsEndpoint = "/measurements";

  static const String contentType = "content-type";
  static const String applicationJson = "application/json";
  static const String accept = "accept";
}