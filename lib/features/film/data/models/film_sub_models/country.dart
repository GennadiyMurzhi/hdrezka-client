import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/country.dart';

class CountryModel extends Country{
  const CountryModel({
    required String url,
    required String name
  }) : super(
    url: url,
    name: name
  );

  @override
  List<Object?> get props => [url, name];
}