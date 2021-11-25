import 'package:get_it/get_it.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/core/util/pre_search_result_maker.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_local_data_source.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_remote_data_source.dart';
import 'package:hdrezka_client/features/search/domain/usecases/get_search_result_by_query.dart';
import 'package:hdrezka_client/features/search/presentation/bloc/search_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/search/data/repositories/search_result_repository_impl.dart';
import 'features/search/domain/repositories/search_result_repositories.dart';

final sl = GetIt.instance;

Future<void> initSearch() async {
  //Features - search\\
  //BLoC
  sl.registerFactory(
          () => SearchBloc(
              result: sl(),
              preResult: sl()
          )
  );
  //use case
  sl.registerLazySingleton(() => GetSearchResultByQuery(sl()));
  //Repository
  sl.registerLazySingleton<SearchResultRepository>(
      () => SearchResultRepositoryImpl(
          remoteDataSource: sl<SearchResultRemoteDataSource>(),
          localDataSource: sl<SearchResultLocalDataSource>(),
          networkInfo: sl<NetworkInfo>())
  );
  //Data source
  sl.registerLazySingleton<SearchResultRemoteDataSource>(
       () => SearchResultRemoteDataSourceImpl(client: sl<http.Client>())
  );

  sl.registerLazySingleton<SearchResultLocalDataSource>(
      () => SearchResultLocalDataSourceImpl(sharedPreferences: sl())
  );


  //Core\\
  sl.registerLazySingleton(() => PreSearchResultMaker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External\\
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}