part of 'list_display_cubit.dart';

abstract class ListDisplayState extends Equatable {
  ///default need be wrap, wrap is true
  final bool wrapOrList;

  const ListDisplayState(this.wrapOrList);
}

class ListIsWrap extends ListDisplayState {
  const ListIsWrap() : super(true);

  @override
  List<Object> get props => [];
}

class ListIsColumn extends ListDisplayState {
  const ListIsColumn() : super(false);

  @override
  List<Object> get props => [];
}

