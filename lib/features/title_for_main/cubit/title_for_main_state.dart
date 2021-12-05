part of 'title_for_main_cubit.dart';

abstract class TitleForMainState extends Equatable {
  const TitleForMainState();
}

class NoTitle extends TitleForMainState {
  @override
  List<Object> get props => [];
}

class TitleSearch extends TitleForMainState {
  final String title;

  const TitleSearch(String query) : title = 'Результат поиска для ' + query;

  @override
  List<Object> get props => [];
}
