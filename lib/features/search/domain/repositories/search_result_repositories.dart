import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/features/search/domain/entities/search_result.dart';

abstract class SearchResultRepository {
  Future<Either<Failure, SearchResult>> getSearchResultByQuery(String query);
  Future<Either<Failure, SearchResult>> getSearchResultById(int id);
}