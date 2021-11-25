import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hdrezka_client/features/search/presentation/bloc/search_bloc.dart';
import 'package:hdrezka_client/features/search/presentation/widgets/pre_result_widget.dart';

class SearchView extends StatelessWidget{

  final TextEditingController _textSearchController = TextEditingController();

  SearchView({Key? key}) : super(key: key);

  late final double _targetSearchLinkWidth;

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    _targetSearchLinkWidth = BlocProvider.of<SearchBloc>(context).state.isSearchActive ? data.size.width : 0;
    _textSearchController.text = BlocProvider.of<SearchBloc>(context).state.query;
    _textSearchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textSearchController.text.length));
    return Container(
      width: BlocProvider.of<SearchBloc>(context).state.isSearchActive ? double.maxFinite : 0,
      height: BlocProvider.of<SearchBloc>(context).state.isSearchActive ? double.maxFinite : 0,
      color: Colors.black12,
      alignment: Alignment.centerRight,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: _targetSearchLinkWidth),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeIn,
              builder: (BuildContext context, double width, Widget? child){
                return Container(
                  alignment: Alignment.bottomCenter,
                  width: width,
                  height: 50 + data.padding.top,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [Container(
                        alignment: Alignment.bottomCenter,
                        width: data.size.width,
                        child: Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                                  iconSize: 24 ,
                                  onPressed: () {
                                    BlocProvider.of<SearchBloc>(context)
                                        .add(DeActivated());
                                  },
                                  icon: const FaIcon(FontAwesomeIcons.arrowLeft,)),
                              const Spacer(),
                              SizedBox(
                                  width: width * 0.7,
                                  height: 35,
                                  child: TextField(
                                    controller: _textSearchController,
                                    cursorColor: Theme.of(context).focusColor,
                                    autofocus: true,
                                    style:
                                    TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(bottom: 9),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2, color: Theme.of(context).focusColor)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(width: 2, color: Theme.of(context).focusColor))),
                                    onChanged: (inputText) {
                                      BlocProvider.of<SearchBloc>(context).
                                      add(GetSearchResultForQuery(_textSearchController.text));
                                    },
                                  )),
                              const Spacer(),
                              /*IconButton(
                                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                                  iconSize: 24,
                                  onPressed: () {
                                    _textSearchController.text = '';
                                    BlocProvider.of<SearchBloc>(context).add(const SearchRestarted());
                                  },
                                  icon: const FaIcon(FontAwesomeIcons.times)),*/
                              const Spacer()
                            ]),
                      ),]
                  ),
                );
              },
            ),
            BlocProvider.of<SearchBloc>(context).state is Loaded
            ? PreResultWidget(
                preResult:
                    (BlocProvider.of<SearchBloc>(context).state as Loaded)
                        .preResult)
            : Container()
      ]
      ),);
  }
}