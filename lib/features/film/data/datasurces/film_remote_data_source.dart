import 'dart:convert';

import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:http/http.dart' as http;

abstract class FilmRemoteDataSource {
  Future<FilmModel> getFilm(int search_request_id, String url, String type);
}

class FilmRemoteDataSourceImpl extends FilmRemoteDataSource{
  final http.Client client;

  FilmRemoteDataSourceImpl({required this.client});

  @override
  Future<FilmModel> getFilm(int search_request_id, String url, String type) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2/page'),
      body: {
        'search_request_id': search_request_id.toString(),
        'url': url,
        'type': type
      },
      //headers: {'Content-type': 'application/json'}
    );

    if(response.statusCode == 200) {
      return FilmModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

}