import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/entities/film_information.dart';
import 'package:hdrezka_client/core/models/film_information_model.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:hdrezka_client/features/search/domain/entities/search_result.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  const int id = 0;
  const String query = 'string';
  final List<FilmInformation> payload = List.generate(1, (index) {
    List<dynamic> list = [
      '''{
        "url": "https://rezka.ag/films/fantasy/41834-snova-privet-1987.html",
        "name": "Снова привет",
        "type": "films",
        "image": "https://static.hdrezka.ac/i/2021/9/19/r664889dc807fud75o25d.jpg",
        "addition": "1987, США, Фэнтези"
      }'''
    ];
    return FilmInformationModel.fromJson(json.decode(list.elementAt(index)));
  });

  const String status = 'created';
  final DateTime created = DateTime.parse('2021-10-03T22:00:07.000000Z');
  final DateTime updated = DateTime.parse('2021-10-03T22:00:07.000000Z');

  final testSearchResultModel = SearchResultModel(
      id: id,
      query: query,
      payload: payload,
      status: status,
      created: created,
      updated: updated
  );

  test(
    'should be a subclass of SearchResult entity',
      () async {
        //assert
        expect(testSearchResultModel, isA<SearchResult>());
      }
  );

  group('fromJson', (){
    test(
      'should return a valid model when the JSON search result',
        () async {
          final Map<String, dynamic> jsonMap =
            json.decode(fixture('search_result.json', const Utf8Codec()));
          final result = SearchResultModel.fromJson(jsonMap);

          expect(result, testSearchResultModel);
        }
    );
  });

}