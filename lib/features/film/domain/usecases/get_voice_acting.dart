import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/usecases/repository_usecase.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/entities/voice_acting.dart';
import 'package:hdrezka_client/features/film/domain/repository/film_repository.dart';
import 'package:hdrezka_client/features/film/domain/repository/voice_acting_repository.dart';

class GetVoiceActingList extends RepositoryUseCase<VoiceActingList, Params>{
  final VoiceActingListRepository repository;

  GetVoiceActingList(this.repository);

  @override
  Future<Either<Failure, VoiceActingList>> call(Params params) {
    return repository.getVoiceActingList(params.document);
  }
}

class Params extends Equatable {
  String document;

  Params({
    required this.document
  });

  @override
  List<Object?> get props => [document];
}