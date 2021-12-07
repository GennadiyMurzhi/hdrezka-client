import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/features/film/data/datasurces/film_local_data_source.dart';
import 'package:hdrezka_client/features/film/data/datasurces/film_remote_data_source.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:hdrezka_client/features/film/data/repositories/film_repository_impl.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'film_repository_impl_test.mocks.edited.dart';

/*@GenerateMocks([], customMocks: [
  MockSpec<FilmLocalDataSource>(as: #MockLocalDataSource),
  MockSpec<FilmRemoteDataSource>(as: #MockRemoteDataSource, returnNullOnMissingStub: true),
  MockSpec<NetworkInfo>(as: #MockNetWorkInfo)
])*/

void main() {
  FilmRepositoryImpl? repository;
  MockRemoteDataSource? mockRemoteDataSource;
  MockLocalDataSource? mockLocalDataSource;
  MockNetWorkInfo? mockNetWorkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetWorkInfo = MockNetWorkInfo();
    repository = FilmRepositoryImpl(
        remoteDataSource: mockRemoteDataSource!,
        localDataSource: mockLocalDataSource!,
        networkInfo: mockNetWorkInfo!);
  });


  group('getFilm', () {
    int search_request_id = 1;
    String url = 'https://rezka.ag/films/drama/39111-ded-privet-2018.html';
    String type = 'films';

    const filmModel = FilmModel(
        search_request_id: 0,
        url: 'https://rezka.ag/films/fantasy/41834-snova-privet-1987.html',
        type: 'films',
        payload: <LinkVideo>[
          LinkVideo(
              resolution: '360p',
              url:
                  'https://stream.voidboost.cc/3/7/6/9/8/8/ebbad219ee853a9ef1e68cdf9df87381:2021100517:2e179457-952a-4834-a712-0fcaa5358126/bie1b.mp4')
        ],
        status: 'string');

    const Film film = filmModel;

    test('should check if the device is online', () async {
      when(mockNetWorkInfo!.isConnected).thenAnswer((realInvocation) async => true);

      repository!.getFilm(search_request_id, url, type);

      verify(mockNetWorkInfo!.isConnected);
    });

    group('device is online', () {
      setUp((){
        when(mockNetWorkInfo!.isConnected).thenAnswer((realInvocation) async => true);
      });

      test('should return remote data when the call to remote data source is successful',
              () async {
            when(mockRemoteDataSource!.getFilm(search_request_id, url, type))
                .thenAnswer((realInvocation) async => filmModel);

            final result = await repository!.getFilm(search_request_id, url, type);

            verify(mockRemoteDataSource!.getFilm(search_request_id, url, type));
            expect(result, equals(const Right(film)));
          });

      test('should cache data locally when the call to remote data source is successful',
          () async {
              when(mockRemoteDataSource!.getFilm(search_request_id, url, type))
                  .thenAnswer((realInvocation) async => filmModel);

              await repository!.getFilm(search_request_id, url, type);

              verify(mockRemoteDataSource!.getFilm(search_request_id, url, type));
              verify(mockLocalDataSource!.cacheFilm(filmModel));
          }
      );

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
              when(mockRemoteDataSource!.getFilm(search_request_id, url, type))
                  .thenThrow(ServerException());

              final result = await repository!.getFilm(search_request_id, url, type);

              verify(mockRemoteDataSource!.getFilm(search_request_id, url, type));
              verifyZeroInteractions(mockLocalDataSource);
              expect(result, equals(Left(ServerFailure())));
          });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetWorkInfo!.isConnected).thenAnswer((realInvocation) async => false);
      });

      test(
        'should return last locally cached data when the cached data is present',
          () async {
            when(mockLocalDataSource!.getCachedFilm())
                .thenAnswer((realInvocation) async => filmModel);

            final result = await repository!.getFilm(search_request_id, url, type);

            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource!.getCachedFilm());
            expect(result, equals(const Right(film)));
          }
      );

      test(
          'should return CacheFailure is no cached data present',
              () async {
            when(mockLocalDataSource!.getCachedFilm())
                .thenThrow(CacheException());

            final result = await repository!.getFilm(search_request_id, url, type);

            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource!.getCachedFilm());
            expect(result, equals(Left(CacheFailure())));
          }
      );
    });
  });


}
