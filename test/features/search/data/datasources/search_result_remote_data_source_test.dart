import 'dart:convert';

import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/features/search/data/datasources/search_result_remote_data_source.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import 'dart:async' as _i5;
import 'dart:convert' as _i6;
import 'dart:typed_data' as _i7;

import 'package:http/src/base_request.dart' as _i8;
import 'package:http/src/client.dart' as _i4;
import 'package:http/src/response.dart' as _i2;
import 'package:http/src/streamed_response.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

import '../../../../fixtures/fixture.dart';

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeResponse_0 extends _i1.Fake implements _i2.Response {}

class _FakeStreamedResponse_1 extends _i1.Fake implements _i3.StreamedResponse {
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class HttpClientMock extends _i1.Mock implements _i4.Client {
  final Object? objectForReturnValueForMissingStub;

  HttpClientMock({required this.objectForReturnValueForMissingStub}) {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
          returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
      as _i5.Future<_i2.Response>);
  @override
  _i5.Future<_i2.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
          returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
      as _i5.Future<_i2.Response>);
  @override
  _i5.Future<_i2.Response> post(Uri? url,
      {Map<String, String>? headers,
        Object? body,
        _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
          Invocation.method(#post, [url],
              {#headers: headers, #body: body, #encoding: encoding}),
          returnValueForMissingStub: objectForReturnValueForMissingStub,
          returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
      as _i5.Future<_i2.Response>);
  @override
  _i5.Future<_i2.Response> put(Uri? url,
      {Map<String, String>? headers,
        Object? body,
        _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
          Invocation.method(#put, [url],
              {#headers: headers, #body: body, #encoding: encoding}),
          returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
      as _i5.Future<_i2.Response>);
  @override
  _i5.Future<_i2.Response> patch(Uri? url,
      {Map<String, String>? headers,
        Object? body,
        _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
          Invocation.method(#patch, [url],
              {#headers: headers, #body: body, #encoding: encoding}),
          returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
      as _i5.Future<_i2.Response>);
  @override
  _i5.Future<_i2.Response> delete(Uri? url,
      {Map<String, String>? headers,
        Object? body,
        _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
          Invocation.method(#delete, [url],
              {#headers: headers, #body: body, #encoding: encoding}),
          returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
      as _i5.Future<_i2.Response>);
  @override
  _i5.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i5.Future<String>);
  @override
  _i5.Future<_i7.Uint8List> readBytes(Uri? url,
      {Map<String, String>? headers}) =>
      (super.noSuchMethod(
          Invocation.method(#readBytes, [url], {#headers: headers}),
          returnValue: Future<_i7.Uint8List>.value(_i7.Uint8List(0)))
      as _i5.Future<_i7.Uint8List>);
  @override
  _i5.Future<_i3.StreamedResponse> send(_i8.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
          returnValue:
          Future<_i3.StreamedResponse>.value(_FakeStreamedResponse_1()))
      as _i5.Future<_i3.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

@GenerateMocks([], customMocks: [
  MockSpec<http.Client>(as: #HttpClientMock)
])
void main () {
  SearchResultRemoteDataSourceImpl? dataSourceSuccess;
  SearchResultRemoteDataSourceImpl? dataSourceFailure;
  HttpClientMock? mockHttpClientSuccess;
  HttpClientMock? mockHttpClientFailure;

  setUp(() {
    mockHttpClientSuccess = HttpClientMock(
        objectForReturnValueForMissingStub: Future.value(
            http.Response(fixture('search_result.json', Latin1Codec()), 200)));

    mockHttpClientFailure = HttpClientMock(
        objectForReturnValueForMissingStub: Future.value(
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
        headers: {'Content-type': 'application/json'}
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
          headers: {'Content-type': 'application/json'}
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