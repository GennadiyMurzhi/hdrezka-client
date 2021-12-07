import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/film/data/datasurces/film_local_data_source.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:hdrezka_client/features/film/data/models/link_video_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import '../../../search/data/datasources/search_result_local_data_source_test.mocks.edited.dart';

void main() {
  FilmLocalDataSourceImpl? dataSource;
  SharedPreferencesMock? mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = SharedPreferencesMock();
    dataSource =
        FilmLocalDataSourceImpl(sharedPreferences: mockSharedPreferences!);
  });

  group('getCachedFilm', () {
    final filmModel =
    FilmModel.fromJson(
        json.decode(fixture('film_cached.json', const Utf8Codec())));

    test(
        'should return Film from SharedPreferences when there is one in the cache',
            () async {
          when(mockSharedPreferences!.getString(any))
              .thenReturn(fixture('film_cached.json', const Utf8Codec()));

          final result = await dataSource!.getCachedFilm();

          verify(mockSharedPreferences!.getString('CACHED_FILM'));
          expect(result, equals(filmModel));
        }
    );

    test('should throw a CacheException when there is not a cached value', (){
      when(mockSharedPreferences!.getString(any)).thenReturn(null);
      // Not calling the method here, just storing it inside a call variable
      final call = dataSource!.getCachedFilm;
      // Calling the method happens from a higher-order function passed/
      // This is needed to test if calling a method trows an exception
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheFilm', () {
    const filmModel = FilmModel(
        search_request_id: 0,
        url: 'https://rezka.ag/films/fantasy/41834-snova-privet-1987.html',
        type: 'films',
        payload: [
          LinkVideoModel(
            resolution: '360p',
            url: 'https://stream.voidboost.cc/3/7/6/9/8/8/ebbad219ee853a9ef1e68cdf9df87381:2021100517:2e179457-952a-4834-a712-0fcaa5358126/bie1b.mp4',
          )
        ],
        status: 'string');

    test('should call SharedPreferences to cache the data', () {
      //act
      dataSource!.cacheFilm(filmModel);
      //assert
      final expectedJsonString = json.encode(filmModel);
      verify(mockSharedPreferences!.setString(
          CACHED_FILM,
          expectedJsonString
      ));
    });
  });
}