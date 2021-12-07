import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/features/search/domain/entities/film_information.dart';
import 'package:hdrezka_client/features/search/data/models/film_information_model.dart';

import '../../../../fixtures/fixture.dart';

void main () {
  const String url = "https://rezka.ag/films/fantasy/41834-snova-privet-1987.html";
  const String name = "Снова привет";
  const String type = "films";
  const String imageUrl = "https://static.hdrezka.ac/i/2021/9/19/r664889dc807fud75o25d.jpg";
  const String addition = "1987, США, Фэнтези";

  const FilmInformationModel testFilmInformationModel = FilmInformationModel(
    url: url,
    name: name,
    type: type,
    imageUrl: imageUrl,
    addition: addition
  );

  test('should be a subclass of Film information entity', (){
    expect(testFilmInformationModel, isA<FilmInformation>());
  });

  group('from json',() {
    test('should return a valid model when the JSON film information',
    () async {
      final Map<String, dynamic> jsonMap =
        json.decode(fixture('film_information.json', const Utf8Codec()));
      final result = FilmInformationModel.fromJson(jsonMap);

      expect(result, testFilmInformationModel);

    });
  });
}