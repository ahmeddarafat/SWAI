import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_solution2/data/data_source/local/app_cache.dart';
import 'package:google_solution2/logic/articles/articles_logic.dart';
import 'package:google_solution2/logic/auth/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/data_source/local/app_db.dart';
import '../../data/data_source/local/local_data_source.dart';
import '../../data/data_source/remote/api_service.dart';
import '../../data/repository/repository.dart';
import '../../logic/rate/rate_logic.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/network/network_info.dart';
import '../../logic/bloc_observer.dart';

final GetIt getIt = GetIt.instance;

void initModule() async {
  Bloc.observer = MyBlocObserver();

  /// app database
  getIt.registerLazySingleton<AppDB>(() => AppDB());

  /// app cache
  getIt.registerLazySingleton<AppCahce>(() => AppCacheImpl());

  /// Shared Preferences
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  /// local Data source
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      appDB: getIt(),
      appCahce: getIt(),
    ),
  );

  /// api service
  getIt.registerSingleton<ApiService>(
    ApiService(),
  );

  /// network Info
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );

  /// repository
  getIt.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      apiService: getIt(),
      networkInfo: getIt(),
      localDataSource: getIt(),
    ),
  );
}

void initRateModule() {
  if (!GetIt.I.isRegistered<RateLogic>()) {
    getIt.registerFactory(
      () => RateLogic(appDB: getIt<AppDB>()),
    );
  }
}

void initArticleModule() {
  if (!GetIt.I.isRegistered<ArticleLogic>()) {
    getIt.registerFactory(
      () => ArticleLogic(repo: getIt()),
    );
  }
}

AuthCubit initLoginModule() {
  if (!GetIt.I.isRegistered<AuthCubit>()) {
    getIt.registerFactory(
      () => AuthCubit(repo: getIt()),
    );
  }
  return getIt<AuthCubit>();
}
