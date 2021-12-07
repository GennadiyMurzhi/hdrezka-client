import 'dart:convert';

import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_remote_data_source.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import 'search_result_remote_data_source_test.mocks.edited.dart';

import '../../../../fixtures/fixture.dart';

/*@GenerateMocks([], customMocks: [
  MockSpec<http.Client>(as: #HttpClientMock, returnNullOnMissingStub: true)
])*/

void main () {
  SearchResultRemoteDataSourceImpl? dataSourceSuccess;
  SearchResultRemoteDataSourceImpl? dataSourceFailure;
  HttpClientMock? mockHttpClientSuccess;
  HttpClientMock? mockHttpClientFailure;

  setUp(() {
    mockHttpClientSuccess = HttpClientMock(
        valueForMissingStub: Future.value(
            http.Response(fixture('search_result.json', Latin1Codec()), 200)));

    mockHttpClientFailure = HttpClientMock(
        valueForMissingStub: Future.value(
            http.Response('Something went wrong', 404)));

    dataSourceSuccess = SearchResultRemoteDataSourceImpl(
        client: mockHttpClientSuccess!);

    dataSourceFailure = SearchResultRemoteDataSourceImpl(client: mockHttpClientFailure!);
  });

  final testSearchResult =
      SearchResultModel.fromJson(json.decode(fixture('search_result.json', Latin1Codec())));

  void setUpMockHttpClientSuccess(){
    when(mockHttpClientSuccess!.post(any, headers: anyNamed('headers')))
        .thenAnswer(
            (_) async => http.Response(fixture('search_result.json', Utf8Codec()), 200)
    );
  }

  void setUpMockHttpClientFailure() {
    when(mockHttpClientFailure!.post(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response('Something went wrong', 404)
    );
  }

  group('getSearchResultByQuery',() {
    const query = 'string';

    test('''should perform a POST request on a BODY with query inside being the endpoint 
    and with application/json header''', (){
      //arrange
      setUpMockHttpClientSuccess();
      //act
      dataSourceSuccess!.getSearchResultByQuery(query);
      //assert
      verify(mockHttpClientSuccess!.post(
        Uri.parse('http://10.0.2.2/search'),
        body: {'query': query},
        //headers: {'Content-type': 'application/json'}
      ));
    });

    test(
      'should return SearchResult when the response code is 200 (success)',
      () async {
        //arrange
        setUpMockHttpClientSuccess();
        //act
        final result = await dataSourceSuccess!.getSearchResultByQuery(query);
        //assert
        expect(result , equals(testSearchResult));
      });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          //arrange
          setUpMockHttpClientFailure();
          //act
          final call = dataSourceFailure!.getSearchResultByQuery;
          //assert
          expect(() => call(query), throwsA(TypeMatcher<ServerException>()));
        });
  });

  group('getSearchResultById',() {
    const id = 0;

    test('''should perform a POST request on a BODY with query inside being the endpoint 
    and with application/json header''', (){
      //arrange
      setUpMockHttpClientSuccess();
      //act
      dataSourceSuccess!.getSearchResultById(id);
      //assert
      verify(mockHttpClientSuccess!.post(
          Uri.parse('http://10.0.2.2/search'),
          body: {'query': id},
          //headers: {'Content-type': 'application/json'}
      ));
    });

    test(
        'should return SearchResult when the response code is 200 (success)',
            () async {
          //arrange
          setUpMockHttpClientSuccess();
          //act
          final result = await dataSourceSuccess!.getSearchResultById(id);
          //assert
          expect(result , equals(testSearchResult));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          //arrange
          setUpMockHttpClientFailure();
          //act
          final call = dataSourceFailure!.getSearchResultById;
          //assert
          expect(() => call(id), throwsA(TypeMatcher<ServerException>()));
        });
  });
}