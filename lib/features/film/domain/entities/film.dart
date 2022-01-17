import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/a_series.dart';
import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/actor.dart';
import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/country.dart';
import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/genre.dart';
import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/listed_item.dart';
import 'package:hdrezka_client/features/film/domain/entities/voice_acting.dart';

class Film extends Equatable {
  //final String url;
  final double IMDBRating;
  final double kinopoiskRaiting;
  final List<ListedItem> listed;
  final String tagline;
  final String releaseDate;
  final List<Country> country;
  final List<Genre> genre;
  final String inQuality;
  final List<String> age;
  final String time;
  final List<ASeries> fromSeries;
  final List<Actor> castOfActors;
  final String whatIsAbout;
  List<VoiceActing> voiceActingList;
  final int filmId;
  final bool isSeries;

  Film({
    required this.IMDBRating,
    required this.kinopoiskRaiting,
    required this.listed,
    required this.tagline,
    required this.releaseDate,
    required this.country,
    required this.genre,
    required this.inQuality,
    required this.age,
    required this.time,
    required this.fromSeries,
    required this.castOfActors,
    required this.whatIsAbout,
    required this.voiceActingList,
    required this.filmId,
    required this.isSeries});

  @override
  List<Object?> get props => [IMDBRating, kinopoiskRaiting, listed, tagline,
    releaseDate, country, genre, inQuality, age, time, fromSeries, castOfActors,
    whatIsAbout, voiceActingList, filmId, isSeries];

}