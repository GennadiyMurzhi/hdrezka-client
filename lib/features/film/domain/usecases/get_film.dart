import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/usecases/repository_usecase.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/repository/film_repository.dart';

class GetFilm extends RepositoryUseCase<Film, Params>{
  final FilmRepository repository;

  GetFilm(this.repository);

  @override
  Future<Either<Failure, Film>> call(Params params) {
    return repository.getFilm(params.document);
  }
}

class Params extends Equatable {
  String document;

  Params({
    required this.document
  });

  @override
  List<Object?> get props => [document];
}