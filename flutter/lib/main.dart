import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logic/bloc_observer.dart';
import 'data/network/api_service.dart';
import 'logic/dashboard/dashboard_cubit.dart';
import 'presentation/pages/dashboard_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  ApiService.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MaterialApp(
            title: 'SWAI',
            home: DashboardPage(),
          );
        },
      ),
    );
  }
}



// TODO: last work
// 1. there is a issue the blocBuilder dosen't rebuild the widget after push a new state
