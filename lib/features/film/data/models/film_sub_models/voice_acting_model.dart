import 'package:hdrezka_client/features/film/domain/entities/voice_acting.dart';

class VoiceActingModel extends VoiceActing{
 const VoiceActingModel({
    required int id,
    required String name,
    required String language
  }) : super(
    id: id,
   name: name,
   language: language
  );
  @override
  List<Object?> get props => [id, name, language];

}

/*
class VoiceActingListModel extends VoiceActingList {
  const VoiceActingListModel({
    required List<VoiceActing> voiceActingList
  }) : super(voiceActingList: voiceActingList);

  factory VoiceActingListModel.fromDocument(String document) =>
      VoiceActingListModel(
          voiceActingList: _documentListToVoiceActingList(document));

  factory VoiceActingListModel.fromJson(Map<String, dynamic> json) =>
      VoiceActingListModel(
          voiceActingList: _mapListToVoiceActingList(json['voiceActingList'] as List<dynamic>));

  Map<String, dynamic> toJson() => {
    'voiceActingList': voiceActingList.map((e) => {
      'id': e.id,
      'name': e.name,
      'language': e.language
    }).toString()
  };
}

List<VoiceActing> _documentListToVoiceActingList(String document) {
  final matchesLinks = RegExp(r'\s*data-translator_id\s*="(\d+)">(.+?)<(img\s*title="(\W+)"|)')
      .allMatches(document);

  return List.generate(matchesLinks.length,
          (index) => VoiceActingModel(
          id: int.parse(matchesLinks.elementAt(index).group(1)!),
          name: matchesLinks.elementAt(index).group(2)!,
          language: matchesLinks.elementAt(index).group(4) != null
              ? matchesLinks.elementAt(index).group(4)! : ''));
}

List<VoiceActing> _mapListToVoiceActingList(List<dynamic> listFromDocument) {
  listFromDocument.map((e) => e as Map<String, dynamic>).toList();
  return List.generate(
      listFromDocument.length,
          (index) => VoiceActingModel(
          id: listFromDocument[index]['id'],
          name: listFromDocument[index]['name'],
          language: listFromDocument[index]['language']));
}
*/