import 'package:hdrezka_client/features/film/data/models/film_sub_models/a_series.dart';
import 'package:hdrezka_client/features/film/data/models/film_sub_models/actor.dart';
import 'package:hdrezka_client/features/film/data/models/film_sub_models/country.dart';
import 'package:hdrezka_client/features/film/data/models/film_sub_models/genre.dart';
import 'package:hdrezka_client/features/film/data/models/film_sub_models/listed_item.dart';
import 'package:hdrezka_client/features/film/data/models/season_model.dart';
import 'package:hdrezka_client/features/film/data/models/film_sub_models/voice_acting_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/a_series.dart';
import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/actor.dart';
import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/country.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/genre.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:hdrezka_client/features/film/data/models/link_video_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/listed_item.dart';
import 'package:hdrezka_client/features/film/domain/entities/season.dart';
import 'package:hdrezka_client/features/film/domain/entities/voice_acting.dart';

class FilmModel extends Film {
  FilmModel({
    required double IMDBRating,
    required double kinopoiskRaiting,
    required List<ListedItem> listed,
    required String tagline,
    required String releaseDate,
    required List<Country> country,
    required List<Genre> genre,
    required String inQuality,
    required List<String> age,
    required String time,
    required List<ASeries> fromSeries,
    required List<Actor> castOfActors,
    required String whatIsAbout,
    required List<VoiceActing> voiceActingList,
    required int filmId,
    required bool isSeries
  }) : super(
    IMDBRating: IMDBRating,
    kinopoiskRaiting: kinopoiskRaiting,
    listed: listed,
    tagline: tagline,
    releaseDate: releaseDate,
    country: country,
    genre: genre,
    inQuality: inQuality,
    age: age,
    time: time,
    fromSeries: fromSeries,
    castOfActors: castOfActors,
    whatIsAbout: whatIsAbout,
    voiceActingList: voiceActingList,
    filmId: filmId,
    isSeries: isSeries
  );

  factory FilmModel.fromDocument(String document) {
    final Iterable<RegExpMatch> IMDBRatingMatch = RegExp(r'IMDb.+?class="bold">(\d{0,2}\.\d{0,2})<')
        .allMatches(document);
    final IMDBRating = IMDBRatingMatch.isNotEmpty
        ? double.parse(IMDBRatingMatch.elementAt(0).group(1)!) : 0.0;

    final Iterable<RegExpMatch> kinopoiskRaitingMatch = RegExp(r'Кинопоиск.+?class="bold">(\d{0,2}\.\d{0,2})<')
        .allMatches(document);
    final kinopoiskRaiting = kinopoiskRaitingMatch.isNotEmpty
        ? double.parse(kinopoiskRaitingMatch.elementAt(0).group(1)!) : 0.0;

    final listed = _documentListToListedItemList(document);

    final Iterable<RegExpMatch> taglineMatch = RegExp(r'Слоган.+?&laquo;(.+?)&raquo;')
        .allMatches(document);
    final tagline = taglineMatch.isNotEmpty ? taglineMatch.elementAt(0).group(1)! : '';

    final releaseDateMatch = RegExp(r'Дата выхода.+?<td>(.+?)<a\s*?href="(.+?)">(.+?)<').allMatches(document);
    final releaseDate = releaseDateMatch.isNotEmpty
        ? releaseDateMatch.elementAt(0).group(1)! + releaseDateMatch.elementAt(0).group(3)!
        : '';

    final country = _documentListToCountryList(document);

    final genre = _documentListToGenreList(document);

    final Iterable<RegExpMatch> inQualityMatch = RegExp(r'В качестве.+?<td>(.+?)<')
        .allMatches(document);
    final inQuality = inQualityMatch.isNotEmpty ? inQualityMatch.elementAt(0).group(1)! : '';

    final ageMatch = RegExp(r'Возраст.+?span.+?>(.+?)</span>(.+?)</td>').allMatches(document);
    final age = ageMatch.isNotEmpty
        ? List.generate(ageMatch.elementAt(0).groupCount,
            (index) => ageMatch.elementAt(0).group(index + 1)!)
        : List<String>.empty();

    final Iterable<RegExpMatch> timeMatch  = RegExp(r'itemprop="duration">(.+?)<')
        .allMatches(document);
    final time = timeMatch.isNotEmpty ? timeMatch.elementAt(0).group(1)! : '';

    final fromSeries = _documentListToFromSeriesList(document);

    //final castOfActors = _documentListToCastOfActorsList(document);

    final Iterable<RegExpMatch> whatIsAboutMatch  = RegExp(r'b-post__description_text">(.+?)<')
        .allMatches(document);
    final whatIsAbout = whatIsAboutMatch.isNotEmpty ? whatIsAboutMatch.elementAt(0).group(1)! : '';

    final voiceActingList = _documentListToVoiceActingList(document);

    final filmId = int.parse (RegExp(r'sof.tv.initWatchingEvents\((\d+)\)')
        .allMatches(document).elementAt(0).group(1)!);

    final Iterable<RegExpMatch> isSeriesMatch  = RegExp(r'initCDNSeriesEvents')
        .allMatches(document);
    final isSeries = isSeriesMatch.isNotEmpty ? true : false;

    final Iterable<RegExpMatch> dataCamRipMatch  = RegExp(r'data-camrip="(\d)"')
        .allMatches(document);
    final dataCamRip = dataCamRipMatch.isNotEmpty
        ? int.parse(dataCamRipMatch.elementAt(0).group(1)!)
        : -1;

    final Iterable<RegExpMatch> dataADSMatch  = RegExp(r'data-ads="(\d)"')
        .allMatches(document);
    final dataADS = dataADSMatch.isNotEmpty
        ? int.parse(dataADSMatch.elementAt(0).group(1)!)
        : -1;

    final Iterable<RegExpMatch> dataDirectorMatch  = RegExp(r'data-director="(\d)"')
        .allMatches(document);
    final dataDirector = dataDirectorMatch.isNotEmpty
        ? int.parse(dataDirectorMatch.elementAt(0).group(1)!)
        : -1;

    return FilmModel(
        IMDBRating: IMDBRating,
        kinopoiskRaiting: kinopoiskRaiting,
        listed: listed,
        tagline: tagline,
        releaseDate: releaseDate,
        country: country,
        genre: genre,
        inQuality: inQuality,
        age: age,
        time: time,
        fromSeries: fromSeries,
        castOfActors: List<Actor>.empty(),
        whatIsAbout: whatIsAbout,
        voiceActingList: voiceActingList,
        filmId: filmId,
        isSeries: isSeries
    );
  }

  factory FilmModel.fromJson(Map<String, dynamic> json) =>
      FilmModel(IMDBRating: json['IMDBRating'],
          kinopoiskRaiting: json['kinopoiskRaiting'],
          listed: _mapListToListedItemList(json['listed'] as List<dynamic>),
          tagline: json['tagline'],
          releaseDate: json['releaseDate'],
          country: _mapListToCountryList(json['country'] as List<dynamic>),
          genre: _mapListToGenreList(json['genre'] as List<dynamic>),
          inQuality: json['inQuality'],
          age: (json['age'] as List<dynamic>).map((e) => e as String).toList(),
          time: json['time'],
          fromSeries: _mapListToASeriesList(json['fromSeries'] as List<dynamic>),
          castOfActors: _mapListToActorList(json['castOfActors'] as List<dynamic>),
          whatIsAbout: json['whatIsAbout'],
          voiceActingList: _mapListToVoiceActingList(json['voiceActingList'] as List<dynamic>),
          filmId: int.parse(json['filmId']),
          isSeries: json['isSeries'] == 'true' ? true : false
      );

  Map<String, dynamic> toJson() {
    return {
      'IMDBRating': IMDBRating,
      'kinopoiskRaiting': kinopoiskRaiting,
      'listed': listed.map((e) => {'url': e.url,
        'name': e.name}).toString(),
      'tagline': tagline,
      'releaseDate': releaseDate.toString(),
      'country': country.map((e) => {'url': e.url,
        'name': e.name}).toString(),
      'genre': genre.map((e) => {'url': e.url,
          'name': e.name}).toString(),
      'inQuality': inQuality,
      'age': age,
      'time': time,
      'fromSeries': fromSeries.map((e) => {'url': e.url,
        'name': e.name}).toString(),
      'castOfActors': castOfActors.map((e) => {'url': e.url,
        'name': e.name}).toString(),
      'whatIsAbout': whatIsAbout,
      'voiceActingList': voiceActingList.map((e) => {
        'id': e.id,
        'name': e.name,
        'language': e.language,
      }).toString(),
      'filmId': filmId,
      'isSeries' : isSeries.toString()
    };
  }
}

void _setUpListJson(List<dynamic> listFromDocument) =>
    listFromDocument.map((e) => e as Map<String, dynamic>).toList();

List<ListedItem> _mapListToListedItemList(List<dynamic> listFromDocument) {
  _setUpListJson(listFromDocument);
  return List.generate(
      listFromDocument.length,
          (index) => ListedItemModel(
          url: listFromDocument[index]['url'],
          name: listFromDocument[index]['name'],
          position: listFromDocument[index]['position']));
}

List<Country> _mapListToCountryList(List<dynamic> listFromDocument) {
  _setUpListJson(listFromDocument);
  return List.generate(
      listFromDocument.length,
          (index) => CountryModel(
          url: listFromDocument[index]['url'],
          name: listFromDocument[index]['name']));
}

List<Genre> _mapListToGenreList(List<dynamic> listFromDocument) {
  _setUpListJson(listFromDocument);
  return List.generate(
      listFromDocument.length,
  (index) => GenreModel(
      url: listFromDocument[index]['url'],
      name: listFromDocument[index]['name']));
}

List<ASeries> _mapListToASeriesList(List<dynamic> listFromDocument) {
  _setUpListJson(listFromDocument);
  return List.generate(
      listFromDocument.length,
          (index) => ASeriesModel(
          url: listFromDocument[index]['url'],
          name: listFromDocument[index]['name']));
}

List<Actor> _mapListToActorList(List<dynamic> listFromDocument) {
  _setUpListJson(listFromDocument);
  return List.generate(
      listFromDocument.length,
          (index) => ActorModel(
          url: listFromDocument[index]['url'],
          name: listFromDocument[index]['name']));
}

List<VoiceActing> _mapListToVoiceActingList(List<dynamic> listFromDocument) {
  listFromDocument.map((e) => e as Map<String, dynamic>).toList();
  return List.generate(
      listFromDocument.length,
          (index) => VoiceActingModel(
          id: listFromDocument[index]['id'],
          name: listFromDocument[index]['name'],
          language: listFromDocument[index]['language']));
}


Iterable<RegExpMatch> _matchesLinks(
    String document, String regAllInOne, String regMatchesLinks) {
  final allInOne = RegExp(regAllInOne).allMatches(document);
   return RegExp(regMatchesLinks)
       .allMatches(allInOne.isNotEmpty ? allInOne.elementAt(0).group(0)! : '');
}

List<ListedItem> _documentListToListedItemList(String document){
  final matchesLinks = _matchesLinks(document,
      r'Входит в списки.+?(<a href="(.+?)">(.+?)</a>.*?\((.+?)\)(<br.*?>.*?)*)+',
      r'<a href="(.+?)">(.+?)</a>.*?(\(.+?\))');

  if(matchesLinks.isNotEmpty) {
    return List.generate(
        matchesLinks.length,
        (index) => ListedItemModel(
            url: matchesLinks.elementAt(index).group(1)!,
            name: matchesLinks.elementAt(index).group(2)!,
            position: matchesLinks.elementAt(index).group(3)!));
  } else {
    return List.empty();
  }
}

List<Country> _documentListToCountryList(String document){

  final matchesLinks = _matchesLinks(document,
      r'Страна.+?(<a href="(.+?)">(.+?)</a>.*?)+',
      r'<a href="(.+?)">(.+?)</a>.*?');

  return List.generate(matchesLinks.length,
          (index) => CountryModel(
          url: matchesLinks.elementAt(index).group(1)!,
          name: matchesLinks.elementAt(index).group(2)!));
}

List<Genre> _documentListToGenreList(String document){
  final matchesLinks = _matchesLinks(document,
      r'Жанр.+?(a href=".+?">.+?genre">.+?<.+?</a>.+?<)+',
      r'a href="(.+?)">.+?genre">(.+?)<');

  return List.generate(matchesLinks.length,
          (index) => GenreModel(
          url: matchesLinks.elementAt(index).group(1)!,
          name: matchesLinks.elementAt(index).group(2)!));
}

List<ASeries> _documentListToFromSeriesList(String document){
  final matchesLinks = _matchesLinks(document,
      r'Из серии.+?(a href=".+?">.+?</a>.+?<)+',
      r'a href="(.+?)">(.+?)</a>.+?<');

  return List.generate(matchesLinks.length,
          (index) => ASeriesModel(
          url: matchesLinks.elementAt(index).group(1)!,
          name: matchesLinks.elementAt(index).group(2)!));
}

List<VoiceActing> _documentListToVoiceActingList(String document) {
  final matchesLinks = RegExp(r'\s*data-translator_id\s*="(\d+)">(.+?)<(img\s*title="(\W+)"|)')
      .allMatches(document);

  return List.generate(matchesLinks.length,
          (index) => VoiceActingModel(
          id: int.parse(matchesLinks.elementAt(index).group(1)!),
          name: matchesLinks.elementAt(index).group(2)!,
          language: matchesLinks.elementAt(index).group(4) != null
              ? matchesLinks.elementAt(index).group(4)! : ''));
}
/*
List<Actor> _documentListToCastOfActorsList(String document){
  /*final allActors = RegExp(r'В ролях актеры.+?(span\s*class="item".+?a href=".+?".+?name">.+?</span></a>.+?>.+?>.+?<)+.+?class="item">(.+?)<')
      .allMatches(document);
  final matchesActors = RegExp(r'span\s*class="item".+?a href="(.+?)".+?name">(.+?)</span></a>.+?>.+?>.+?<')
      .allMatches(allActors.elementAt(0).group(0)!);*/

  final matchesLinks = _matchesLinks(document,
      r'В ролях актеры.+?(span\s*class="item".+?a href=".+?".+?name">.+?</span></a>.+?>.+?>.+?<)+',
      r'span\s*class="item".+?a href="(.+?)".+?name">(.+?)</span></a>.+?>.+?>.+?<');

  return List.generate(matchesLinks.length,
          (index) => ActorModel(
          url: matchesLinks.elementAt(index).group(1)!,
          name: matchesLinks.elementAt(index).group(2)!));
}
*/


