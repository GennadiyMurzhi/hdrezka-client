import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/core/error/failure.dart';
import 'package:hdrezka_client/core/usecases/repository_usecase.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:hdrezka_client/features/film/domain/repository/link_video_repository.dart';

class GetLinkVideoList extends RepositoryUseCase<LinkVideoList, Params>{
  final LinkVideoListRepository repository;

  GetLinkVideoList(this.repository);

  @override
  Future<Either<Failure, LinkVideoList>> call(Params params) {
    return repository.getLinkVideoList(params.document);
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