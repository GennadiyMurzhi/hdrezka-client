import 'package:hdrezka_client/core/entities/film_information.dart';
import 'package:hdrezka_client/core/models/film_information_model.dart';
import 'package:hdrezka_client/features/search/domain/entities/search_result.dart';

class SearchResultModel extends SearchResult{
  const SearchResultModel({
    required int id,
    required String query,
    required List<FilmInformation> payload,
    required String status,
    required DateTime created,
    required DateTime updated
  }) : super(
          id: id,
          query: query,
          payload: payload,
          status: status,
          created: created,
          updated: updated);

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        id: json['id'],
        query: json['query'],
        payload: _mapListToFilmInformationList(json['payload'] as List<dynamic>),
        status: json['status'],
        created: DateTime.parse(json['created_at']) ,
        updated: DateTime.parse(json['updated_at'])
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'query': query,
      'payload': payload.map((e) => {
        'url': e.url,
        'name': e.name,
        'type': e.type,
        'image': e.imageUrl,
        'addition': e.addition
      }).toString(),
      'status': status,
      'created_at': created.toString(),
      'updated_at': updated.toString()
    };
  }
}

List<FilmInformation> _mapListToFilmInformationList(List<dynamic> listFromJson) {
  listFromJson.map((e) => e as Map<String, dynamic>).toList();
  return List.generate(
      listFromJson.length,
      (index) => FilmInformationModel(
          url: listFromJson[index]['url'],
          name: listFromJson[index]['name'],
          type: listFromJson[index]['type'],
          imageUrl: listFromJson[index]['image'],
          addition: listFromJson[index]['addition']));
}