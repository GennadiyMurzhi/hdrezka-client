import 'package:equatable/equatable.dart';

class Country extends Equatable{
  final String url;
  final String name;

  const Country({
    required this.url,
    required this.name
  });

  @override
  List<Object?> get props => [url, name];
}