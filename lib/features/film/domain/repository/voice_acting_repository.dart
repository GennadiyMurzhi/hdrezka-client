import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/features/film/domain/entities/voice_acting.dart';

abstract class VoiceActingListRepository {
  Future<Either<Failure, VoiceActingList>> getVoiceActingList(String document);
}