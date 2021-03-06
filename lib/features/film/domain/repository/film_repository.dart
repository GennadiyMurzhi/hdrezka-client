import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';

abstract class FilmRepository {
  Future<Either<Failure, Film>> getFilm(String document);
}