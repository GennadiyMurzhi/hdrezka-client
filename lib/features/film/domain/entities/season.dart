import 'package:equatable/equatable.dart';

class Season extends Equatable{
  final int seasonNumber;
  final int countOfEpisodes;

  const Season({
    required this.seasonNumber,
    required this.countOfEpisodes
  });

  @override
  List<Object?> get props => [seasonNumber, countOfEpisodes];
}

class SeasonList extends Equatable{
  final List<Season> seasonList;

  const SeasonList({
    required this.seasonList
  });

  @override
  List<Object?> get props => [seasonList];
}