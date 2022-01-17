import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/features/film/data/datasurces/local_data_sources/film_local_data_source.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/repository/film_repository.dart';
import 'package:hdrezka_client/isolate_p.dart';

class FilmRepositoryImpl extends FilmRepository{
  final FilmLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FilmRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo});

  @override
  Future<Either<Failure, Film>> getFilm(String document) async {
    if (await networkInfo.isConnected){
      try {
        final remoteFilm = await sendReceive(FilmModel.fromDocument(document));
        localDataSource.cacheFilm(remoteFilm);
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