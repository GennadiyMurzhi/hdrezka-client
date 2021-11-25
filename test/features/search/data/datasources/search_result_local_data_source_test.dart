import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/models/film_information_model.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_local_data_source.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:shared_preferences/shared_preferences.dart' as _i2;

import '../../../../fixtures/fixture.dart';

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [SharedPreferences].
///
/// See the documentation for Mockito's code generation for more information.
class SharedPreferencesMock extends _i1.Mock implements _i2.SharedPreferences {
  SharedPreferencesMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Set<String> getKeys() => (super.noSuchMethod(Invocation.method(#getKeys, []),
      returnValue: <String>{}) as Set<String>);
  @override
  Object? get(String? key) =>
      (super.noSuchMethod(Invocation.method(#get, [key])) as Object?);
  @override
  bool? getBool(String? key) =>
      (super.noSuchMethod(Invocation.method(#getBool, [key])) as bool?);
  @override
  int? getInt(String? key) =>
      (super.noSuchMethod(Invocation.method(#getInt, [key])) as int?);
  @override
  double? getDouble(String? key) =>
      (super.noSuchMethod(Invocation.method(#getDouble, [key])) as double?);
  @override
  String? getString(String? key) =>
      (super.noSuchMethod(Invocation.method(#getString, [key])) as String?);
  @override
  bool containsKey(String? key) =>
      (super.noSuchMethod(Invocation.method(#containsKey, [key]),
          returnValue: false) as bool);
  @override
  List<String>? getStringList(String? key) =>
      (super.noSuchMethod(Invocation.method(#getStringList, [key]))
      as List<String>?);
  @override
  _i3.Future<bool> setBool(String? key, bool? value) =>
      (super.noSuchMethod(Invocation.method(#setBool, [key, value]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<bool> setInt(String? key, int? value) =>
      (super.noSuchMethod(Invocation.method(#setInt, [key, value]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<bool> setDouble(String? key, double? value) =>
      (super.noSuchMethod(Invocation.method(#setDouble, [key, value]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<bool> setString(String? key, String? value) =>
      (super.noSuchMethod(Invocation.method(#setString, [key, value]),
          returnValueForMissingStub: Future.value(false),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>
      );
  @override
  _i3.Future<bool> setStringList(String? key, List<String>? value) =>
      (super.noSuchMethod(Invocation.method(#setStringList, [key, value]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<bool> remove(String? key) =>
      (super.noSuchMethod(Invocation.method(#remove, [key]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<bool> commit() =>
      (super.noSuchMethod(Invocation.method(#commit, []),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<bool> clear() => (super.noSuchMethod(Invocation.method(#clear, []),
      returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<void> reload() =>
      (super.noSuchMethod(Invocation.method(#reload, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}

@GenerateMocks([], customMocks: [
  MockSpec<SharedPreferences>(as: #SharedPreferencesMock)
])
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