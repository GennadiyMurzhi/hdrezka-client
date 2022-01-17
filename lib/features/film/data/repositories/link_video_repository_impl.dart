import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/features/film/data/datasurces/local_data_sources/link_video_local_data_source.dart';
import 'package:hdrezka_client/features/film/data/models/link_video_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:hdrezka_client/features/film/domain/repository/link_video_repository.dart';
import 'package:hdrezka_client/isolate_p.dart';

class LinkVideoListRepositoryImpl extends LinkVideoListRepository{
  final LinkVideoListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LinkVideoListRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo});

  @override
  Future<Either<Failure, LinkVideoList>> getLinkVideoList(String document) async {
    if (await networkInfo.isConnected){
      try {
        final remoteLinkVideoList = await sendReceive(LinkVideoListModel.fromDocument(document));
        localDataSource.cacheLinkVideoList(remoteLinkVideoList);
        return Right(remoteLinkVideoList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localLinkVideoList = await localDataSource.getCachedLinkVideoList();
        return Right(localLinkVideoList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}