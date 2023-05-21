import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast_player/models/audio_manager.dart';
import '../consts/app_images.dart';
import 'podcast.dart';
import 'package:firedart/firedart.dart';
import '../services/database.dart';

DatabaseService db = DatabaseService();

class Podcasts with ChangeNotifier {
  static List<Podcast> _podcasts = [
    Podcast(
      id: '0',
      title: 'Be better',
      coverPicture: AppImages.podcastImages[0],
      audioLink:
          'http://audio.spokenlayer.com/v1-sfchronicle-business/2017/12/2f555611-383f-4530-ac0c-52a41c4dfb29/audio-2f555611-383f-4530-ac0c-52a41c4dfb29-encodings.mp3?date-voiced=2017-12-20T07%3A39%3A33-05%3A00&article-id=2f555611-383f-4530-ac0c-52a41c4dfb29&article-',
      isLocal: false,
      author: 'Momin',
      category: CategoryEnum.entertainment,
      isFavorite: true,
    ),
    // Podcast(
    //   id: '1',
    //   title: 'Do Podcast like pro',
    //   coverPicture: AppImages.podcastImages[1],
    //   audioLink:
    //       'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
    //   isLocal: true,
    //   author: 'John',
    //   category: CategoryEnum.politics,
    // ),
    // Podcast(
    //   id: '2',
    //   title: 'Do Podcast',
    //   coverPicture: AppImages.podcastImages[0],
    //   audioLink:
    //       'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
    //   isLocal: true,
    //   author: 'Johny',
    //   category: CategoryEnum.sports,
    // ),
    // Podcast(
    //   id: '3',
    //   title: 'Don\'t Podcast',
    //   coverPicture: AppImages.podcastImages[1],
    //   audioLink:
    //       'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
    //   isLocal: true,
    //   author: 'Sara',
    //   category: CategoryEnum.technology,
    // ),
    // Podcast(
    //   id: '4',
    //   title: 'like pro',
    //   coverPicture: AppImages.podcastImages[0],
    //   audioLink:
    //       'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
    //   isLocal: true,
    //   author: 'BB',
    //   category: CategoryEnum.entertainment,
    // )
  ];

  /* var lines = File('assets/podcastdata.csv').readAsLinesSync();
  int count = 1;
  Random rnd = Random();
  var r = 0;
  Podcasts() {
    lines.removeAt(0);
    for (var line in lines) {
      final values = line.split(',');
      r = rnd.nextInt(4);
      var pod = Podcast(
        id: count.toString(),
        title: values[0],
        coverPicture: values[1],
        author: values[2],
        audioLink: values[3],
        category: CategoryEnum.values[r],
        isLocal: false,
        isFavorite: false,
      );
      _podcasts.add(pod);
      db.updatePodcast(pod);
      count++;
    }
  }*/

  Podcasts() {
    getPodcast();
  }

  getPodcast() async {
    List<Document> snapshot = await db.podcastsCollection.get();
    snapshot.toList().forEach((element) {
      addPodcast(Podcast.fromMap(element.map));
    });
  }

  void addPodcast(Podcast product) {
    final newProduct = Podcast(
      id: product.id,
      title: product.title,
      audioLink: product.audioLink,
      coverPicture: product.coverPicture,
      author: product.author,
      isLocal: product.isLocal,
      isFavorite: product.isFavorite,
      category: product.category,
    );
    _podcasts.add(newProduct);
    notifyListeners();
  }

  Podcast findById(String id) {
    return _podcasts.firstWhere((podcast) => podcast.id == id);
  }

  static int get length => _podcasts.length;

  ConcatenatingAudioSource get allPodcasts {
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
    db.updateFavorite(pod);
    notifyListeners();
  }
}
