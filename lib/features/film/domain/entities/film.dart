import 'package:equatable/equatable.dart';

import 'link_video.dart';

class Film extends Equatable {
  final int search_request_id;
  final String url;
  final String type;
  final List<LinkVideo> payload;
  final String status;

  const Film({
    required this.search_request_id,
    required this.url,
    required this.type,
    required this.payload,
    required this.status});

  @override
  List<Object?> get props => [search_request_id, url, type, payload, status];

}