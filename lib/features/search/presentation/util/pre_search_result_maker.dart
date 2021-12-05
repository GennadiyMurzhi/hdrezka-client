import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/core/entities/film_information.dart';
import 'package:hdrezka_client/core/error/failure.dart';

class PreSearchResultMaker {
  PreResult listToPreResult(List<FilmInformation> listOfFoundFilms){
    final int unreleasedFilmsCount;
    final List<FilmInformation> preResultList;

    if (listOfFoundFilms.length > 5) {
      preResultList =
          List.generate(5, (index) => listOfFoundFilms.elementAt(index));
      unreleasedFilmsCount = listOfFoundFilms.length - 5;
    } else {
      preResultList = List.from(listOfFoundFilms);
      unreleasedFilmsCount = 0;
    }

    return PreResult(
        preResultList: preResultList,
        unreleasedFilmsCount: unreleasedFilmsCount);
  }
}

class PreResult extends Equatable{
  final int unreleasedFilmsCount;
  final List<FilmInformation> preResultList;

  PreResult({required this.unreleasedFilmsCount, required this.preResultList});

  @override
  List<Object?> get props => [unreleasedFilmsCount, preResultList];
}


