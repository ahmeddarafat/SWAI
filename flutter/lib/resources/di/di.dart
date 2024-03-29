import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_solution2/data/data_source/local/app_cache/app_cache.dart';
import 'package:google_solution2/data/data_source/remote/firebase_service.dart';
import 'package:google_solution2/data/data_source/remote/remote_data_source.dart';
import 'package:google_solution2/logic/home/rate/rate_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/data_source/local/app_db/app_db.dart';
import '../../data/data_source/local/app_prefs/app_prefs.dart';
import '../../data/data_source/local/local_data_source.dart';
import '../../data/data_source/remote/api_service.dart';
import '../../data/repository/repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/network/network_info.dart';
import '../../logic/bloc_observer.dart';

final GetIt getIt = GetIt.instance;

Future<void> initModule() async {
  Bloc.observer = MyBlocObserver();

  /// app database
  getIt.registerLazySingleton<AppDB>(() => AppDB());

  /// app cache
  getIt.registerLazySingleton<AppCahce>(() => AppCacheImpl());

  /// Shared Preferences
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  /// app prefs
  getIt.registerLazySingleton<AppPrefs>(() => AppPrefs(getIt()));

  /// local Data source
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
        appDB: getIt(), appCahce: getIt(), appPrefs: getIt()),
  );

  /// api service
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(),
  );

  /// firebase service
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseDB = FirebaseFirestore.instance;
  getIt.registerLazySingleton<FirebaseService>(
    () => FirebaseServiceImpl(
      auth: auth,
      db: firebaseDB,
    ),
  );

  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
        apiService: getIt(),
        firebaseService: getIt(),
      ));

  /// network Info
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );

  /// repository
  getIt.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
      localDataSource: getIt(),
    ),
  );
}

void initRateModule() {
  if (!GetIt.I.isRegistered<RateLogic>()) {
    getIt.registerSingleton(
      RateLogic(appDB: getIt<AppDB>()),
    );
  }
}


