import 'package:equatable/equatable.dart';

class ASeries extends Equatable{
  final String url;
  final String name;

  const ASeries({
    required this.url,
    required this.name
  });

  @override
  List<Object?> get props => [url, name];
}