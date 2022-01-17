import 'package:hdrezka_client/features/film/domain/entities/film_sub_entities/listed_item.dart';

class ListedItemModel extends ListedItem{
  const ListedItemModel({
    required String url,
    required String name,
    required String position
  }) : super(
    url: url,
    name: name,
    position: position
  );

  @override
  List<Object?> get props => [url, name];
}