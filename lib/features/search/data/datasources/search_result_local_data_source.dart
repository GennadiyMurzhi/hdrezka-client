import 'dart:convert';

import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SearchResultLocalDataSource {
  Future<SearchResultModel> getLastSearchResult();

  Future<void> cacheSearchResult(SearchResultModel searchResultToCache);
}

const CACHED_SEARCH_RESULT = 'CACHED_SEARCH_RESULT';

class SearchResultLocalDataSourceImpl implements SearchResultLocalDataSource {
  final SharedPreferences sharedPreferences;

  SearchResultLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<SearchResultModel> getLastSearchResult() {
    final jsonString = sharedPreferences.getString('CACHED_SEARCH_RESULT');
    if(jsonString != null){
      return Future.value(SearchResultModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }

  }

  @override
  Future<void> cacheSearchResult(SearchResultModel searchResultToCache) {
    return sharedPreferences.setString(
      CACHED_SEARCH_RESULT,
      json.encode(searchResultToCache.toJson())
    );
  }

}