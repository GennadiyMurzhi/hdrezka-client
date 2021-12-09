import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/features/film/data/datasurces/film_local_data_source.dart';
import 'package:hdrezka_client/features/film/data/datasurces/film_remote_data_source.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/repository/film_repository.dart';

class FilmRepositoryImpl extends FilmRepository{
  final FilmRemoteDataSource remoteDataSource;
  final FilmLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FilmRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo});

  @override
  Future<Either<Failure, Film>> getFilm(int search_request_id, String url, String type) async {
    if (await networkInfo.isConnected){
      try {
        final remoteFilm = await remoteDataSource.getFilm(search_request_id, url, type);
        localDataSource.cacheFilm(remoteFilm);
        print('OK');
        return Right(remoteFilm);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localFilm = await localDataSource.getCachedFilm();
        return Right(localFilm);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
  
}