import 'package:flutter/material.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/presentation/pages/aticle_webview/article_webview.dart';
import 'package:google_solution2/presentation/pages/doctor_profile/doctor_profile_page.dart';
import '../../presentation/pages/layouts/layouts_page.dart';

import '../../data/model/rate_data_model.dart';
import '../../presentation/pages/rate/rate_page.dart';
import '../di/di.dart';

class AppRoutes {
  static const String layouts = "/";
  static const String onBoarding = "/onBoarding";
  static const String splash = "/splash";
  static const String login = "/login";
  static const String register = "/register";
  static const String rate = "/rate";
  static const String articleWebView = "/article web view";
  static const String doctorProfile = "/doctor profile";
}

class RouteGenerate {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.layouts:
        initArticleModule();
        return MaterialPageRoute(builder: (_) => const LayoutsPage());
      case AppRoutes.rate:
        initRateModule();
        return MaterialPageRoute(
          builder: (_) =>
              RatePage(dataObject: routeSettings.arguments as RateDataModel),
        );
      case AppRoutes.articleWebView:
        return MaterialPageRoute(
          builder: (_) =>
              ArticleWebView(url: routeSettings.arguments as String),
        );
      case AppRoutes.doctorProfile:
        return MaterialPageRoute(
          builder: (_) => DoctorProfilePage(
            doctor: routeSettings.arguments as DoctorInfoModel,
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => _undfinedPage(route: routeSettings.name));
    }
  }

  static Scaffold _undfinedPage({String? route}) {
    return Scaffold(
      appBar: AppBar(title: const Text("Undfined Page")),
      body: Center(child: Text("${route ?? "Undifined"} Page")),
    );
  }
}
