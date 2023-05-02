import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast_player/models/audio_manager.dart';
import '../consts/app_images.dart';
import 'podcast.dart';

class Podcasts with ChangeNotifier {
  static List<Podcast> _podcasts = [
    Podcast(
      id: '0',
      title: 'slayyy',
      coverPicture: AppImages.podcastImages[0],
      audioLink:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      isLocal: false,
      author: 'Momin',
      category: CategoryEnum.entertainment,
    ),
    Podcast(
      id: '1',
      title: 'Do Podcast like pro',
      coverPicture: AppImages.podcastImages[1],
      audioLink:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      isLocal: true,
      author: 'John',
      category: CategoryEnum.politics,
    ),
    Podcast(
      id: '2',
      title: 'Do Podcast',
      coverPicture: AppImages.podcastImages[0],
      audioLink:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      isLocal: true,
      author: 'Johny',
      category: CategoryEnum.sports,
    ),
    Podcast(
      id: '3',
      title: 'Don\'t Podcast',
      coverPicture: AppImages.podcastImages[1],
      audioLink:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      isLocal: true,
      author: 'Sara',
      category: CategoryEnum.technology,
    ),
    Podcast(
      id: '4',
      title: 'like pro',
      coverPicture: AppImages.podcastImages[0],
      audioLink:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      isLocal: true,
      author: 'BB',
      category: CategoryEnum.entertainment,
    )
  ];

  Podcast findById(String id) {
    return _podcasts.firstWhere((podcast) => podcast.id == id);
  }

  static int get length => _podcasts.length;

  ConcatenatingAudioSource get allPodcasts {
    AudioPlayerModel.currentPlaying = allPodcasts;
    return ConcatenatingAudioSource(children: [
      for (var p in _podcasts)
        AudioSource.uri(Uri.parse(p.audioLink),
            tag: MediaItem(
                id: p.id,
                title: p.title,
                artUri: Uri.parse(p.coverPicture),
                artist: p.author))
    ]);
  }

  ConcatenatingAudioSource get entertainment {
    AudioPlayerModel.currentPlaying = entertainment;
    return ConcatenatingAudioSource(children: [
      for (var p
          in _podcasts.where((p) => p.category == CategoryEnum.entertainment))
        AudioSource.uri(Uri.parse(p.audioLink),
            tag: MediaItem(
                id: p.id,
                title: p.title,
                artUri: Uri.parse(p.coverPicture),
                artist: p.author))
    ]);
  }

  ConcatenatingAudioSource get technology {
    AudioPlayerModel.currentPlaying = technology;
    return ConcatenatingAudioSource(children: [
      for (var p
          in _podcasts.where((p) => p.category == CategoryEnum.technology))
        AudioSource.uri(Uri.parse(p.audioLink),
            tag: MediaItem(
                id: p.id,
                title: p.title,
                artUri: Uri.parse(p.coverPicture),
                artist: p.author))
    ]);
  }

  ConcatenatingAudioSource get sports {
    AudioPlayerModel.currentPlaying = sports;
    return ConcatenatingAudioSource(children: [
      for (var p in _podcasts.where((p) => p.category == CategoryEnum.sports))
        AudioSource.uri(Uri.parse(p.audioLink),
            tag: MediaItem(
                id: p.id,
                title: p.title,
                artUri: Uri.parse(p.coverPicture),
                artist: p.author))
    ]);
  }

  ConcatenatingAudioSource get politics {
    AudioPlayerModel.currentPlaying = politics;
    return ConcatenatingAudioSource(children: [
      for (var p in _podcasts.where((p) => p.category == CategoryEnum.politics))
        AudioSource.uri(Uri.parse(p.audioLink),
            tag: MediaItem(
                id: p.id,
                title: p.title,
                artUri: Uri.parse(p.coverPicture),
                artist: p.author))
    ]);
  }

  ConcatenatingAudioSource byCategory(CategoryEnum category) {
    return ConcatenatingAudioSource(children: [
      for (var p in _podcasts.where((p) => p.category == category))
        AudioSource.uri(Uri.parse(p.audioLink),
            tag: MediaItem(
                id: p.id,
                title: p.title,
                artUri: Uri.parse(p.coverPicture),
                artist: p.author))
    ]);
  }

  ConcatenatingAudioSource get favoriteItems {
    return ConcatenatingAudioSource(children: [
      for (var p in _podcasts.where((p) => p.isFavorite))
        AudioSource.uri(Uri.parse(p.audioLink),
            tag: MediaItem(
                id: p.id,
                title: p.title,
                artUri: Uri.parse(p.coverPicture),
                artist: p.author))
    ]);
  }

  void toggleFavoriteStatus(String currId) {
    var pod = _podcasts.firstWhere((element) => element.id == currId);
    pod.isFavorite = !(pod.isFavorite);
    notifyListeners();
  }
}
