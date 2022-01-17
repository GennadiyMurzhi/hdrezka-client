import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/features/film/data/datasurces/local_data_sources/season_local_data_source.dart';
import 'package:hdrezka_client/features/film/data/models/season_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/season.dart';
import 'package:hdrezka_client/features/film/domain/repository/season_repository.dart';
import 'package:hdrezka_client/isolate_p.dart';

class SeasonListRepositoryImpl extends SeasonListRepository{
  final SeasonListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SeasonListRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo});

  @override
  Future<Either<Failure, SeasonList>> getSeasonList(String document) async {
    if (await networkInfo.isConnected){
      try {
        final remoteSeasonList = await sendReceive(SeasonListModel.fromDocument(document));
        localDataSource.cacheSeasonList(remoteSeasonList);
        return Right(remoteSeasonList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localSeasonList = await localDataSource.getCachedSeasonList();
        return Right(localSeasonList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}