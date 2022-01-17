import 'package:hdrezka_client/features/film/domain/entities/season.dart';

class SeasonModel extends Season{
  const SeasonModel({
    required int seasonNumber,
    required int countOfEpisodes
  }) : super(
    seasonNumber: seasonNumber,
    countOfEpisodes: countOfEpisodes
  );

  ///return true if the episode is inside in season
  bool episodeChecker(int episodeNumber){
    if(countOfEpisodes >= episodeNumber) {
      return true;
    } else {
      return false;
    }
  }

  @override
  List<Object?> get props => [seasonNumber, countOfEpisodes];

}

class SeasonListModel extends SeasonList {
  final List<SeasonModel> seasonList;

  const SeasonListModel({
    required this.seasonList
  }) : super(seasonList: seasonList);

  factory SeasonListModel.fromDocument(String document) =>
      SeasonListModel(
          seasonList: _documentListToSeasonList(document));

  factory SeasonListModel.fromJson(Map<String, dynamic> json) =>
      SeasonListModel(
          seasonList: _mapListToSeasonList(json['seasonList'] as List<dynamic>));

  Map<String, dynamic> toJson() => {
    'seasonList': seasonList.map((e) => {
      'countOfEpisodes': e.countOfEpisodes,
      'serialNumber': e.seasonNumber
    }).toString()
  };

  ///return true if the season is inside in list
  bool seasonChecker(int seasonNumber){
    final soughtSeason = seasonList.where(
            (element) => element.seasonNumber == seasonNumber);
    if(soughtSeason.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

}

List<SeasonModel> _documentListToSeasonList(String document) {
  final matchesLinks = RegExp(r'data-season_id="(\d+)".+?data-episode_id="(\d+)"')
      .allMatches(document);

  if(matchesLinks.isNotEmpty){
    final List<SeasonModel> seasonList = List.empty(growable: true);
    seasonList.add(SeasonModel(
        seasonNumber: int.parse(matchesLinks.elementAt(matchesLinks.length - 1).group(1)!),
        countOfEpisodes: int.parse(matchesLinks.elementAt(matchesLinks.length - 1).group(2)!)
    ));

    for(int i = seasonList[0].seasonNumber - 1; i >= 1; i--){
      int episodeIterable = 0;
      for (int j = 0; j < seasonList.length; j++){
        episodeIterable += seasonList[j].countOfEpisodes;
      }

      seasonList.add(
          SeasonModel(
              seasonNumber: i,
              countOfEpisodes: int.parse(matchesLinks.elementAt(
                  matchesLinks.length
                      - episodeIterable - 1).
              group(2)!
              )));
    }

    return List.generate(seasonList.length,
            (index) => seasonList[seasonList.length - index - 1]);
  } else {
    return List.empty();
  }
}

List<SeasonModel> _mapListToSeasonList(List<dynamic> listFromDocument) {
  listFromDocument.map((e) => e as Map<String, dynamic>).toList();
  return List.generate(
      listFromDocument.length,
          (index) => SeasonModel(
          seasonNumber: listFromDocument[index]['serialNumber'],
          countOfEpisodes: listFromDocument[index]['countOfEpisodes']));
}