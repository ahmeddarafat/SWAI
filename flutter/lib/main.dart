import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'logic/rate/cubit/rate_cubit.dart';
import 'resources/di/di.dart';
import 'resources/router/app_router.dart';
import 'resources/styles/app_theme.dart';

import 'logic/dashboard/dashboard_cubit.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DashboardCubit(),
        ),
        BlocProvider(
          create: (_) => RateCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SWAI',
            theme: AppTheme.getLight(),
            onGenerateRoute: RouteGenerate.getRoute,
          );
        },
      ),
    );
  }
}



// TODO: Tasks todo
// 1. merge between rate logic and rate cubit
// 2. create web view page
