import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'title_for_main_state.dart';

class TitleForMainCubit extends Cubit<TitleForMainState> {
  TitleForMainCubit() : super(NoTitle());

  void titleInitial() => emit(NoTitle());
  
  void titleSearch(String query) => emit(TitleSearch(query));
}
