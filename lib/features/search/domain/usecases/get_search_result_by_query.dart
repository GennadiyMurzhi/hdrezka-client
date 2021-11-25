import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/core/usecases/repository_usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/search_result.dart';

import '../repositories/search_result_repositories.dart';

class GetSearchResultByQuery implements RepositoryUseCase<SearchResult, Params>{
  final SearchResultRepository repository;

  GetSearchResultByQuery(this.repository);

  @override
  Future<Either<Failure, SearchResult>> call(Params params) async {
    return await repository.getSearchResultByQuery(params.query);
  }
}

class Params extends Equatable{
  final String query;

  const Params({required this.query});

  @override
  List<Object?> get props => [query];
}