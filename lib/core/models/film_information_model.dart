import 'package:hdrezka_client/core/entities/film_information.dart';

class FilmInformationModel extends FilmInformation {
  const FilmInformationModel({
      required String url,
      required String name,
      required String type,
      required String imageUrl,
      required String addition})
      : super(
            url: url,
            name: name,
            type: type,
            imageUrl: imageUrl,
            addition: addition);

  factory FilmInformationModel.fromJson(Map<String, dynamic> json){
    return FilmInformationModel(
      url: json['url'],
      name: json['name'],
      type: json['type'],
      imageUrl: json['image'],
      addition: json['addition']
    );
  }
}