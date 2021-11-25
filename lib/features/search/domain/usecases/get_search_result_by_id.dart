import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/usecases/repository_usecase.dart';
import 'package:hdrezka_client/features/search/domain/entities/search_result.dart';
import 'package:hdrezka_client/features/search/domain/repositories/search_result_repositories.dart';

class GetSearchResultById implements RepositoryUseCase<SearchResult, Params> {

  final SearchResultRepository repository;

  GetSearchResultById(this.repository);

  @override
  Future<Either<Failure, SearchResult>> call(Params params) async {
    return await repository.getSearchResultById(params.id);
  }

}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];

}