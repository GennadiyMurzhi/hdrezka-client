import 'package:equatable/equatable.dart';

class FilmInformation extends Equatable{
  final String url;
  final String name;
  final String type;
  final String imageUrl;
  final String addition;

  const FilmInformation({
    required this.url,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.addition});

  @override
  // TODO: implement props
  List<Object?> get props => [url, name, type, imageUrl, addition];

}