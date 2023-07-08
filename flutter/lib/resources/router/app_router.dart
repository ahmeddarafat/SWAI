import 'package:flutter/material.dart';
import 'package:google_solution2/data/model/article_model.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/data/model/drug_model.dart';
import 'package:google_solution2/presentation/pages/article_preview/article_preview_page.dart';
import 'package:google_solution2/presentation/pages/articles/articles_page.dart';
import 'package:google_solution2/presentation/pages/bookmark/bookmark_page.dart';
import 'package:google_solution2/presentation/pages/chat_preview/chat_preview_page.dart';
import 'package:google_solution2/presentation/pages/chats/chats_page.dart';
import 'package:google_solution2/presentation/pages/doctor_profile/doctor_profile_page.dart';
import 'package:google_solution2/presentation/pages/drug/drug_page.dart';
import 'package:google_solution2/presentation/pages/my_profile/my_profile_page.dart';
import 'package:google_solution2/presentation/pages/notifications/notifications_page.dart';
import 'package:google_solution2/presentation/pages/onboarding/onboarding_page.dart';
import 'package:google_solution2/presentation/pages/trend_articles/trend_articles_page.dart';
import '../../presentation/pages/layouts/layouts_page.dart';

import '../../data/model/rate_data_model.dart';
import '../../presentation/pages/rate/rate_page.dart';
import '../di/di.dart';

class AppRoutes {
  AppRoutes._private();
  static const String onBoarding = "/onBoarding";
  static const String layouts = "/layouts";
  static const String splash = "/splash";
  static const String login = "/login";
  static const String register = "/register";
  static const String rate = "/rate";
  static const String articleWebView = "/article web view";
  static const String doctorProfile = "/doctor profile";
  static const String myProfile = "/my profile";
  static const String notifications = "/notifications";
  static const String drug = "/drug";
  static const String bookmark = "/bookmark";
  static const String articleView = "/article view";
  static const String trendArticles = "/trend articles";
  static const String chats = "/chats";
  static const String chatPreview = "/chat preview";
}

class RouteGenerate {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        );
      case AppRoutes.layouts:
        initArticleModule();
        return MaterialPageRoute(builder: (_) => const LayoutsPage());
      case AppRoutes.rate:
        initRateModule();
        return MaterialPageRoute(
          builder: (_) =>
              RatePage(dataObject: routeSettings.arguments as RateDataModel),
        );
      case AppRoutes.doctorProfile:
        return MaterialPageRoute(
          builder: (_) => DoctorProfilePage(
            doctor: routeSettings.arguments as DoctorInfoModel,
          ),
        );
      case AppRoutes.myProfile:
        return MaterialPageRoute(
          builder: (_) => const MyProfilePage(),
        );
      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationPage(),
        );
      case AppRoutes.drug:
        return MaterialPageRoute(
          builder: (_) => DrugPage(
            drug: routeSettings.arguments as DrugModel,
          ),
        );
      case AppRoutes.bookmark:
        return MaterialPageRoute(
          builder: (_) => const BookMarkPage(),
        );
      case AppRoutes.articleView:
        return MaterialPageRoute(
          builder: (_) => ArticlePreViewPage(
            article: routeSettings.arguments as ArticleModel,
          ),
        );
      case AppRoutes.trendArticles:
        return MaterialPageRoute(
          builder: (_) => const TrendArticles(),
        );
      case AppRoutes.chats:
        return MaterialPageRoute(
          builder: (_) => const ChatsPage(),
        );
      case AppRoutes.chatPreview:
        return MaterialPageRoute(
          builder: (_) => const ChatPreviewPage(),
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
