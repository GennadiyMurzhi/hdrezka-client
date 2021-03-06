// Mocks generated by Mockito 5.0.16 from annotations
// in hdrezka_client/test/features/film/data/repositories/film_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:hdrezka_client/core/network/network_info.dart' as _i6;
import 'package:hdrezka_client/features/film/data/datasurces/film_local_data_source.dart'
    as _i3;
import 'package:hdrezka_client/features/film/data/datasurces/film_remote_data_source.dart'
    as _i5;
import 'package:hdrezka_client/features/film/data/models/film_model.dart'
    as _i2;
import 'package:hdrezka_client/features/film/data/models/film_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeFilmModel_0 extends _i1.Fake implements _i2.FilmModel {}

/// A class which mocks [FilmLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSource extends _i1.Mock implements _i3.FilmLocalDataSource {
  MockLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.FilmModel> getCachedFilm() =>
      (super.noSuchMethod(Invocation.method(#getCachedFilm, []),
              returnValue: Future<_i2.FilmModel>.value(_FakeFilmModel_0()))
          as _i4.Future<_i2.FilmModel>);
  @override
  _i4.Future<void> cacheFilm(_i2.FilmModel? film) =>
      (super.noSuchMethod(Invocation.method(#cacheFilm, [film]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [FilmRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteDataSource extends _i1.Mock
    implements _i5.FilmRemoteDataSource {
  @override
  _i4.Future<_i2.FilmModel> getFilm(int? search_request_id, String? url, String? type) =>
      (super.noSuchMethod(Invocation.method(#getFilm, [url]),
          returnValueForMissingStub: Future (() => FilmModel(
              search_request_id: 0,
              url: 'https://rezka.ag/films/fantasy/41834-snova-privet-1987.html',
              type: 'films',
              payload: const [
                LinkVideo(
                    resolution: '360p',
                    url:
                    'https://stream.voidboost.cc/3/7/6/9/8/8/ebbad219ee853a9ef1e68cdf9df87381:2021100517:2e179457-952a-4834-a712-0fcaa5358126/bie1b.mp4')
              ],
              status: 'string')),
          returnValue: Future<_i2.FilmModel>.value(_FakeFilmModel_0()))
          as _i4.Future<_i2.FilmModel>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetWorkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetWorkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  String toString() => super.toString();
}
