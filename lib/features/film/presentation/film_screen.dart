import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hdrezka_client/core/error/exeption.dart';
import 'package:hdrezka_client/core/remote_data_source/remote_data_source.dart';
import 'package:hdrezka_client/features/film/data/models/link_video_model.dart';
import 'package:hdrezka_client/features/film/presentation/widgets/player_widget.dart';
import 'package:hdrezka_client/injection_container.dart';

class FilmScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String type;
  final String addition;
  final String filmUrl;

  final RemoteDataSourceImpl _remoteDataSourceImpl = page();

  FilmScreen(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.type,
      required this.addition,
      required this.filmUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
          future: _remoteDataSourceImpl.getDocument(filmUrl),
          builder: (context, snapshot) {
            try{
              final LinkVideoListModel filmUrl = LinkVideoListModel.fromDocument(snapshot.data!);

              return snapshot.hasData ? Column(children: [
                SizedBox(
                    height: MediaQuery.of(context).padding.top +
                        MediaQuery.of(context).size.width * 0.05),
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
                              100 * 153,
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
                  child: PlayerWidget(videoLink: filmUrl.linkVideoList[filmUrl.linkVideoList.length - 1].url),
                ),
              ])
              : Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: const LinearProgressIndicator());

            } on ServerException{
              return Center(
                  child: Text(
                      'ServerFailure',
                      style: Theme.of(context).textTheme.headline3));
            }
      }),
    );
  }
}
