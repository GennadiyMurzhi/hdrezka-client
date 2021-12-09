import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:hdrezka_client/features/film/domain/usecases/get_film.dart';
import 'package:hdrezka_client/features/film/presentation/widgets/player_widget.dart';
import 'package:hdrezka_client/injection_container.dart';

class FilmScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String type;
  final String addition;
  final String filmUrl;
  final int search_request_id;

  final GetFilm getFilm = page();

  FilmScreen(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.type,
      required this.addition,
      required this.filmUrl,
      required this.search_request_id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Either<Failure, Film>>(
          future: getFilm(Params(search_request_id: search_request_id, type: type, url: filmUrl)),
          builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.fold(
                  (l) => Center(
                      child: Text(
                          l.toString(),
                          style: Theme.of(context).textTheme.headline3)),
                  (r) => Column(children: [
                    SizedBox(
                        height: MediaQuery.of(context).padding.top +
                            MediaQuery.of(context).size.width * 0.05),
                    //Text('Хватит',style: TextStyle(fontSize: 40),),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              iconSize: 36,
                              icon: const FaIcon(
                                FontAwesomeIcons.chevronLeft,
                                color: Colors.grey,
                              )),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.03),
                            child: SizedBox(
                              //image film
                              width: MediaQuery.of(context).size.width / 100 * 55,
                              height: (MediaQuery.of(context).size.width / 100 * 55) /
                                  100 *
                                  153,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Text(name,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center),
                    Text(addition,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    SizedBox(
                      //image film
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 16 * 9,
                      //TODO: FIX
                      child: PlayerWidget(videoLink: r.payload[r.payload.length - 1].url),
                    ),
                  ]));
        }
        return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: const LinearProgressIndicator());
      }),
    );
  }
}
