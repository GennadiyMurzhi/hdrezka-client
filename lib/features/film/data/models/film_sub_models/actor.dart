import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/actor.dart';

class ActorModel extends Actor{
  const ActorModel({
    required String url,
    required String name
  }) : super(
    url: url,
    name: name
  );

  @override
  List<Object?> get props => [url, name];
}