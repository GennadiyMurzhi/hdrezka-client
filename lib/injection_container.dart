import 'package:get_it/get_it.dart';
import 'package:hdrezka_client/features/film/domain/usecases/get_film.dart';
import 'package:hdrezka_client/features/search/domain/entities/film_information.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:hdrezka_client/features/search/presentation/util/pre_search_result_maker.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_local_data_source.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_remote_data_source.dart';
import 'package:hdrezka_client/features/search/domain/usecases/get_search_result_by_query.dart';
import 'package:hdrezka_client/features/search/presentation/bloc/search_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/film/data/datasurces/film_local_data_source.dart';
import 'features/film/data/datasurces/film_remote_data_source.dart';
import 'features/film/data/repositories/film_repository_impl.dart';
import 'features/film/domain/repository/film_repository.dart';
import 'features/list_display/util/list_of_film_receiver.dart';
import 'features/search/data/repositories/search_result_repository_impl.dart';
import 'features/search/domain/repositories/search_result_repositories.dart';

final search = GetIt.instance;

Future<void> initSearch() async {
  //Features - search\\
  //BLoC
  search.registerFactory(
          () => SearchBloc(
              result: search(),
              preResult: search()
          )
  );
  //use case
  search.registerLazySingleton(() => GetSearchResultByQuery(search()));
  //Repository
  search.registerLazySingleton<SearchResultRepository>(
      () => SearchResultRepositoryImpl(
          remoteDataSource: search<SearchResultRemoteDataSource>(),
          localDataSource: search<SearchResultLocalDataSource>(),
          networkInfo: search<NetworkInfo>())
  );
  //Data source
  search.registerLazySingleton<SearchResultRemoteDataSource>(
       () => SearchResultRemoteDataSourceImpl(client: search<http.Client>())
  );

  search.registerLazySingleton<SearchResultLocalDataSource>(
      () => SearchResultLocalDataSourceImpl(sharedPreferences: search())
  );


  //Core\\
  search.registerLazySingleton(() => PreSearchResultMaker());
  search.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(search()));

  //External\\
  final sharedPreferences = await SharedPreferences.getInstance();
  search.registerLazySingleton(() => sharedPreferences);
  search.registerLazySingleton<http.Client>(() => http.Client());
  search.registerLazySingleton(() => InternetConnectionChecker());
}

final listDisplay = GetIt.instance;

Future<void> initListDisplay () async {
  //rx
  search.registerLazySingleton(() => ListOfFilmReceiver(SearchResultModel.fromJson(timeList).payload));
}

final page = GetIt.instance;

Future<void> initPage () async {
  //use case
  page.registerLazySingleton(() => GetFilm(page()));
  //Repository
  page.registerLazySingleton<FilmRepository>(
          () => FilmRepositoryImpl(
          remoteDataSource: page<FilmRemoteDataSource>(),
          localDataSource: page<FilmLocalDataSource>(),
          networkInfo: page<NetworkInfo>())
  );
  //Data source
  page.registerLazySingleton<FilmRemoteDataSource>(
          () => FilmRemoteDataSourceImpl(client: page<http.Client>())
  );

  page.registerLazySingleton<FilmLocalDataSource>(
          () => FilmLocalDataSourceImpl(sharedPreferences: page())
  );


  //Core\\
  page.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(page()));

  //External\\
  final sharedPreferences = await SharedPreferences.getInstance();
  page.registerLazySingleton(() => sharedPreferences);
  page.registerLazySingleton<http.Client>(() => http.Client());
  page.registerLazySingleton(() => InternetConnectionChecker());
}

Map<String, dynamic> timeList = {
  "id": 75,
  "query": "anime",
  "payload": [
    {
      "url": "https://rezka.ag/films/drama/17035-chernye-dushi-2014.html",
      "name": "Чёрные души",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2016/7/18/n9271d96b5c16ew98b96u.jpg",
      "addition": "2014, Италия, Драмы"
    },
    {
      "url": "https://rezka.ag/films/drama/17849-zhenskaya-tyurma-ad-dlya-zhenschin-2006.html",
      "name": "Женская тюрьма: Ад для женщин",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2016/8/4/wcf4e7207a862xw12w42a.jpg",
      "addition": "2006, Италия, Драмы"
    },
    {
      "url": "https://rezka.ag/films/horror/3321-vozvraschenie-reanimatora-2003.html",
      "name": "Возвращение реаниматора",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2014/12/19/h5f8ddc85005eon26n60h.jpg",
      "addition": "2003, Испания, Ужасы"
    },
    {
      "url": "https://rezka.ag/films/horror/5036-nevesta-reanimatora-1989.html",
      "name": "Невеста реаниматора",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2014/12/19/s3a75c27007a9aq57u86e.jpg",
      "addition": "1989, США, Ужасы"
    },
    {
      "url": "https://rezka.ag/films/comedy/7045-chudovische-1977.html",
      "name": "Чудовище",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2014/12/19/caad2a0df9acdua64m53y.jpg",
      "addition": "1977, Франция, Комедии"
    },
    {
      "url": "https://rezka.ag/films/horror/7058-reanimator-1985.html",
      "name": "Реаниматор",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2014/12/19/te837ea119d47tw66q95u.jpg",
      "addition": "1985, США, Ужасы"
    },
    {
      "url": "https://rezka.ag/films/action/7198-pozhiznenno-2010.html",
      "name": "Пожизненно / Гнев Каина",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2014/12/19/w64458e425ff8ak18r60i.jpg",
      "addition": "2010, США, Боевики"
    },
    {
      "url": "https://rezka.ag/films/fantasy/7410-enimals-2012.html",
      "name": "Энималс",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2014/12/19/e0d22c3cd6eabmd10y52r.jpg",
      "addition": "2012, Испания, Фэнтези"
    },
    {
      "url": "https://rezka.ag/films/horror/8518-zhivotnoe-2013.html",
      "name": "Животное",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2015/5/11/af7df5c154a1adg17y17f.jpg",
      "addition": "2013, США, Ужасы"
    },
    {
      "url": "https://rezka.ag/films/drama/9158-zverofabrika-2000.html",
      "name": "Зверофабрика",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2015/5/11/r1ccfe07f4975wl78m51y.jpg",
      "addition": "2000, США, Драмы"
    },
    {
      "url": "https://rezka.ag/films/comedy/9392-moya-semya-i-drugie-zveri-2005.html",
      "name": "Моя семья и другие звери",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2015/6/20/wf7fc32965854js13h69f.jpg",
      "addition": "2005, Великобритания, Комедии"
    },
    {
      "url": "https://rezka.ag/films/horror/9427-kogda-zveri-mechtayut-2014.html",
      "name": "Когда звери мечтают",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2015/6/20/e8e09b143e22ejj81e63a.jpg",
      "addition": "2014, Дания, Ужасы"
    },
    {
      "url": "https://rezka.ag/films/drama/9659-po-volchim-zakonam-2010.html",
      "name": "По волчьим законам / Царство зверей",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2019/7/14/b0b6e79d557c9af73v38y.jpg",
      "addition": "2010, Австралия, Драмы"
    },
    {
      "url": "https://rezka.ag/films/comedy/9800-zhivotnoe-2001.html",
      "name": "Животное",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2015/6/20/e98e692143b28ru61s25y.jpg",
      "addition": "2001, США, Комедии"
    },
    {
      "url": "https://rezka.ag/films/comedy/13805-zverinec-1978.html",
      "name": "Зверинец",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2016/5/8/keb3b0eca0b6ebs12y37j.jpg",
      "addition": "1978, США, Комедии"
    }
  ],
  "status": "done",
  "created_at": "2021-12-01T12:02:04.000000Z",
  "updated_at": "2021-12-01T12:02:05.000000Z"
};