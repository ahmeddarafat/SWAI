import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_solution2/data/data_source/local/app_db.dart';
import 'package:google_solution2/data/data_source/local/local_data_source.dart';
import 'package:google_solution2/data/data_source/remote/api_service.dart';
import 'package:google_solution2/data/repository/repository.dart';
import 'package:google_solution2/logic/rate/rate_logic.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/network/network_info.dart';
import '../../logic/bloc_observer.dart';

final GetIt getIt = GetIt.instance;

void initModule() {
  Bloc.observer = MyBlocObserver();

  /// app database
  getIt.registerLazySingleton<AppDB>(() => AppDB());

  /// local Data source
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSource(getIt<AppDB>()),
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
  getIt.registerLazySingleton<RepositoryImpl>(
    () => RepositoryImpl(
      apiService: getIt<ApiService>(),
      networkInfo: getIt<NetworkInfo>(),
      localDataSource: getIt<LocalDataSource>(),
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
