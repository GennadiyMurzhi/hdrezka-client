import 'dart:convert';

import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:hdrezka_client/features/film/data/models/season_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SeasonListLocalDataSource {
  Future<SeasonListModel> getCachedSeasonList();

  Future<void> cacheSeasonList(SeasonListModel seasonList);
}

const CACHED_SEASON = 'CACHED_SEASON';

class SeasonListLocalDataSourceImpl implements SeasonListLocalDataSource {
  final SharedPreferences sharedPreferences;

  SeasonListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheSeasonList(SeasonListModel seasonToCache) {
    return sharedPreferences.setString(
        CACHED_SEASON,
        json.encode(seasonToCache.toJson()));
  }

  @override
  Future<SeasonListModel> getCachedSeasonList() {
    final jsonString = sharedPreferences.getString(CACHED_SEASON);
    if(jsonString != null){
      return Future.value(SeasonListModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

}