import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:hdrezka_client/features/film/domain/entities/season.dart';


class LinkVideoModel extends LinkVideo {
  const LinkVideoModel({
    required String resolution,
    required String url
  }) : super(
      resolution: resolution,
      url: url
  );

  factory LinkVideoModel.fromJson(Map<String, dynamic> json) =>
      LinkVideoModel(
        resolution: json['resolution'],
        url: json['url']
      );
}

class LinkVideoListModel extends LinkVideoList {
  const LinkVideoListModel({
    required List<LinkVideo> linkVideoList
  }) : super(linkVideoList: linkVideoList);

  factory LinkVideoListModel.fromDocument(String document) =>
      LinkVideoListModel(
          linkVideoList: _documentListToLinkVideoList(document));

  factory LinkVideoListModel.fromJson(Map<String, dynamic> json) =>
      LinkVideoListModel(
          linkVideoList: _mapListToLinkVideoList(json['linkVideoList'] as List<dynamic>));

  Map<String, dynamic> toJson() => {
    'seasonList': linkVideoList.map((e) => {
      'resolution': e.resolution,
      'url': e.url
    }).toString()
  };
}

List<LinkVideo> _documentListToLinkVideoList(String document) {
  final matchesLinks = RegExp(r'\[(\d+p|\d+p\s*Ultra)\](.+?\.mp4)')
      .allMatches(document);

  return List.generate(matchesLinks.length,
          (index) => LinkVideoModel(
          url: matchesLinks.elementAt(index).group(2)!.replaceAll('\\',''),
          resolution: matchesLinks.elementAt(index).group(1)!));
}


List<LinkVideo> _mapListToLinkVideoList(List<dynamic> listFromDocument) {
  listFromDocument.map((e) => e as Map<String, dynamic>).toList();
  return List.generate(
      listFromDocument.length,
          (index) => LinkVideoModel(
          resolution: listFromDocument[index]['resolution'],
          url: listFromDocument[index]['url']));
}