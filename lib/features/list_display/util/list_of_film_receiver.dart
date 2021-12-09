import 'package:hdrezka_client/features/search/domain/entities/film_information.dart';
import 'package:rxdart/rxdart.dart';

class ListOfFilmReceiver {
  ListOfFilmsParams listOfFilmInformation;

  ListOfFilmReceiver(this.listOfFilmInformation)
      : getNewListEvent = BehaviorSubject<ListOfFilmsParams>.seeded(listOfFilmInformation);

  final BehaviorSubject<ListOfFilmsParams> getNewListEvent;

  Future getNewListOfFilms(ListOfFilmsParams newListOfFilmInformation) async {
    getNewListEvent.add(listOfFilmInformation = newListOfFilmInformation);
  }

}

class ListOfFilmsParams {
  final int search_request_id;
  final List<FilmInformation> listOfFilmInformation;

  ListOfFilmsParams({
    required this.search_request_id,
    required this.listOfFilmInformation
  });

}