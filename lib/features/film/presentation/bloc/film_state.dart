part of 'film_bloc.dart';

abstract class FilmState extends Equatable {
  const FilmState();
}

class FilmInitial extends FilmState {
  @override
  List<Object> get props => [];
}

class FilmLoading extends FilmState {
  @override
  List<Object> get props => [];
}

class VoiceActingListLoading extends FilmState {
  @override
  List<Object> get props => [];
}

class SeasonListLoading extends FilmState {
  @override
  List<Object> get props => [];
}

class LinkVideoListLoading extends FilmState {
  @override
  List<Object> get props => [];
}

class FilmError extends FilmState{
  final String errorMessage;

  const FilmError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class VoiceActingError extends FilmState{
  final String errorMessage;

  const VoiceActingError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class SeasonError extends FilmState{
  final String errorMessage;

  const SeasonError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class LinkVideoError extends FilmState{
  final String errorMessage;

  const LinkVideoError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class Loaded extends FilmState{
  final FilmModel film;
  //final VoiceActingListModel voiceActingList;
  final SeasonListModel seasonList;
  final LinkVideoListModel linkVideoList;

  final FilmStateInfo filmStateInfo;

  const Loaded({
    required this.film,
    //required this.voiceActingList,
    required this.seasonList,
    required this.linkVideoList,
    required this.filmStateInfo
  });

  @override
  List<Object?> get props => [film, /*voiceActingList,*/ seasonList, linkVideoList];

}

