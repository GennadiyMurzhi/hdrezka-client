import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/title_for_main_cubit.dart';

class TitleForMainWidget extends StatelessWidget {
  const TitleForMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TitleForMainCubit, TitleForMainState>(
      builder: (context, state) {
        return state is NoTitle
            ? Container()
            : Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.035
              ),
              child: Text(
                  (state as TitleSearch).title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline6,
                ),
            );
      },
    );
  }
}
