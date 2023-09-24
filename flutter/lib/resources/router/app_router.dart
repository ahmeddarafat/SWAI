import 'package:flutter/material.dart';
import 'package:google_solution2/data/model/article_model.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/data/model/medicine_model.dart';
import 'package:google_solution2/presentation/pages/articles/article_preview/article_preview_page.dart';
import 'package:google_solution2/presentation/pages/articles/bookmark/bookmark_page.dart';
import 'package:google_solution2/presentation/pages/chats/all_chats/all_chats_page.dart';
import 'package:google_solution2/presentation/pages/auth/confirm_password/confirm_password_page.dart';
import 'package:google_solution2/presentation/pages/chats/chat_preview/chat_preview_page.dart';
import 'package:google_solution2/presentation/pages/consult/doctor_profile/doctor_profile_page.dart';
import 'package:google_solution2/presentation/pages/auth/forgot_pass/forgot_password_page.dart';
import 'package:google_solution2/presentation/pages/auth/login/login_page.dart';
import 'package:google_solution2/presentation/pages/profile/about/about_page.dart';
import 'package:google_solution2/presentation/pages/profile/settings/settings_page.dart';
import 'package:google_solution2/presentation/pages/store/medicine/medicine_page.dart';
import 'package:google_solution2/presentation/pages/profile/my_profile/my_profile_page.dart';
import 'package:google_solution2/presentation/pages/notifications/notifications_page.dart';
import 'package:google_solution2/presentation/pages/onboarding/onboarding_page.dart';
import 'package:google_solution2/presentation/pages/auth/register/register_page.dart';
import 'package:google_solution2/presentation/pages/auth/reset_password/reset_password_page.dart';
import 'package:google_solution2/presentation/pages/articles/trend_articles/trend_articles_page.dart';
import 'package:google_solution2/presentation/pages/auth/verify_code/verify_code_page.dart';
import '../../presentation/pages/layouts/layouts_page.dart';

import '../../data/model/rate_data_model.dart';
import '../../presentation/pages/home/rate/rate_page.dart';
import '../di/di.dart';

class AppRoutes {
  AppRoutes._private();

  /// Intro
  static const String splash = "splash";
  static const String onBoarding = "onBoarding";

  /// Auth
  static const String login = "login";
  static const String register = "register";
  static const String forgotPassword = "forgot password";
  static const String verifyCode = "verify code";
  static const String resetPassword = "reset password";
  static const String confirmPassword = "confirm password";

  /// main pages
  static const String layouts = "layouts";
  static const String doctorProfile = "doctor profile";
  static const String rate = "rate";
  static const String articleWebView = "article web view";
  static const String myProfile = "my profile";
  static const String notifications = "notifications";
  static const String medicine = "medicine";
  static const String bookmark = "bookmark";
  static const String articleView = "article view";
  static const String trendArticles = "trend articles";
  static const String chats = "chats";
  static const String chatPreview = "chat preview";

  /// Profile
  static const String aboutApp = "about app";
  static const String settings = "settings";
  
}

class RouteGenerate {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      ///Intro
      case AppRoutes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        );

      /// Auth
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
        );
      case AppRoutes.verifyCode:
        return MaterialPageRoute(
          builder: (_) => VerifyCodePage(
            email: routeSettings.arguments as String,
          ),
        );
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordPage(),
        );
      case AppRoutes.confirmPassword:
        return MaterialPageRoute(
          builder: (_) => const ConfirmPasswordPage(),
        );

      /// Main
      case AppRoutes.layouts:
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
      case AppRoutes.medicine:
        return MaterialPageRoute(
          builder: (_) => MedicinePage(
            medicine: routeSettings.arguments as MedicineModel,
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
          builder: (_) => const AllChatsPage(),
        );
      case AppRoutes.chatPreview:
        return MaterialPageRoute(
          builder: (_) => ChatPreviewPage(
            doctor: routeSettings.arguments as DoctorInfoModel,
          ),
        );

      /// Profile
      case AppRoutes.aboutApp:
        return MaterialPageRoute(
          builder: (_) => const AboutPage(),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
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
