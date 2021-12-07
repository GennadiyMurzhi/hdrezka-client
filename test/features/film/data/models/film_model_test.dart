import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:hdrezka_client/features/film/data/models/link_video_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';

import '../../../../fixtures/fixture.dart';

void main () {
  const filmModel = FilmModel(
      search_request_id: 0,
      url: 'https://rezka.ag/films/fantasy/41834-snova-privet-1987.html',
      type: 'films',
      payload: [
        LinkVideoModel(
            resolution: '360p',
            url: 'https://stream.voidboost.cc/3/7/6/9/8/8/ebbad219ee853a9ef1e68cdf9df87381:2021100517:2e179457-952a-4834-a712-0fcaa5358126/bie1b.mp4'
        )],
      status: 'string'
  );

  test('should be a subclass of Film', () async {
    expect(filmModel, isA<Film>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON string is an film', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('film.json', const Utf8Codec()));

      final result = FilmModel.fromJson(jsonMap);

      expect(result, filmModel);
    });
  });
}