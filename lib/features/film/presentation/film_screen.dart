import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';

class FilmScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String type;
  final String addition;
  final List<LinkVideo> linkVideo;

  const FilmScreen({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.addition,
    required this.linkVideo}) : super(key: key);

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top
                + MediaQuery.of(context).size.width * 0.05),
            //Text('Хватит',style: TextStyle(fontSize: 40),),
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(onPressed: () {
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
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
                    child: SizedBox( //image film
                      width: MediaQuery.of(context).size.width / 100 * 55,
                      height: (MediaQuery.of(context).size.width / 100 * 55) / 100 * 153,
                      child: const Placeholder(),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.03,),
            Text('name film',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center),
            Text('addition',
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center),
            SizedBox(height: MediaQuery.of(context).size.width * 0.03),
            SizedBox( //image film
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 16 * 9,
              child: const Placeholder(),
            ),
          ]
      ),
    );
  }
}
