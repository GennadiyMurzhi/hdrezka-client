import 'dart:convert';

import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:hdrezka_client/features/film/data/models/link_video_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LinkVideoListLocalDataSource {
  Future<LinkVideoListModel> getCachedLinkVideoList();

  Future<void> cacheLinkVideoList(LinkVideoListModel linkVideoList);
}

const CACHED_LINK_VIDEO = 'CACHED_LINK_VIDEO';

class LinkVideoListLocalDataSourceImpl implements LinkVideoListLocalDataSource {
  final SharedPreferences sharedPreferences;

  LinkVideoListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheLinkVideoList(LinkVideoListModel linkVideoListToCache) {
    return sharedPreferences.setString(
        CACHED_LINK_VIDEO,
        json.encode(linkVideoListToCache.toJson()));
  }

  @override
  Future<LinkVideoListModel> getCachedLinkVideoList() {
    final jsonString = sharedPreferences.getString(CACHED_LINK_VIDEO);
    if(jsonString != null){
      return Future.value(LinkVideoListModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

}