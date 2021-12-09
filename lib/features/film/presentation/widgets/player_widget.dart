import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdrezka_client/features/film/domain/entities/link_video.dart';
import 'package:video_player/video_player.dart';

class PlayerWidget extends StatefulWidget{
  final String videoLink;
  const PlayerWidget({Key? key, required this.videoLink}) : super(key: key);

  @override
  _StatePlayerWidget createState() => _StatePlayerWidget();
}

class _StatePlayerWidget extends State<PlayerWidget>{
  VideoPlayerController? _playerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    _playerController = VideoPlayerController.network(widget.videoLink);
    _chewieController = ChewieController(
        videoPlayerController: _playerController!,
        autoInitialize: true,
        additionalOptions: (context) => <OptionItem>[
          OptionItem(
              onTap: () {},
              iconData: Icons.ac_unit,
              title: 'Quality ')
        ]
    );

    super.initState();
  }

  @override
  void dispose(){
    _playerController!.dispose();
    _chewieController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Chewie(
        controller: _chewieController!,
    );
  }
}