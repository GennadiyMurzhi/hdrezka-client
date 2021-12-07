import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:hdrezka_client/features/search/domain/entities/film_information.dart';
import 'package:hdrezka_client/features/list_display/util/list_of_film_receiver.dart';
import 'package:hdrezka_client/injection_container.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/features/search/presentation/util/pre_search_result_maker.dart';
import 'package:hdrezka_client/features/search/domain/usecases/get_search_result_by_query.dart';

part 'search_event.dart';
part 'search_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchResultByQuery? getSearchResultByQuery;
  final PreSearchResultMaker? preSearchResultMaker;

  late List<FilmInformation> listOfFilmsFromResult;

  SearchBloc({
    required GetSearchResultByQuery result,
    required PreSearchResultMaker preResult
  }) : getSearchResultByQuery = result,
       preSearchResultMaker = preResult,
       super(const DeActivate()) {
    on<GetSearchResultForQuery>((event, emit) async {
      emit(Loading(event.query));

      final searchResultEither = await getSearchResultByQuery!(
          Params(query: event.query));

      searchResultEither.fold(
              (failure) => emit(Error(
                  errorMessage: _failureToMessage(failure),
                  query: event.query)),
              (searchResult) {
                listOfFilmsFromResult = searchResult.payload;
                emit(Loaded(
                    preResult: preSearchResultMaker!
                        .listToPreResult(searchResult.payload),
                    query: event.query));
              });
    }, transformer: restartable());

    on<Activated>((event, emit){
      emit(const Activate());
    });

    on<DeActivated>((event, emit){
      emit(const DeActivate());
    });

    on<ShowSearchResult>((event, emit){
      listDisplay<ListOfFilmReceiver>().getNewListOfFilms(listOfFilmsFromResult);
      emit(const DeActivate());
    });
  }
}

String _failureToMessage(Failure failure) {
  switch(failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
