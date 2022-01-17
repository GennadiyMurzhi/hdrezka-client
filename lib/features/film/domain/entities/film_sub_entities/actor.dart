import 'package:equatable/equatable.dart';

class Actor extends Equatable{
  final String url;
  final String name;

  const Actor({
    required this.url,
    required this.name
  });

  @override
  List<Object?> get props => [url, name];
}