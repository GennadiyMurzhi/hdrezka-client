import 'package:equatable/equatable.dart';

class LinkVideo extends Equatable {
  final String resolution;
  final String url;

  const LinkVideo ({
    required this.resolution,
    required this.url
  });

  @override
  List<Object?> get props => [resolution, url];

}