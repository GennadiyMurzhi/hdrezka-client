import 'dart:convert';

import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:hdrezka_client/features/film/data/models/film_sub_models/voice_acting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
abstract class VoiceActingListLocalDataSource {
  Future<VoiceActingListModel> getCachedVoiceActingList();

  Future<void> cacheVoiceActingList(VoiceActingListModel voiceActingList);
}

const CACHED_VOICE_ACTING = 'CACHED_VOICE_ACTING';

class VoiceActingListLocalDataSourceImpl implements VoiceActingListLocalDataSource {
  final SharedPreferences sharedPreferences;

  VoiceActingListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheVoiceActingList(VoiceActingListModel voiceActingListToCache) {
    return sharedPreferences.setString(
        CACHED_VOICE_ACTING,
        json.encode(voiceActingListToCache.toJson()));
  }

  @override
  Future<VoiceActingListModel> getCachedVoiceActingList() {
    final jsonString = sharedPreferences.getString(CACHED_VOICE_ACTING);
    if(jsonString != null){
      return Future.value(VoiceActingListModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

}*/