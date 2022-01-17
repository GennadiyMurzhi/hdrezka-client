import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/usecases/repository_usecase.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/entities/season.dart';
import 'package:hdrezka_client/features/film/domain/repository/film_repository.dart';
import 'package:hdrezka_client/features/film/domain/repository/season_repository.dart';

class GetSeasonList extends RepositoryUseCase<SeasonList, Params>{
  final SeasonListRepository repository;

  GetSeasonList(this.repository);

  @override
  Future<Either<Failure, SeasonList>> call(Params params) {
    return repository.getSeasonList(params.document);
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