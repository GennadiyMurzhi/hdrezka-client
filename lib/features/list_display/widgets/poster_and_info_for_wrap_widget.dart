import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdrezka_client/features/film/presentation/film_screen.dart';

class PosterAndInfoForWrap extends StatelessWidget {
  final int search_request_id;
  final String type;
  final String nameFilm;
  final String addition;
  final String imageUrl;
  final String filmUrl;

  const PosterAndInfoForWrap(
      {Key? key,
      required this.search_request_id,
      required this.type,
      required this.nameFilm,
      required this.addition,
      required this.imageUrl,
      required this.filmUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizePoster = _SizePosterForWrap(MediaQuery.of(context).size.width);

    return Stack(
      children: [
          SizedBox(
            width: sizePoster.posterWidth,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border:
                        Border.all(color: Theme.of(context).hintColor, width: 1)),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  width: sizePoster.posterWidth,
                  height: sizePoster.posterHeight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                            color: Theme.of(context).hintColor, width: 1)),
                    child: Stack(alignment: Alignment.topRight, children: [
                      Image.network(
                        imageUrl,
                        width: sizePoster.posterWidth,
                        height: sizePoster.posterHeight,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.grey,
                        child: Text(
                          type,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 100 * 10)
            ]),
          ),
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => FilmScreen(
                          search_request_id: search_request_id,
                          imageUrl: imageUrl,
                          name: nameFilm,
                          type: type,
                          addition: addition,
                          filmUrl: filmUrl)));
            },
            child: SizedBox(
              width: sizePoster.posterWidth,
              child: Column(
                children: [
                  SizedBox(
                    width: sizePoster.posterWidth,
                    height: sizePoster.posterHeight,
                  ),
                  nameFilm.length *
                      Theme.of(context).textTheme.subtitle1!.fontSize!.toDouble() *
                      MediaQuery.of(context).textScaleFactor >
                      sizePoster.posterWidth
                      ? Text(
                      _stringToStringWithEllipsis(
                          nameFilm,
                          sizePoster.posterWidth,
                          Theme.of(context).textTheme.subtitle1!.fontSize!.toDouble() *
                              MediaQuery.of(context).textScaleFactor),
                      style: Theme.of(context).textTheme.subtitle1)
                      : Text(nameFilm, style: Theme.of(context).textTheme.subtitle1),
                  Text(addition,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.center),
                ]
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SizePosterForWrap {
  final double displayPhysicalWidth;

  _SizePosterForWrap(this.displayPhysicalWidth) {
    posterWidth = displayPhysicalWidth / 100 * 40;
    posterHeight = posterWidth / 100 * 153;
  }

  late final double posterWidth;
  late final double posterHeight;
}

///letterSize is fontSize multiplied by textScaleFactor
String _stringToStringWithEllipsis(
    String nameFilm, double posterWidth, double letterSize) {
  final int neededLaterCount = posterWidth ~/ letterSize;
  return nameFilm.substring(0, neededLaterCount + 1) + '...';
}
