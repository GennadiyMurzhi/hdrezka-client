import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/features/film/data/datasurces/local_data_sources/voice_acting_local_data_source.dart';
import 'package:hdrezka_client/features/film/data/models/film_sub_models/voice_acting_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/voice_acting.dart';
import 'package:hdrezka_client/features/film/domain/repository/voice_acting_repository.dart';
import 'package:hdrezka_client/isolate_p.dart';

/*
class VoiceActingListRepositoryImpl extends VoiceActingListRepository{
  final VoiceActingListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  VoiceActingListRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo});

  @override
  Future<Either<Failure, VoiceActingList>> getVoiceActingList(String document) async {
    if (await networkInfo.isConnected){
      try {
        final remoteVoiceActingList = await sendReceive(VoiceActingListModel.fromDocument(document));
        localDataSource.cacheVoiceActingList(remoteVoiceActingList);
        return Right(remoteVoiceActingList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localVoiceActingList = await localDataSource.getCachedVoiceActingList();
        return Right(localVoiceActingList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}*/