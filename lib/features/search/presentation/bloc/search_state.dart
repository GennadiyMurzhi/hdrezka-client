part of 'search_bloc.dart';


@immutable
abstract class SearchState extends Equatable {
  final bool isSearchActive;
  final String query;

  const SearchState(this.isSearchActive, this.query);
}

class Activate extends SearchState {
  const Activate() : super(true, '');

  @override
  List<Object> get props => [];
}

class DeActivate extends SearchState {
  const DeActivate() : super(false, '');

  @override
  List<Object> get props => [];
}

class Loading extends SearchState {
  const Loading(String query) : super(true, query);

  @override
  List<Object?> get props => [];
}

class Loaded extends SearchState {
  final PreResult preResult;

  const Loaded({required this.preResult, required String query}) : super(true, query);

  @override
  List<Object?> get props => [preResult];
}

class Error extends SearchState{
  final String errorMessage;

  const Error({required this.errorMessage, required String query}) : super(true, query);

  @override
  List<Object?> get props => [errorMessage];
}