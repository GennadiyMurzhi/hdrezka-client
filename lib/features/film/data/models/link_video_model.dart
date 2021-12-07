import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';

class LinkVideoModel extends LinkVideo {
  const LinkVideoModel({
    required String resolution,
    required String url
  }) : super(
      resolution: resolution,
      url: url
  );

  factory LinkVideoModel.fromJson(Map<String, dynamic> json)=>
      LinkVideoModel(
        resolution: json['resolution'],
        url: json['url']
      );
}