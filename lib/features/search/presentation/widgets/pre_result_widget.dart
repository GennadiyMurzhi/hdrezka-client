import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdrezka_client/features/film/presentation/film_screen.dart';
import 'package:hdrezka_client/features/search/presentation/bloc/search_bloc.dart';
import 'package:hdrezka_client/features/title_for_main/cubit/title_for_main_cubit.dart';
import '../util/pre_search_result_maker.dart';

class PreResultWidget extends StatelessWidget {
  final PreResult preResult;

  const PreResultWidget({
    Key? key,
    required this.preResult
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return preResult.preResultList.isEmpty
        ? Column()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //**********************************************************
      //TODO:**************FIX IN NEXT ITERATION******************
      //**********************************************************
      children: List.generate(preResult.unreleasedFilmsCount !=0
          ? preResult.preResultList.length + 5
          : preResult.preResultList.length * 2 - 1, (index) {
        if (index == 9) {
          return ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff777777)
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size(double.maxFinite, 45)),
                  shadowColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(0, 0, 0, 0)),
                  elevation: MaterialStateProperty.all<double>(0),
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                  side: MaterialStateProperty.all<BorderSide>(const BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0))),
                  shape: MaterialStateProperty.all<OutlinedBorder>(const ContinuousRectangleBorder(
                      side: BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0)))),
                  alignment: Alignment.center,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
              onPressed: () {
                BlocProvider.of<SearchBloc>(context).add(ShowSearchResult());
                BlocProvider.of<TitleForMainCubit>(context).titleSearch(
                    BlocProvider.of<SearchBloc>(context).state.query);
              },
              child: Text(
                '???????????????? ?????? ???????????????????? (?????? ${preResult.unreleasedFilmsCount} ????????????????????)',
                style: const TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 17
                ),
              ));
        } else if(index%2 == 0) {
          return TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size(double.maxFinite, 50)),
                  shadowColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(0, 0, 0, 0)),
                  elevation: MaterialStateProperty.all<double>(0),
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                  side: MaterialStateProperty.all<BorderSide>(const BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0))),
                  shape: MaterialStateProperty.all<OutlinedBorder>(const ContinuousRectangleBorder(
                      side: BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0)))),
                  alignment: Alignment.centerLeft,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                    textBaseline: TextBaseline.alphabetic
                  ))
              ),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => FilmScreen(
                          search_request_id: preResult.search_request_id,
                          imageUrl: preResult.preResultList[index~/2].imageUrl,
                          name: preResult.preResultList[index~/2].name,
                          type: preResult.preResultList[index~/2].type,
                          addition: preResult.preResultList[index~/2].addition,
                          filmUrl: preResult.preResultList[index~/2].url)));
                BlocProvider.of<SearchBloc>(context).add(DeActivated());
                },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        ' ${preResult.preResultList[index~/2].name}',
                        style: const TextStyle(
                            color: Color(0xff2e859e),
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        )
                    ),
                    Text(
                        '(${preResult.preResultList[index~/2].addition})',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).textTheme.bodyText2!.color
                        )
                    )
                  ],
                ),
              ));
        } else {
          return Container(height: 2, color: Theme.of(context).dividerColor,
          );
        }
      }),
    );
  }

}