import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast_player/models/podcast.dart';

class AudioPlayerModel with ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();
  static int currentIndex = -1;
  static CategoryEnum currentCategory = CategoryEnum.all;
  static bool isPlaying = false;
  static bool showingFavs = false;

  Future<void> setUrl(
      CategoryEnum category, AudioSource currPlaylist, int newIndex) async {
    await audioPlayer.stop();
    currentIndex = newIndex;
    currentCategory = category;
    await audioPlayer.setAudioSource(
      currPlaylist,
      initialIndex: currentIndex,
      initialPosition: Duration.zero,
      preload: true,
    );
    notifyListeners();
  }

  Future<void> seekDuration(duration) => audioPlayer.seek(duration);

  Future<void> play() => audioPlayer.play();

  Future<void> resume() => audioPlayer.play();

  Future<void> pause() => audioPlayer.pause();

  Future<void> playNextPodcast(AudioSource currPlaylist) async {
    final sequence = currPlaylist.sequence;
    final nextMetadata = sequence.skip(currentIndex + 1).first;
    await audioPlayer.setAudioSource(
      currPlaylist,
      initialIndex: nextMetadata.tag[currentIndex].id,
      initialPosition: Duration.zero,
      preload: true,
    );
  }

  void changeFavStatus(bool status) {
    showingFavs =  status;
  }

  int get getCurrIndex => currentIndex;

  bool get isShowingFavs => showingFavs;
}
