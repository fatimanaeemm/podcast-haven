import 'dart:typed_data';
import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

import '../models/podcasts.dart';

class PodcastDetailsCopy extends StatefulWidget {
  static const routeName = '/podcast';
  const PodcastDetailsCopy({super.key});

  @override
  State<PodcastDetailsCopy> createState() => _PodcastDetailsCopyState();
}

class _PodcastDetailsCopyState extends State<PodcastDetailsCopy> {
  double fem = 0.9;
  double ffem = 0.9;
  bool _isPlaying = false;
  bool _audioPlayed = false;
  late AudioPlayer _player;
  late Stream<DurationState> _durationState;
  late var _podcastId = ModalRoute.of(context)!.settings.arguments as String;
  late var _loadedPodcast =
      Provider.of<Podcasts>(context, listen: false).findById(_podcastId);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _player = AudioPlayer();
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    _init();
  }

  Future<void> _init() async {
    try {
      await _player.setUrl(_loadedPodcast.audioLink);
    } catch (e) {
      debugPrint('An error occured $e');
    }
  }

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 70),
            // playscreenNzF (8:326)
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 1),
                          colors: <Color>[Color(0x7fff002d), Color(0x7fac2bc1)],
                          stops: <double>[0, 1],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // group25xqy (8:338)
                            width: double.infinity,
                            child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    // podcastdetail99m (8:339)
                                    _loadedPodcast.title,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        //font: 'Lato',
                                        fontSize: 25 * ffem,
                                        fontWeight: FontWeight.w500,
                                        //height: 1.2 * ffem / fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ClipRect(
                            // rectangle16S8s (8:344)
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 30, left: 15, right: 15, bottom: 10),
                              width: double.infinity,
                              height: 330 * fem,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16 * fem),
                                color: Color(0xffd9d9d9),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(_loadedPodcast.coverPicture),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Container(
                      // withamnapirzadaempathyandfrien (8:345)
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 14 * fem),
                      constraints: BoxConstraints(
                        maxWidth: 300 * fem,
                      ),
                      child: Text(_loadedPodcast.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              // font: 'Lato',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w800,
                              height: 1.2 * ffem / fem,
                              color: Color(0xff141f5a),
                            ),
                          )),
                    ),
                  ),
                  Container(
                    // happychirp5LF (8:346)
                    margin: EdgeInsets.fromLTRB(
                        1 * fem, 0 * fem, 0 * fem, 40 * fem),
                    child: Text(_loadedPodcast.author,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            //'Lato',
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.2 * ffem / fem,
                            color: Color(0xb2141f5a),
                          ),
                        )),
                  ),
                  Container(
                      constraints:
                          BoxConstraints(maxWidth: 380 * fem, maxHeight: 150),
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 2 * fem),
                      child: _progressBar()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            var arg = (int.parse(_podcastId) - 1);
                            if (arg > 0) {
                              _player.stop();
                              Navigator.of(context).pushReplacementNamed(
                                  '/podcast',
                                  arguments: arg.toString());
                            }
                          },
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            color: Color(0xff141f5a),
                            size: 40,
                          )),
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.fast_rewind_rounded,
                      //       color: Color(0xff141f5a),
                      //       size: 40,
                      //     )),
                      // IconButton(
                      //     onPressed: () {
                      //       // if (!_isPlaying && !_audioPlayed) {
                      //       //   play();
                      //       //   setState(() {
                      //       //     _isPlaying = true;
                      //       //     _audioPlayed = true;
                      //       //   });
                      //       // } else if (_audioPlayed && !_isPlaying) {
                      //       //   resume();
                      //       //   setState(() {
                      //       //     _isPlaying = true;
                      //       //     _audioPlayed = true;
                      //       //   });
                      //       // } else {
                      //       //   pause();
                      //       //   setState(() {
                      //       //     _isPlaying = false;
                      //       //   });
                      //       // }
                      //       if (_isPlaying)
                      //         pause();
                      //       else
                      //         play();
                      //       setState(() {
                      //         _isPlaying = !_isPlaying;
                      //       });
                      //     },
                      //     icon: Icon(
                      //       _isPlaying ? Icons.pause : Icons.play_arrow,
                      //       color: Color(0xff141f5a),
                      //       size: 40,
                      //     )),
                      _playButton(),
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.fast_forward_rounded,
                      //       color: Color(0xff141f5a),
                      //       size: 40,
                      //     )),
                      IconButton(
                          onPressed: () {
                            var arg = (int.parse(_podcastId) + 1);
                            if (arg <= Podcasts.length) {
                              _player.stop();
                              Navigator.of(context).pushReplacementNamed(
                                  '/podcast',
                                  arguments: arg.toString());
                            }
                          },
                          icon: Icon(
                            Icons.skip_next_rounded,
                            color: Color(0xff141f5a),
                            size: 40,
                          )),
                    ],
                  )
                ])));
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: (duration) {
            _player.seek(duration);
          },
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
          barHeight: 5,
          thumbRadius: 8,
          progressBarColor: Colors.pinkAccent,
          baseBarColor: Colors.grey[400],
          thumbColor: Color(0xff141f5a),
          timeLabelTextStyle: GoogleFonts.lato(
              textStyle: TextStyle(color: Colors.grey, fontSize: 14)),
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            color: Color(0xff141f5a),
            iconSize: 40,
            onPressed: _player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause),
            color: Color(0xff141f5a),
            iconSize: 40,
            onPressed: _player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay),
            color: Color(0xff141f5a),
            iconSize: 40,
            onPressed: () => _player.seek(Duration.zero),
          );
        }
      },
    );
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
