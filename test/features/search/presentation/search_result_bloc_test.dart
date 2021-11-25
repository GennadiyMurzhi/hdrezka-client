import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/util/pre_search_result_maker.dart';
import 'package:hdrezka_client/features/search/data/models/search_result_model.dart';
import 'package:hdrezka_client/features/search/domain/usecases/get_search_result_by_query.dart';
import 'package:hdrezka_client/features/search/presentation/bloc/search_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture.dart';
import 'search_result_bloc_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<GetSearchResultByQuery>(as: #MockGetSearchResultByQuery),
  MockSpec<PreSearchResultMaker>(as: #MockPreSearchResultMaker)
])

void main () {
  SearchBloc? bloc;
  MockGetSearchResultByQuery? mockGetSearchResultByQuery;
  MockPreSearchResultMaker? mockPreSearchResultMaker;

  setUp((){
    mockGetSearchResultByQuery = MockGetSearchResultByQuery();
    mockPreSearchResultMaker = MockPreSearchResultMaker();

    bloc = SearchBloc(
      result: mockGetSearchResultByQuery!,
      preResult: mockPreSearchResultMaker!
    );
  });

  test('the first state is also the initialization state should be DeActivate', (){
    expect(bloc!.state, equals(const DeActivate()));
  });

  group('GetSearchResultForQuery', (){
    const query = 'string';

    final testSearchResult = SearchResultModel.fromJson(json.decode(
        fixture('search_result.json', const Utf8Codec())));

    final preResult = PreResult(
      unreleasedFilmsCount: testSearchResult.payload.length,
      preResultList: testSearchResult.payload,
    );

    void setUpMockPreSearchResultMakerSuccess(){
      when(mockPreSearchResultMaker!.listToPreResult(any))
          .thenReturn(preResult);
      when(mockGetSearchResultByQuery!(any))
          .thenAnswer((realInvocation) async => Right(testSearchResult));
    }

    void setUpMockPreSearchResultMakerFailure(Failure failure){
      when(mockPreSearchResultMaker!.listToPreResult(any))
          .thenReturn(preResult);
      when(mockGetSearchResultByQuery!(any))
          .thenAnswer((realInvocation) async => Left(failure));
    }

    test('should call the the PreSearchResultMaker to make PreResult',
        () async {
      setUpMockPreSearchResultMakerSuccess();

      bloc!.add(const GetSearchResultForQuery(query));
      await untilCalled(mockPreSearchResultMaker!.listToPreResult(any));

      verify(
          mockPreSearchResultMaker!.listToPreResult(testSearchResult.payload));
    });

    test('should get data for concrete use case', () async {
      setUpMockPreSearchResultMakerSuccess();

      bloc!.add(const GetSearchResultForQuery(query));
      await untilCalled(mockGetSearchResultByQuery!(any));

      verify(mockGetSearchResultByQuery!(const Params(query: query)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () async {
      setUpMockPreSearchResultMakerSuccess();

      final expected = [
        const Loading(query),
        Loaded(preResult: preResult, query: query)
      ];
      expectLater(bloc!.stream, emitsInOrder(expected));

      bloc!.add(const GetSearchResultForQuery(query));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      setUpMockPreSearchResultMakerFailure(ServerFailure());

      final expected = [
        const Loading(query),
        const Error(errorMessage: SERVER_FAILURE_MESSAGE, query: query)
      ];
      expectLater(bloc!.stream, emitsInOrder(expected));

      bloc!.add(const GetSearchResultForQuery(query));
    });

    test(
       'should emit [Loading, Error] with a proper message for the error when getting data fails',
       () async {
          setUpMockPreSearchResultMakerFailure(CacheFailure());

          final expected = [
            const Loading(query),
            const Error(errorMessage: CACHE_FAILURE_MESSAGE, query: query)
          ];
          expectLater(bloc!.stream, emitsInOrder(expected));

          bloc!.add(const GetSearchResultForQuery(query));
    });
  });
}