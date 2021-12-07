import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hdrezka_client/features/film/data/models/link_video_model.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';

import '../../../../fixtures/fixture.dart';

void main () {
  const linkVideoModel = LinkVideoModel(
      url: 'https://stream.voidboost.cc/3/7/6/9/8/8/ebbad219ee853a9ef1e68cdf9df87381:2021100517:2e179457-952a-4834-a712-0fcaa5358126/bie1b.mp4',
      resolution: '360p'
  );

  test('should be a subclass of Film information entity', (){
    expect(linkVideoModel, isA<LinkVideo>());
  });

  group('from json',() {
    test('should return a valid model when the JSON film information',
            () async {
          final Map<String, dynamic> jsonMap =
          json.decode(fixture('link_video.json', const Utf8Codec()));
          final result = LinkVideoModel.fromJson(jsonMap);

          expect(result, linkVideoModel);

        });
  });
}