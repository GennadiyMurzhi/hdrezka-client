import 'dart:convert';

import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FilmLocalDataSource {
  Future<FilmModel> getCachedFilm();

  Future<void> cacheFilm(FilmModel film);
}

const CACHED_FILM = 'CACHED_FILM';

class FilmLocalDataSourceImpl implements FilmLocalDataSource {
  final SharedPreferences sharedPreferences;

  FilmLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheFilm(FilmModel filmToCache) {
    return sharedPreferences.setString(
        CACHED_FILM,
        json.encode(filmToCache.toJson()));
  }

  @override
  Future<FilmModel> getCachedFilm() {
    final jsonString = sharedPreferences.getString(CACHED_FILM);
    if(jsonString != null){
      return Future.value(FilmModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

}