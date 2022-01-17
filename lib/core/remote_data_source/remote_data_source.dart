import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:http/http.dart' as http;

const String GET_MOVIE = 'get_movie';
const String GET_EPISODES = 'get_episodes';
const String GET_STREAM = 'get_stream';

abstract class RemoteDataSource {
  Future<String> getDocument(String url);
}

class RemoteDataSourceImpl extends RemoteDataSource{
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<String> getDocument(String url) async {
    final response = await client.get(
      Uri.parse(url),
    );

    if(response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }

  Future<String> getMovieVideoLinks({
    required int id,
    required int translator_id,
    required int is_camrip,
    required int is_ads,
    required int is_director,
    required String favs}) async {
    final response = await http
        .post(Uri.parse('https://rezka.ag/ajax/get_cdn_series/?t='),
        body: {
          "id": id.toString(),
          "translator_id": translator_id.toString(),
          "is_camrip": is_camrip.toString(),
          "is_ads" : is_ads.toString(),
          "is_director": is_director.toString(),
          "favs": "ba1db7dd-0758-422a-bd14-8dda8d54ae9b",
          "action": GET_MOVIE
        });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }

  Future<String> getEpisodesInformationForVoiceActing({
    required int id,
    required int translator_id,
    required String favs}) async {
    final response = await http
        .post(Uri.parse('https://rezka.ag/ajax/get_cdn_series/?t='),
        body: {
          "id": id.toString(),
          "translator_id": translator_id.toString(),
          "favs": "ba1db7dd-0758-422a-bd14-8dda8d54ae9b",
          "action": GET_EPISODES
        });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }

  Future<String> getEpisodeVideoLinks({
      required int id,
      required int translator_id,
      required int season,
      required int episode,
      required String favs}) async {
    final response = await http
        .post(Uri.parse('https://rezka.ag/ajax/get_cdn_series/?t='),
        body: {
          "id": id.toString(),
          "translator_id": translator_id.toString(),
          "season": season.toString(),
          "episode": episode.toString(),
          "favs": "ba1db7dd-0758-422a-bd14-8dda8d54ae9b",
          "action": GET_STREAM
      });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }
}