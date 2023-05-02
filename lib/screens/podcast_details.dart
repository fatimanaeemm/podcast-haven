import 'dart:typed_data';
import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast_player/models/audio_manager.dart';
import 'package:podcast_player/models/podcast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

import '../models/podcasts.dart';

class PodcastDetails extends StatefulWidget {
  static const routeName = '/podcast';
  const PodcastDetails({super.key});

  @override
  State<PodcastDetails> createState() => _PodcastDetailsState();
}

class _PodcastDetailsState extends State<PodcastDetails> {
  double fem = 0.9;
  double ffem = 0.9;
  bool _isPlaying = false;
  bool _audioPlayed = false;
  late Stream<DurationState> _durationState;
  late var _loadedPodcast;
  late var _player;
  late var _currIndex;
  late var _showingFavs;
  late ConcatenatingAudioSource playlist;
  late CategoryEnum _category;
  @override
  void initState() {
    super.initState();
    AudioPlayerModel.isPlaying = true;
    _player = Provider.of<AudioPlayerModel>(context, listen: false);
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.audioPlayer.positionStream,
        _player.audioPlayer.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var settings =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _category = settings['category'] as CategoryEnum;
    _currIndex = settings['index'];
    _showingFavs = settings['showsFavs'];
    if (_showingFavs) {
      playlist = Provider.of<Podcasts>(context).favoriteItems;
    } else if (_category == CategoryEnum.all) {
      playlist = Provider.of<Podcasts>(context).allPodcasts;
    } else if (_category == CategoryEnum.sports) {
      playlist = Provider.of<Podcasts>(context).sports;
    } else if (_category == CategoryEnum.entertainment) {
      playlist = Provider.of<Podcasts>(context).entertainment;
    } else if (_category == CategoryEnum.technology) {
      playlist = Provider.of<Podcasts>(context).technology;
    } else if (_category == CategoryEnum.politics) {
      playlist = Provider.of<Podcasts>(context).politics;
    }
    // final settings = ModalRoute.of(context)!.settings;
    //   if (settings.arguments == null) {
    //     if (AudioPlayerModel.currentIndex == 0) {
    //       _podcastIndex = '1';
    //     } else {
    //       _podcastIndex = AudioPlayerModel.currentIndex.toString();
    //     }
    //   } else {
    //     _podcastIndex = settings.arguments as String;
    //   }

    _loadedPodcast = playlist.sequence[_currIndex].tag as MediaItem;

    // Provider.of<Podcasts>(context, listen: false)
    //     .findById(_podcastIndex.toString());
    //print(_loadedPodcast.name);
    if (_currIndex != AudioPlayerModel.currentIndex ||
        _category != AudioPlayerModel.currentCategory ||
        (_showingFavs && _currIndex != AudioPlayerModel.currentIndex)) {
      _init();
    }
  }

  Future<void> _init() async {
    try {
      _player.setUrl(_category, playlist, _currIndex);
      _player.play();
    } catch (e) {
      debugPrint('An error occured $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     // Release the player's resources when not in use. We use "stop" so that
  //     // if the app resumes later, it will still remember what position to
  //     // resume from.
  //     // _player.audioPlayer.stop();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 40),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
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
                            width: double.infinity,
                            child: Row(
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
                                    _loadedPodcast.title,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        fontSize: 25 * ffem,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ClipRect(
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
                                    image: NetworkImage(
                                        _loadedPodcast.artUri.toString())),
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
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 14 * fem),
                      constraints: BoxConstraints(
                        maxWidth: 300 * fem,
                      ),
                      child: Text(_loadedPodcast.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w800,
                              height: 1.2 * ffem / fem,
                              color: Color(0xff141f5a),
                            ),
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        1 * fem, 0 * fem, 0 * fem, 40 * fem),
                    child: Text(_loadedPodcast.artist,
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
                            // setState(() {
                            //   AudioPlayerModel.currentIndex -= 1;
                            // });
                            if (_currIndex > 0) {
                              _player.audioPlayer.stop();
                              Navigator.of(context)
                                  .pushReplacementNamed('/podcast', arguments: {
                                'index': _currIndex - 1,
                                'showsFavs': _showingFavs,
                                'category': _category
                              });
                            }
                          },
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            color: Color(0xff141f5a),
                            size: 40,
                          )),
                      _playButton(),
                      IconButton(
                          onPressed: () {
                            //var nextIndex = playlist.nextIndexAfter(_podcastIndex);
                            // setState(() {
                            //   AudioPlayerModel.currentIndex += 1;
                            // });
                            // var arg = (int.parse(_podcastIndex) + 1);
                            if (_currIndex < playlist.length - 1) {
                              _player.audioPlayer.stop();
                              Navigator.of(context)
                                  .pushReplacementNamed('/podcast', arguments: {
                                'index': _currIndex + 1,
                                'showsFavs': _showingFavs,
                                'category': _category
                              });
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
            _player.seekDuration(duration);
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
      stream: _player.audioPlayer.playerStateStream,
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
            onPressed: () => _player.seekDuration(Duration.zero),
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
