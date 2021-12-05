import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/entities/film_information.dart';
import 'package:hdrezka_client/features/search/presentation/util/pre_search_result_maker.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';

import '../../../../fixtures/fixture.dart';

void main () {
  PreSearchResultMaker? preSearchResultMaker;

  setUp(() {
    preSearchResultMaker = PreSearchResultMaker();
  });

  final PreResult preResult = PreResult(
      unreleasedFilmsCount: 0,
      preResultList: SearchResultModel.fromJson(
          json.decode(fixture('search_result.json', const Utf8Codec()))).payload);
  
  group('resultToPreResult', () {
    test(
        'should return PreResult when pass list of FilmInformation',
        () async {
          final searchResult = SearchResultModel.fromJson(
              json.decode(fixture('search_result.json', const Utf8Codec())));
          
          final result = preSearchResultMaker!.listToPreResult(searchResult.payload);

          expect(result, preResult);
        }
    );
  });
}