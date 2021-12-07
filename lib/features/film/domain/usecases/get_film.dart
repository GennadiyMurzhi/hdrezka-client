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
    return repository.getFilm(params.search_request_id, params.url, params.type);
  }
}

class Params extends Equatable {
  int search_request_id;
  String url;
  String type;

  Params({
    required this.search_request_id,
    required this.url,
    required this.type
  });

  @override
  List<Object?> get props => [search_request_id, url, type];
}