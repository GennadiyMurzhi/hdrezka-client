import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hdrezka_client/features/search/domain/entities/film_information.dart';
import 'package:hdrezka_client/features/list_display/widgets/list_display_widget.dart';
import 'package:hdrezka_client/features/search/presentation/bloc/search_bloc.dart';
import 'package:hdrezka_client/features/search/presentation/widgets/search_widget.dart';
import 'package:hdrezka_client/features/title_for_main/title_widget.dart';

import 'features/list_display/util/list_of_film_receiver.dart';
import 'features/title_for_main/cubit/title_for_main_cubit.dart';
import 'injection_container.dart';


class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        drawer: const Drawer(),
        body: Builder(
          builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<SearchBloc>(
                    create: (context) => search<SearchBloc>()),
                BlocProvider<TitleForMainCubit>(create: (context) => TitleForMainCubit())
              ],
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (BuildContext context, searchState){
                  return Stack(
                      children: [
                        Scaffold(
                          appBar: PreferredSize(
                            preferredSize: const Size.fromHeight(50),
                            child: AppBar(
                              title: const Text('HDREZKA mobile'),
                              leading: IconButton(
                                  icon: const FaIcon(FontAwesomeIcons.bars,
                                      size: 23),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  }),
                              actions: [
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<SearchBloc>(context)
                                          .add(Activated());
                                    },
                                    icon: const FaIcon(FontAwesomeIcons.search))
                              ],
                            ),
                          ),
                          body: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TitleForMainWidget(),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.005),
                                StreamBuilder<ListOfFilmsParams>(
                                    stream: listDisplay<ListOfFilmReceiver>().getNewListEvent,
                                    builder: (context, snapshot){
                                    return snapshot.data != null
                                        ? ListDisplay(search_request_id: snapshot.data!.search_request_id,
                                            listOfFilms: snapshot.data!.listOfFilmInformation)
                                        : Container();
                                })
                              ],
                            ),
                          ),
                        ),
                        searchState.isSearchActive ? SearchView() : Container(),
                      ]
                  );
                },
              )
          ),
        )
    );
  }
}