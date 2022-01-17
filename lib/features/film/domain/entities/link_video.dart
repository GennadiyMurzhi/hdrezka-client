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

class LinkVideoList extends Equatable{
  final List<LinkVideo> linkVideoList;

  const LinkVideoList({
    required this.linkVideoList
  });

  @override
  List<Object?> get props => [linkVideoList];
}