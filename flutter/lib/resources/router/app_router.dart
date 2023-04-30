import 'package:flutter/material.dart';
import 'package:google_solution2/presentation/pages/layouts/layouts_page.dart';

import '../../presentation/pages/heart_rate/heart_rate_page.dart';

class AppRoutes {
  static const String layouts = "/";
  static const String onBoarding = "/onBoarding";
  static const String splash = "/splash";
  static const String login = "/login";
  static const String register = "/register";
  static const String heartRate = "/heart rate";
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
        return MaterialPageRoute(builder: (_) => const LayoutsPage());
      case AppRoutes.heartRate:
        return MaterialPageRoute(
          builder: (_) =>
              HeartRatePage(measurement: routeSettings.arguments as int),
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
