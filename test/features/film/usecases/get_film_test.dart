import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/features/film/domain/entities/film.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:hdrezka_client/features/film/domain/repository/film_repository.dart';
import 'package:hdrezka_client/features/film/domain/usecases/get_film.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_film_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<FilmRepository> (as: #MockFilmRepository)])
void main () {
  GetFilm? usecase;
  MockFilmRepository? mockFilmRepository;

  setUp((){
    mockFilmRepository = MockFilmRepository();
    usecase = GetFilm(mockFilmRepository!);
  });

  int search_request_id = 1;
  String url = 'https://rezka.ag/films/drama/39111-ded-privet-2018.html';
  String type = 'films';

  const film = Film(
    search_request_id: 0,
    url: 'https://rezka.ag/films/fantasy/41834-snova-privet-1987.html',
    type: 'films',
    payload: <LinkVideo>[
        LinkVideo(
            resolution: '360p',
            url: 'https://stream.voidboost.cc/3/7/6/9/8/8/ebbad219ee853a9ef1e68cdf9df87381:2021100517:2e179457-952a-4834-a712-0fcaa5358126/bie1b.mp4'
      )],
    status: 'string'
  );

  test('', () async {
    when(mockFilmRepository!.getFilm(search_request_id, url, type))
        .thenAnswer((realInvocation) async => const Right(film));

    final result = await usecase!(Params(
        search_request_id: search_request_id,
        url: url,
        type: type
    ));

    expect(result, const Right(film));

    verify(mockFilmRepository!.getFilm(search_request_id, url, type));

    verifyNoMoreInteractions(mockFilmRepository);
  });
}