import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/features/search/domain/entities/film_information.dart';
import 'package:hdrezka_client/features/search/data/models/film_information_model.dart';
import 'package:hdrezka_client/features/search/domain/entities/search_result.dart';
import 'package:hdrezka_client/features/search/domain/repositories/search_result_repositories.dart';
import 'package:hdrezka_client/features/search/domain/usecases/get_search_result_by_query.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'get_search_result_by_query_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<SearchResultRepository>(as: #SearchResultRepositoryMock)])

void main() {
  SearchResultRepositoryMock? mockSearchResultRepository;
  GetSearchResultByQuery? usecase;

  setUp((){
    mockSearchResultRepository = SearchResultRepositoryMock();
    usecase = GetSearchResultByQuery(mockSearchResultRepository!);
  });

  const int id = 1;
  const String query = 'query';
  final List<FilmInformation> payload = [const FilmInformationModel(
    url: "https://rezka.ag/films/fantasy/41834-snova-privet-1987.html",
    name: "Снова привет",
    type: "films",
    imageUrl: "https://static.hdrezka.ac/i/2021/9/19/r664889dc807fud75o25d.jpg",
    addition: "1987, США, Фэнтези"
  )];
  const String status = 'created';
  final DateTime created = DateTime.parse('2021-10-03T22:00:07.000000Z');
  final DateTime updated = DateTime.parse('2021-10-03T22:00:07.000000Z');

  final SearchResult searchResult = SearchResult(
      id: id,
      query: query,
      payload: payload,
      status: status,
      created: created,
      updated: updated
  );

  test('should get search result for the repository by query', () async {
    //arrange
    when(mockSearchResultRepository!.getSearchResultByQuery(any))
        .thenAnswer((realInvocation) async => Right(searchResult));
    //act
    final result = await usecase!(
       const Params(query: query)
    );
    //assert
    expect(result, Right(searchResult));
    verify(mockSearchResultRepository!.getSearchResultByQuery(query));
    verifyNoMoreInteractions(mockSearchResultRepository!);
  });
}