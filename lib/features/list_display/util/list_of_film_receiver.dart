import 'package:hdrezka_client/features/search/domain/entities/film_information.dart';
import 'package:rxdart/rxdart.dart';

class ListOfFilmReceiver {
  List<FilmInformation> listOfFilmInformation;

  ListOfFilmReceiver(this.listOfFilmInformation)
      : getNewListEvent = BehaviorSubject<List<FilmInformation>>.seeded(listOfFilmInformation);

  final BehaviorSubject<List<FilmInformation>> getNewListEvent;

  Future getNewListOfFilms(List<FilmInformation> newListOfFilmInformation) async {
    getNewListEvent.add(listOfFilmInformation = newListOfFilmInformation);
  }

}