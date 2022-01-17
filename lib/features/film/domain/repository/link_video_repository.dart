import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';

abstract class LinkVideoListRepository {
  Future<Either<Failure, LinkVideoList>> getLinkVideoList(String document);
}