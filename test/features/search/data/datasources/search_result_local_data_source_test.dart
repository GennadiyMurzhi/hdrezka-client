import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/search/data/models/film_information_model.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_local_data_source.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'search_result_local_data_source_test.mocks.edited.dart';

import '../../../../fixtures/fixture.dart';

/*@GenerateMocks([], customMocks: [
  MockSpec<SharedPreferences>(as: #SharedPreferencesMock)
])*/

void main (){
  SearchResultLocalDataSourceImpl? dataSourceImpl;
  SharedPreferencesMock? mockSharedPreferences;

  setUp((){
    mockSharedPreferences = SharedPreferencesMock();
    dataSourceImpl = SearchResultLocalDataSourceImpl(sharedPreferences: mockSharedPreferences!);
  });

  group('getLastSearchResult', () {
    final testSearchResultModel =
        SearchResultModel.fromJson(json.decode(fixture('search_result_cached.json', Utf8Codec())));

    test(
      'should return SearchResult from SharedPreferences when there is one in the cache',
        () async {
          //arrange
          when(mockSharedPreferences!.getString(any))
              .thenReturn(fixture('search_result_cached.json', Utf8Codec()));
          //act
          final result = await dataSourceImpl!.getLastSearchResult();
          //assert
          verify(mockSharedPreferences!.getString('CACHED_SEARCH_RESULT'));
          expect(result, equals(testSearchResultModel));
        }
    );

    test('should throw a CacheException when there is not a cached value', (){
      // arrange
      when(mockSharedPreferences!.getString(any)).thenReturn(null);
      // act
      // Not calling the method here, just storing it inside a call variable
      final call = dataSourceImpl!.getLastSearchResult;
      // assert
      // Calling the method happens from a higher-order function passed/
      // This is needed to test if calling a method trows an exception
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheSearchResult', () {
    final testSearchResultModel = SearchResultModel(
        id: 0,
        query: "string",
        payload: const [
          FilmInformationModel(
              url:
              "https://rezka.ag/films/fantasy/41834-snova-privet-1987.html",
              name: "Снова привет",
              type: "films",
              imageUrl:
              "https://static.hdrezka.ac/i/2021/9/19/r664889dc807fud75o25d.jpg",
              addition: "1987, США, Фэнтези"
          )
        ],
        status: 'created',
        created: DateTime.parse('2021-10-03T22:00:07.000000Z'),
        updated: DateTime.parse('2021-10-03T22:00:07.000000Z'));

    test('should call SharedPreferences to cache the data', () {
      //act
      dataSourceImpl!.cacheSearchResult(testSearchResultModel);
      //assert
      final expectedJsonString = json.encode(testSearchResultModel);
      verify(mockSharedPreferences!.setString(
        CACHED_SEARCH_RESULT,
        expectedJsonString
      ));
    });
  });
}