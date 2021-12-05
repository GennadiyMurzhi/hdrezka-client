import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/features/list_display/cubit/list_display_cubit.dart';

void main () {
  ListDisplayCubit? listDisplayCubit;

  setUp((){
    listDisplayCubit = ListDisplayCubit();
  });

  test('the first state is also the initialization state should be DeActivate', (){
    expect(listDisplayCubit!.state, equals(const ListIsWrap()));
  });

}