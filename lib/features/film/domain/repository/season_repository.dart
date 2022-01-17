import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/features/film/domain/entities/season.dart';

abstract class SeasonListRepository {
  Future<Either<Failure, SeasonList>> getSeasonList(String document);
}