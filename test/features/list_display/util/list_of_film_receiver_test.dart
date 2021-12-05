import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/entities/film_information.dart';
import 'package:hdrezka_client/features/list_display/util/list_of_film_receiver.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import '../../../fixtures/fixture.dart';

void main (){
  ListOfFilmReceiver? listOfFilmReceiver;
  List<FilmInformation>? listOfFilmInformation;

  setUp((){
    listOfFilmInformation = SearchResultModel.fromJson(
        json.decode(fixture('search_result.json', const Utf8Codec()))).payload;
    listOfFilmReceiver = ListOfFilmReceiver(listOfFilmInformation!);
  });

  test('should update list of film inside receiver', () async {
    List<FilmInformation> newListOfFilmInformation = SearchResultModel.fromJson(
        json.decode(fixture('search_result_2.json', const Utf8Codec()))).payload;

    listOfFilmReceiver!.getNewListOfFilms(newListOfFilmInformation);

    final resultList = listOfFilmReceiver!.listOfFilmInformation;

    expect(resultList, newListOfFilmInformation);
  });

  test('there should be a new list of film in the stream', () async {
    List<FilmInformation> newListOfFilmInformation = SearchResultModel.fromJson(
        json.decode(fixture('search_result_2.json', const Utf8Codec()))).payload;

    final expected = [
      listOfFilmInformation,
      newListOfFilmInformation
    ];

    expectLater(listOfFilmReceiver!.getNewListEvent, emitsInOrder(expected));

    listOfFilmReceiver!.getNewListOfFilms(newListOfFilmInformation);
  });
}