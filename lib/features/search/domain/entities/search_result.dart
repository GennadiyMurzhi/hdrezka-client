import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/features/search/domain/entities/film_information.dart';

class SearchResult extends Equatable{
  final int id;
  final String query;
  final List<FilmInformation> payload;
  final String status;
  final DateTime created;
  final DateTime updated;

  const SearchResult({
    required this.id,
    required this.query,
    required this.payload,
    required this.status,
    required this.created,
    required this.updated
  });

  @override
  List<Object?> get props => [id, query, payload, status, created, updated];
}