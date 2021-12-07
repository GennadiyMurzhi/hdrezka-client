import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/features/search/data/models/film_information_model.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_local_data_source.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_remote_data_source.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:hdrezka_client/features/search/data/repositories/search_result_repository_impl.dart';
import 'package:hdrezka_client/features/search/domain/entities/search_result.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_result_repository_impl_test.mocks.edited.dart';

/*@GenerateMocks([], customMocks: [
  MockSpec<SearchResultRemoteDataSource>(as: #RemoteDataSourceMock, returnNullOnMissingStub: true),
  MockSpec<SearchResultLocalDataSource>(as: #LocalDataSourceMock),
  MockSpec<NetworkInfo>(as: #NetworkInfoMock),
])*/

void main () {
  SearchResultRepositoryImpl? repository;
  RemoteDataSourceMock? mockRemoteDataSource;
  LocalDataSourceMock? mockLocalDataSource;
  NetworkInfoMock? mockNetworkInfo;

  const int id = 1;
  const String query = 'string';
  final List<FilmInformationModel> payload = [
    const FilmInformationModel(
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