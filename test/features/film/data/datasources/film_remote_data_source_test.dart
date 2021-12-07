import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/film/data/datasurces/film_remote_data_source.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import '../../../search/data/datasources/search_result_remote_data_source_test.mocks.edited.dart';

void main () {
  FilmRemoteDataSourceImpl? dataSourceSuccess;
  FilmRemoteDataSourceImpl? dataSourceFailure;
  HttpClientMock? mockHttpClientSuccess;
  HttpClientMock? mockHttpClientFailure;

  setUp(() {
    mockHttpClientSuccess = HttpClientMock(
        valueForMissingStub: Future.value(
            http.Response(fixture('film.json', Latin1Codec()), 200)));

    mockHttpClientFailure = HttpClientMock(
        valueForMissingStub: Future.value(
            http.Response('Something went wrong', 404)));

    dataSourceSuccess = FilmRemoteDataSourceImpl(client: mockHttpClientSuccess!);

    dataSourceFailure = FilmRemoteDataSourceImpl(client: mockHttpClientFailure!);
  });

  final film =
      FilmModel.fromJson(json.decode(fixture('film.json', Latin1Codec())));

  void setUpMockHttpClientSuccess(){
    when(mockHttpClientSuccess!.post(any, headers: anyNamed('headers')))
        .thenAnswer(
            (_) async => http.Response(fixture('film.json', Utf8Codec()), 200)
    );
  }

  void setUpMockHttpClientFailure() {
    when(mockHttpClientFailure!.post(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response('Something went wrong', 404)
    );
  }

  group('getFilm',() {
    const search_request_id = 1;
    const url = 'string';
    const type = 'films';

    test('''should perform a POST request on a BODY with query inside being the endpoint 
    and with application/json header''', (){
      //arrange
      setUpMockHttpClientSuccess();
      //act
      dataSourceSuccess!.getFilm(search_request_id, url, type);
      //assert
      verify(mockHttpClientSuccess!.post(
        Uri.parse('http://10.0.2.2/page'),
        body: {
          'search_request_id': search_request_id,
          'url': url,
          'type': type
        },
        //headers: {'Content-type': 'application/json'}
      ));
    });

    test(
        'should return SearchResult when the response code is 200 (success)',
            () async {
          //arrange
          setUpMockHttpClientSuccess();
          //act
          final result = await dataSourceSuccess!.getFilm(search_request_id, url, type);
          //assert
          expect(result , equals(film));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          //arrange
          setUpMockHttpClientFailure();
          //act
          final call = dataSourceFailure!.getFilm;
          //assert
          expect(() => call(search_request_id, url, type), throwsA(TypeMatcher<ServerException>()));
        });
  });
}