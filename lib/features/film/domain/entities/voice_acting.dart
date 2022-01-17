import 'package:equatable/equatable.dart';

class VoiceActing extends Equatable{
  final int id;
  final String name;
  final String language;

  const VoiceActing({
    required this.id,
    required this.name,
    required this.language
  });
  @override
  List<Object?> get props => [id, name, language];
}

class VoiceActingList extends Equatable{
  final List<VoiceActing> voiceActingList;

  const VoiceActingList({
    required this.voiceActingList
  });

  @override
  List<Object?> get props => [voiceActingList];
}