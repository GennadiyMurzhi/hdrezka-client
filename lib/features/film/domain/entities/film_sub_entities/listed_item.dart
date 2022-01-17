import 'package:equatable/equatable.dart';

class ListedItem extends Equatable{
  final String url;
  final String name;
  final String position;

  const ListedItem({
    required this.url,
    required this.name,
    required this.position
  });

  @override
  List<Object?> get props => [url, name, position];
}