import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hdrezka_client/features/search/domain/entities/film_information.dart';
import 'package:hdrezka_client/features/list_display/widgets/poster_and_info_for_wrap_widget.dart';
import '../cubit/list_display_cubit.dart';

class ListDisplay extends StatelessWidget {
  //TODO: FIX NEEDING IN SEARCH RESULT ID OR OTHER ID
  final int search_request_id;
  final List<FilmInformation> listOfFilms;

  const ListDisplay({Key? key, required this.search_request_id, required this.listOfFilms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ListDisplayCubit(),
      child: BlocBuilder<ListDisplayCubit, ListDisplayState>(
          builder: (BuildContext context, ListDisplayState state) {
        return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        enableFeedback: state.wrapOrList,
                        onPressed: () {
                          BlocProvider.of<ListDisplayCubit>(context)
                              .displayAsWrap();
                        },
                        icon: FaIcon(FontAwesomeIcons.borderAll,
                            color: state.wrapOrList
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).primaryColorDark)),
                    IconButton(
                        enableFeedback: state.wrapOrList,
                        onPressed: () {
                          BlocProvider.of<ListDisplayCubit>(context)
                              .displayAsColumn();
                        },
                        icon: FaIcon(FontAwesomeIcons.columns,
                            color: state.wrapOrList
                                ? Theme.of(context).primaryColorDark
                                : Theme.of(context).primaryColor)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05,)
                  ],
                ),
                state.wrapOrList
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 100 * 8),
                        child: Wrap(
                            spacing: MediaQuery.of(context).size.width / 100 * 4,
                            children: List.generate(
                                listOfFilms.length,
                                (index) => PosterAndInfoForWrap(
                                    search_request_id: search_request_id,
                                    type: listOfFilms.elementAt(index).type,
                                    nameFilm: listOfFilms.elementAt(index).name,
                                    addition: listOfFilms.elementAt(index).addition,
                                    imageUrl: listOfFilms.elementAt(index).imageUrl,
                                    filmUrl: listOfFilms.elementAt(index).url
                                ))),
                    )
                    : Column(
                        children: List.generate(
                            listOfFilms.length,
                            (index) => PosterAndInfoForWrap(
                                search_request_id: search_request_id,
                                type: listOfFilms.elementAt(index).type,
                                nameFilm: listOfFilms.elementAt(index).name,
                                addition: listOfFilms.elementAt(index).addition,
                                imageUrl: listOfFilms.elementAt(index).imageUrl,
                                filmUrl: listOfFilms.elementAt(index).url
                            ))
                      )
              ],
            ),
        );
      }),
    );
  }
}
