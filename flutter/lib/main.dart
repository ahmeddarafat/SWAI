import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_solution2/presentation/view/dashboard_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/presentation/viewmodel/dashboard/dashboard_cubit.dart';

import 'app/bloc_observer.dart';
import 'data/network/api_service.dart';

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
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => DashboardCubit(),
          child: const MaterialApp(
            title: 'SWAI',
            home: DashboardView(),
          ),
        );
      },
    );
  }
}



// TODO: last work
// 1. there is a issue the blocBuilder dosen't rebuild the widget after push a new state
// 1. there is a issue the blocBuilder dosen't rebuild the widget after push a new state
