import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/genre.dart';

class GenreModel extends Genre{
  const GenreModel({
    required String url,
    required String name
  }) : super(
    url: url,
    name: name
  );

  @override
  List<Object?> get props => [url, name];
}