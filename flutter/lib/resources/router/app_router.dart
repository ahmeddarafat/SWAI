import 'package:flutter/material.dart';
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
}

class RouteGenerate {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case AppRoutes.splash:
      //   return MaterialPageRoute(builder: (_) => const SplashPage());
      // case AppRoutes.onBoarding:
      //   return MaterialPageRoute(builder: (_) => const OnBoardingLayouts());
      // case AppRoutes.login:
      //   return MaterialPageRoute(builder: (_) => const LoginPage());
      // case AppRoutes.register:
      //   return MaterialPageRoute(builder: (_) => const RegisterView());
      case AppRoutes.layouts:
        initArticleModule();
        return MaterialPageRoute(builder: (_) => const LayoutsPage());
      case AppRoutes.rate:
        initRateModule();
        return MaterialPageRoute(
          builder: (_) =>
              RatePage(dataObject: routeSettings.arguments as RateDataModel),
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
