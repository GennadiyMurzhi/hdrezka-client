import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_local_data_source.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_remote_data_source.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:hdrezka_client/features/search/domain/entities/search_result.dart';
import 'package:hdrezka_client/features/search/domain/repositories/search_result_repositories.dart';

typedef Future<SearchResultModel> _SearchResultByIdOrQueryChooser();

class SearchResultRepositoryImpl implements SearchResultRepository{
  final SearchResultRemoteDataSource remoteDataSource;
  final SearchResultLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SearchResultRepositoryImpl({
      required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, SearchResult>> getSearchResultById(int id) async {
    return await _getSearchResult(() => remoteDataSource.getSearchResultById(id));
  }

  @override
  Future<Either<Failure, SearchResult>> getSearchResultByQuery(String query) async {
    return await _getSearchResult(() => remoteDataSource.getSearchResultByQuery(query));
  }

  Future<Either<Failure, SearchResult>> _getSearchResult(
    _SearchResultByIdOrQueryChooser getSearchResultByIdOrQuery
  ) async {
    if(await networkInfo.isConnected){
      try {
        final remoteSearchResultModel = await getSearchResultByIdOrQuery();
        localDataSource.cacheSearchResult(remoteSearchResultModel);
        return Right(remoteSearchResultModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localSearchResult = await localDataSource.getLastSearchResult();
        return Right(localSearchResult);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}