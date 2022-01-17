import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hdrezka_client/core/remote_data_source/remote_data_source.dart';
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:hdrezka_client/features/film/data/models/link_video_model.dart';
import 'package:hdrezka_client/features/film/data/models/season_model.dart';
import 'package:hdrezka_client/features/film/data/repositories/film_repository_impl.dart';
import 'package:hdrezka_client/features/film/data/repositories/link_video_repository_impl.dart';
import 'package:hdrezka_client/features/film/data/repositories/season_repository_impl.dart';
import 'package:hdrezka_client/core/error/failure.dart' as fail;

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final RemoteDataSourceImpl remoteDataSource;
  final FilmRepositoryImpl filmRepository;
  //VoiceActingListRepositoryImpl voiceActingListRepository;
  final SeasonListRepositoryImpl seasonListRepository;
  final LinkVideoListRepositoryImpl linkVideoListRepository;

  late String url;
  late String document;

  late FilmModel filmModel;
  //late VoiceActingListModel voiceActingListModel;
  late SeasonListModel seasonListModel;
  late LinkVideoListModel linkVideoListModel;
  
  late FilmStateInfo filmStateInfo;

  FilmBloc({
    required this.remoteDataSource,
    required FilmRepositoryImpl film,
    //required VoiceActingListRepositoryImpl voiceActingList,
    required SeasonListRepositoryImpl seasonList,
    required LinkVideoListRepositoryImpl linkVideoList
  }) : filmRepository = film,
       //voiceActingListRepository = voiceActingList,
       seasonListRepository = seasonList,
       linkVideoListRepository = linkVideoList,
  super(FilmInitial()) {
    //OpenFil must be first event
    on<OpenFilm>((event, emit) async {
      emit(FilmLoading());

      filmStateInfo = FilmStateInfo(
          voiceActingId: filmModel.voiceActingList.first.id,
          seasonNumber: seasonListModel.seasonList.first.seasonNumber,
          episodeNumber: 1);

      receivingInformation(event, emit);

      emitLoaded(emit);
    });

    on<SelectedVoiceActing>((event, emit) async {
      emit(VoiceActingListLoading());
      //At the beginning we update the models with the changed voiceActingId, in order
      //to find out what season and episodes there are in this voice acting
      filmStateInfo.voiceActingId = event.voiceActingId;

      receivingInformation(event, emit);

      //Check if there is a selected season and episode in this voice acting
      filmStateInfo.seasonNumber =
          seasonListModel.seasonChecker(filmStateInfo.seasonNumber)
              ? filmStateInfo.seasonNumber
              : seasonListModel.seasonList.last.seasonNumber;

      //Get the season to check the episode
      final soughtSeason = seasonListModel.seasonList.where(
              (element) => element.seasonNumber == filmStateInfo.seasonNumber);

      if(soughtSeason.isNotEmpty) {
        filmStateInfo.episodeNumber = soughtSeason.first.episodeChecker(filmStateInfo.episodeNumber)
            ? filmStateInfo.episodeNumber
            : soughtSeason.first.countOfEpisodes;
      }

      //In order not to repeat the production of models, we send an SelectedEpisode event in order
      //to update only the LinkVideoListModel
      receivingInformation(SelectedEpisode(filmStateInfo.episodeNumber), emit);

      emitLoaded(emit);
    });

    //Information about the seasons is already there. When choosing a season, we expose the first episode
    on<SelectedSeason>((event, emit) async {
      emit(SeasonListLoading());

      filmStateInfo.seasonNumber = event.serialNumber;

      filmStateInfo.episodeNumber = 1;
      //only need to get video links
      receivingInformation(event, emit);

      emitLoaded(emit);
    });

    on<SelectedEpisode>((event, emit) async {
      emit(LinkVideoListLoading());

      filmStateInfo.episodeNumber = event.numberOfEpisode;
      //only need to get video links
      receivingInformation(event, emit);

      emitLoaded(emit);
    });
  }

  ///Depending on the event, returns the models to be replaced, or emit an error state.
  ///If models are loaded successfully, at the end it emit a loaded state
  void receivingInformation(FilmEvent event, Emitter<FilmState> emit) async {
    //OpenFilm should be the first event
    if (event is OpenFilm) {
      url = event.url;

      document = await remoteDataSource.getDocument(url);

      final filmEither = await filmRepository.getFilm(document);

      filmEither.fold(
              (failure) => emit(FilmError(
              'film loading error ' + fail.failureToMessage(failure))),
              (filmModel) => filmModel = this.filmModel);
    }

    if (event is OpenFilm ||
        event is SelectedVoiceActing){
      /*final voiceActingListEither = await voiceActingListRepository.getVoiceActingList(document);

     voiceActingListEither.fold(
              (failure) => emit(VoiceActingError(
              'voices acting loading error ' + fail.failureToMessage(failure))),
              (voiceActingListModel) => voiceActingListModel = this.voiceActingListModel);*/

      final seasonListEither = await seasonListRepository.getSeasonList(document);

      seasonListEither.fold(
              (failure) => emit(SeasonError(
              'seasons loading error ' + fail.failureToMessage(failure))),
              (seasonListModel) => seasonListModel = this.seasonListModel);
    }

    /*if (event is OpenFilm ||
        event is SelectedVoiceActing || 
        event is SelectedSeason){
      final seasonListEither = await seasonListRepository.getSeasonList(document);

      seasonListEither.fold(
              (failure) => emit(SeasonError(
              'seasons loading error ' + fail.failureToMessage(failure))),
              (seasonListModel) => seasonListModel = this.seasonListModel);
    }*/

    if (event is OpenFilm ||
        event is SelectedVoiceActing ||
        event is SelectedSeason ||
        event is SelectedEpisode){
      final linkVideoListEither = await linkVideoListRepository.getLinkVideoList(document);

      linkVideoListEither.fold(
              (failure) => emit(LinkVideoError(
              'link video loading error ' + fail.failureToMessage(failure))),
              (linkVideoListModel) => linkVideoListModel = this.linkVideoListModel);
    }

  }

  void emitLoaded(Emitter<FilmState> emit){
    emit(Loaded(
        film: filmModel,
        seasonList: seasonListModel,
        linkVideoList: linkVideoListModel,
        filmStateInfo: filmStateInfo));
  }

}

class FilmStateInfo{
  late int voiceActingId;
  late int seasonNumber;
  late int episodeNumber;

  FilmStateInfo({
      required this.voiceActingId,
      required this.seasonNumber,
      required this.episodeNumber});
}