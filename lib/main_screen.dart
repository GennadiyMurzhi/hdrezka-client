import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hdrezka_client/features/search/presentation/bloc/search_bloc.dart';
import 'package:hdrezka_client/features/search/presentation/widgets/search_widget.dart';

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
                    create: (context) => sl<SearchBloc>()),

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
                              children: [
                                //ContentView(filmList: _fakeList)
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