import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast_player/models/audio_manager.dart';
import 'package:provider/provider.dart';

import '../models/podcast.dart';
import '../models/podcasts.dart';
import '../screens/podcast_details.dart';

class BottomPlayerBar extends StatefulWidget {
  @override
  State<BottomPlayerBar> createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar> {
  late var _loadedPodcast;
  late var _player;
  late var _currIndex;
  late ConcatenatingAudioSource playlist;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _player = Provider.of<AudioPlayerModel>(context);
    _currIndex = _player.getCurrIndex == -1 ? 0 : _player.getCurrIndex;
    if (_player.isShowingFavs) {
      playlist = Provider.of<Podcasts>(context).favoriteItems;
    } else if (AudioPlayerModel.currentCategory == CategoryEnum.all) {
      playlist = Provider.of<Podcasts>(context).allPodcasts;
    } else if (AudioPlayerModel.currentCategory == CategoryEnum.sports) {
      playlist = Provider.of<Podcasts>(context).sports;
    } else if (AudioPlayerModel.currentCategory == CategoryEnum.entertainment) {
      playlist = Provider.of<Podcasts>(context).entertainment;
    } else if (AudioPlayerModel.currentCategory == CategoryEnum.technology) {
      playlist = Provider.of<Podcasts>(context).technology;
    } else if (AudioPlayerModel.currentCategory == CategoryEnum.politics) {
      playlist = Provider.of<Podcasts>(context).politics;
    }

    _loadedPodcast = playlist.sequence[_currIndex].tag as MediaItem;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PodcastDetails.routeName, arguments: {
          'index': _currIndex,
          'showsFavs': _player.isShowingFavs,
          'category': AudioPlayerModel.currentCategory
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey[300]),
        // color: Colors.grey[300],
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _loadedPodcast.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _loadedPodcast.artist ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            _playButton(),
          ],
        ),
      ),
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
