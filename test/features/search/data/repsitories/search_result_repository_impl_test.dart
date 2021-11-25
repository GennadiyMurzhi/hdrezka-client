import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/models/film_information_model.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_local_data_source.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_remote_data_source.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:hdrezka_client/features/search/data/repositories/search_result_repository_impl.dart';
import 'package:hdrezka_client/features/search/domain/entities/search_result.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dart:async' as _i4;

import 'package:hdrezka_client/core/network/network_info.dart' as _i6;
import 'package:hdrezka_client/features/search/data/datasources/search_result_local_data_source.dart'
as _i5;
import 'package:hdrezka_client/features/search/data/datasources/search_result_remote_data_source.dart'
as _i3;
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart'
as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeSearchResultModel_0 extends _i1.Fake
    implements _i2.SearchResultModel {}

/// A class which mocks [SearchResultRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class RemoteDataSourceMock extends _i1.Mock
    implements _i3.SearchResultRemoteDataSource {
  RemoteDataSourceMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.SearchResultModel> getSearchResultByQuery(String? query) =>
      (super.noSuchMethod(Invocation.method(#getSearchResultByQuery, [query]),
          returnValue: Future<_i2.SearchResultModel>.value(
              _FakeSearchResultModel_0()),
          returnValueForMissingStub: Future(() =>
            SearchResultModel(
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
                updated: DateTime.parse('2021-10-03T22:00:07.000000Z'))
          ))
      as _i4.Future<_i2.SearchResultModel>);
  @override
  _i4.Future<_i2.SearchResultModel> getSearchResultById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getSearchResultById, [id]),
          returnValue: Future<_i2.SearchResultModel>.value(
              _FakeSearchResultModel_0()),
          returnValueForMissingStub: Future(() =>
              SearchResultModel(
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
                  updated: DateTime.parse('2021-10-03T22:00:07.000000Z'))
          ))
      as _i4.Future<_i2.SearchResultModel>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SearchResultLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class LocalDataSourceMock extends _i1.Mock
    implements _i5.SearchResultLocalDataSource {
  LocalDataSourceMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.SearchResultModel> getLastSearchResult() =>
      (super.noSuchMethod(Invocation.method(#getLastSearchResult, []),
          returnValue: Future<_i2.SearchResultModel>.value(
              _FakeSearchResultModel_0()))
      as _i4.Future<_i2.SearchResultModel>);
  @override
  _i4.Future<void> cacheSearchResult(
      _i2.SearchResultModel? searchResultToCache) =>
      (super.noSuchMethod(
          Invocation.method(#cacheSearchResult, [searchResultToCache]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class NetworkInfoMock extends _i1.Mock implements _i6.NetworkInfo {
  NetworkInfoMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  String toString() => super.toString();
}

@GenerateMocks([], customMocks: [
  MockSpec<SearchResultRemoteDataSource>(as: #RemoteDataSourceMock),
  MockSpec<SearchResultLocalDataSource>(as: #LocalDataSourceMock),
  MockSpec<NetworkInfo>(as: #NetworkInfoMock),

])
void main () {
  SearchResultRepositoryImpl? repository;
  RemoteDataSourceMock? mockRemoteDataSource;
  LocalDataSourceMock? mockLocalDataSource;
  NetworkInfoMock? mockNetworkInfo;

  const int id = 1;
  const String query = 'string';
  final List<FilmInformationModel> payload = [
    FilmInformationModel(
      url:
      "https://rezka.ag/films/fantasy/41834-snova-privet-1987.html",
      name: "Снова привет",
      type: "films",
      imageUrl:
      "https://static.hdrezka.ac/i/2021/9/19/r664889dc807fud75o25d.jpg",
      addition: "1987, США, Фэнтези")];
  const String status = 'created';
  final DateTime created = DateTime.parse('2021-10-03T22:00:07.000000Z');
  final DateTime updated = DateTime.parse('2021-10-03T22:00:07.000000Z');

  final SearchResultModel testSearchResultModel = SearchResultModel(
      id: id,
      query: query,
      payload: payload,
      status: status,
      created: created,
      updated: updated
  );
  final SearchResult testSearchResult = testSearchResultModel;

  setUp(() {
    mockRemoteDataSource = RemoteDataSourceMock();
    mockLocalDataSource = LocalDataSourceMock();
    mockNetworkInfo = NetworkInfoMock();
    repository = SearchResultRepositoryImpl(
      remoteDataSource: mockRemoteDataSource!,
      localDataSource: mockLocalDataSource!,
      networkInfo: mockNetworkInfo!
    );
  });

  void runTestsOnLine(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo!.isConnected).thenAnswer((realInvocation) async  => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo!.isConnected).thenAnswer((realInvocation) async  => false);
      });

      body();
    });
  }


  group('getSearchResultByQuery', (){
    test(
      'should check if the device is online',
        () async {
          //arrange
          when(mockNetworkInfo!.isConnected).thenAnswer(
                  (realInvocation) async => true);
          //act
          repository!.getSearchResultByQuery(query);
          //assert
          verify(mockNetworkInfo!.isConnected);
        }
    );

    runTestsOnLine(() {
      test(
        'should return data when the call to remote data source is successful',
         () async {
          //arrange
          when(mockRemoteDataSource!.getSearchResultByQuery(any))
            .thenAnswer((realInvocation) async => testSearchResultModel);
          //act
           final result = await repository!.getSearchResultByQuery(query);
           //assert
           verify(mockRemoteDataSource!.getSearchResultByQuery(query));
           expect(result, equals(Right(testSearchResult)));
         });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
            //arrange
            when(mockRemoteDataSource!.getSearchResultByQuery(any))
                .thenAnswer((realInvocation) async => testSearchResultModel);
            //act
            await repository!.getSearchResultByQuery(query);
            //assert
            verify(mockRemoteDataSource!.getSearchResultByQuery(query));
            verify(mockLocalDataSource!.cacheSearchResult(testSearchResultModel));
          });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            //arrange
            when(mockRemoteDataSource!.getSearchResultByQuery(any))
                .thenThrow(ServerException());
            //act
            final result = await repository!.getSearchResultByQuery(query);
            //assert
            verify(mockRemoteDataSource!.getSearchResultByQuery(query));
            verifyZeroInteractions(mockLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          });
    });

    runTestsOffline(() {

      test(
        'should return last locally cached data when the cached is present',
          () async {
            // arrange
            when(mockLocalDataSource!.getLastSearchResult())
                .thenAnswer((realInvocation) async => testSearchResultModel);
            //act
            final result = await repository!.getSearchResultByQuery(query);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource!.getLastSearchResult());
            expect(result, equals(Right(testSearchResult)));
          }
      );

      test(
          'should return CachedFailure when the is no cached data present',
              () async {
            // arrange
            when(mockLocalDataSource!.getLastSearchResult())
                .thenThrow(CacheException());
            //act
            final result = await repository!.getSearchResultByQuery(query);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource!.getLastSearchResult());
            expect(result, equals(Left(CacheFailure())));
          }
      );

    });
  });

  group('getSearchResultById', (){
    test(
        'should check if the device is online',
            () async {
          //arrange
          when(mockNetworkInfo!.isConnected).thenAnswer(
                  (realInvocation) async => true);
          //act
          repository!.getSearchResultById(id);
          //assert
          verify(mockNetworkInfo!.isConnected);
        }
    );

    runTestsOnLine(() {
      test(
          'should return data when the call to remote data source is successful',
              () async {
            //arrange
            when(mockRemoteDataSource!.getSearchResultById(any))
                .thenAnswer((realInvocation) async => testSearchResultModel);
            //act
            final result = await repository!.getSearchResultById(id);
            //assert
            verify(mockRemoteDataSource!.getSearchResultById(id));
            expect(result, equals(Right(testSearchResult)));
          });

      test(
          'should cache the data locally when the call to remote data source is successful',
              () async {
            //arrange
            when(mockRemoteDataSource!.getSearchResultById(any))
                .thenAnswer((realInvocation) async => testSearchResultModel);
            //act
            await repository!.getSearchResultById(id);
            //assert
            verify(mockRemoteDataSource!.getSearchResultById(id));
            verify(mockLocalDataSource!.cacheSearchResult(testSearchResultModel));
          });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            //arrange
            when(mockRemoteDataSource!.getSearchResultById(any))
                .thenThrow(ServerException());
            //act
            final result = await repository!.getSearchResultById(id);
            //assert
            verify(mockRemoteDataSource!.getSearchResultById(id));
            verifyZeroInteractions(mockLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          });
    });

    runTestsOffline(() {

      test(
          'should return last locally cached data when the cached is present',
              () async {
            // arrange
            when(mockLocalDataSource!.getLastSearchResult())
                .thenAnswer((realInvocation) async => testSearchResultModel);
            //act
            final result = await repository!.getSearchResultById(id);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource!.getLastSearchResult());
            expect(result, equals(Right(testSearchResult)));
          }
      );

      test(
          'should return CachedFailure when the is no cached data present',
              () async {
            // arrange
            when(mockLocalDataSource!.getLastSearchResult())
                .thenThrow(CacheException());
            //act
            final result = await repository!.getSearchResultById(id);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource!.getLastSearchResult());
            expect(result, equals(Left(CacheFailure())));
          }
      );

    });
  });
}