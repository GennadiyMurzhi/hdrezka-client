import 'package:equatable/equatable.dart';

class Genre extends Equatable{
  final String url;
  final String name;

  const Genre({
    required this.url,
    required this.name
  });

  @override
  List<Object?> get props => [url, name];
}