import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_display_state.dart';

class ListDisplayCubit extends Cubit<ListDisplayState> {
  ListDisplayCubit() : super(const ListIsWrap());

  void displayAsWrap() => emit(const ListIsWrap());

  void displayAsColumn() => emit(const ListIsColumn());
}
