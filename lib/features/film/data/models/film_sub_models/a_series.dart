import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/a_series.dart';

class ASeriesModel extends ASeries{
  const ASeriesModel({
    required String url,
    required String name
  }) : super (
    url: url,
    name: name
  );

  @override
  List<Object?> get props => [url, name];
}