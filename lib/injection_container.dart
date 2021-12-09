import 'package:get_it/get_it.dart';
import 'package:hdrezka_client/features/film/domain/usecases/get_film.dart';
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
//TODO: remove that is below
final listDisplay = GetIt.instance;

Future<void> initListDisplay () async {
  //rx
  listDisplay.registerLazySingleton(() => ListOfFilmReceiver(
      //TODO: FIX
      ListOfFilmsParams(search_request_id: SearchResultModel.fromJson(timeList).id,
          listOfFilmInformation: SearchResultModel.fromJson(timeList).payload)

  ));
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
}

Map<String, dynamic> timeList = {
  "id": 139,
  "query": "eva",
  "payload": [
    {
      "url": "https://rezka.ag/films/fiction/457-eva-iskusstvennyy-razum-2011.html",
      "name": "Ева: Искусственный разум",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2013/9/17/had59065f0554jm57w25m.jpg",
      "addition": "2011, Испания, Фантастика"
    },
    {
      "url": "https://rezka.ag/films/drama/27857-eva-2018.html",
      "name": "Ева",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2020/12/26/se42ee7494e02to57d10n.jpg",
      "addition": "2018, Франция, Драмы"
    },
    {
      "url": "https://rezka.ag/films/fantasy/7357-evan-vsemoguschiy-2007.html",
      "name": "Эван Всемогущий",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2014/12/19/f7770e1dda26bcr90f45t.jpg",
      "addition": "2007, США, Фэнтези"
    },
    {
      "url": "https://rezka.ag/films/documentary/18056-evakuaciya-s-zemli-2012.html",
      "name": "Эвакуация с Земли",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2016/8/9/i013995c2382cqe97w42m.jpg",
      "addition": "2012, США, Документальные"
    },
    {
      "url": "https://rezka.ag/films/adventures/33574-eva-za-bortom-2017.html",
      "name": "Ева за бортом",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2020/2/28/cec4bba355bf9wa88s15t.jpg",
      "addition": "2017, Германия, Приключения"
    },
    {
      "url": "https://rezka.ag/films/drama/38679-chernaya-emmanuel-v-yaponii-1976.html",
      "name": "Черная Эммануэль в Японии",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2021/4/6/jfa1a3ef865b5oq60f33d.jpeg",
      "addition": "1976, Италия, Драмы"
    },
    {
      "url": "https://rezka.ag/films/melodrama/15074-adam-i-eva-2002.html",
      "name": "Адам и Ева",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2016/6/7/ce02caf70919azj12z20e.jpg",
      "addition": "2002, Австрия, Мелодрамы"
    },
    {
      "url": "https://rezka.ag/films/horror/17977-oderzhimost-emmy-evans-2010.html",
      "name": "Одержимость Эммы Эванс",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2016/8/7/bc753bd17aa6ebs89x97n.jpg",
      "addition": "2010, Испания, Ужасы"
    },
    {
      "url": "https://rezka.ag/films/horror/20787-istoriya-evy-2015.html",
      "name": "История Евы",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2016/10/17/oac36b8ec6dbbxw88j52x.jpg",
      "addition": "2015, США, Ужасы"
    },
    {
      "url": "https://rezka.ag/films/drama/28389-besporyadochnye-dni-lihie-90-ye-2016.html",
      "name": "Беспорядочные дни – Лихие 90-ые",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2020/12/26/ca291171b3dabqs11j51x.jpg",
      "addition": "2016, Эстония, Драмы"
    },
    {
      "url": "https://rezka.ag/films/documentary/34711-v-poiskah-evy-2019.html",
      "name": "В поисках Евы",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2020/6/7/p61e69054e0e1nh80s39z.jpeg",
      "addition": "2019, Германия, Документальные"
    },
    {
      "url": "https://rezka.ag/films/drama/42217-novoe-evangelie-2020.html",
      "name": "Новое Евангелие",
      "type": "films",
      "image": "https://static.hdrezka.ac/i/2021/10/9/p89c5accf22d1pj51j37x.jpg",
      "addition": "2020, Германия, Драмы"
    }
  ],
  "status": "done",
  "created_at": "2021-12-09T13:22:07.000000Z",
  "updated_at": "2021-12-09T13:22:08.000000Z"
};