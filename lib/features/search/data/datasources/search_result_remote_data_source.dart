import 'dart:convert';

import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:http/http.dart' as http;

abstract class SearchResultRemoteDataSource {
  Future<SearchResultModel> getSearchResultByQuery(String query);
  Future<SearchResultModel> getSearchResultById(int id);
}

class SearchResultRemoteDataSourceImpl implements SearchResultRemoteDataSource {
  final http.Client client;

  SearchResultRemoteDataSourceImpl({required this.client});

  @override
  Future<SearchResultModel> getSearchResultByQuery(String query) =>
      _getSearchResult(query);

  @override
  Future<SearchResultModel> getSearchResultById(int id) =>
      _getSearchResult(id);

  Future<SearchResultModel> _getSearchResult(dynamic idOrQuery) async {
    final response = await client.post(
        Uri.parse('http://10.0.2.2/search'),
        body: {'query': idOrQuery},
        //headers: {'Content-type': 'application/json'}
    );

    if(response.statusCode == 200) {
      return SearchResultModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}