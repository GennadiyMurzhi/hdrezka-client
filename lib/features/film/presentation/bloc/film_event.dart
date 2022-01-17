part of 'film_bloc.dart';

abstract class FilmEvent extends Equatable {
  const FilmEvent();
}

class OpenFilm extends FilmEvent{
  final String url;

  const OpenFilm(this.url);

  @override
  List<Object?> get props => [];

}

class SelectedVoiceActing extends FilmEvent{
  final int voiceActingId;

  const SelectedVoiceActing(this.voiceActingId);

  @override
  List<Object?> get props => [voiceActingId];

}

class SelectedSeason extends FilmEvent{
  final int serialNumber;

  const SelectedSeason(this.serialNumber);

  @override
  List<Object?> get props => [serialNumber];

}

class SelectedEpisode extends FilmEvent{
  final int numberOfEpisode;

  const SelectedEpisode(this.numberOfEpisode);

  @override
  List<Object?> get props => [numberOfEpisode];

}
