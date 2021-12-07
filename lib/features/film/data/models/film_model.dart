import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:hdrezka_client/features/film/data/models/link_video_model.dart';

class FilmModel extends Film {
  const FilmModel({
    required int search_request_id,
    required String url,
    required String type,
    required List<LinkVideo> payload,
    required String status
  }) : super(
    search_request_id: search_request_id,
    url: url,
    type: type,
    payload: payload,
    status: status
  );

  factory FilmModel.fromJson(Map<String, dynamic> json) =>
      FilmModel(
        search_request_id: json['search_request_id'],
        url: json['url'],
        type: json['type'],
        payload: _mapListToLinkVideoList(json['payload'] as List<dynamic>),
        status: json['status']
      );

  Map<String, dynamic> toJson() {
    return {
      "search_request_id": search_request_id,
      "url": url,
      "type": type,
      "payload": payload
          .map((e) => {'resolution': e.resolution, 'url': e.url})
          .toString(),
      "status": status
    };
  }
}

List<LinkVideo> _mapListToLinkVideoList(List<dynamic> listFromJson) {
  listFromJson.map((e) => e as Map<String, dynamic>).toList();
  return List.generate(
      listFromJson.length,
          (index) => LinkVideoModel(
          resolution: listFromJson[index]['resolution'],
          url: listFromJson[index]['url']));
}