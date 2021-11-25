part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class DeActivated extends SearchEvent {
  @override
  List<Object?> get props => [];

}

class Activated extends SearchEvent {
  @override
  List<Object?> get props => [];

}

class GetSearchResultForQuery extends SearchEvent {
  final String query;

  const GetSearchResultForQuery(this.query);

  @override
  List<Object?> get props => [query];

}
