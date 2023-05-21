//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firedart.dart';
import '../models/podcast.dart';
//import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  //final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference podcastsCollection =
      Firestore.instance.collection('podcasts');

  Future updatePodcast(Podcast podcast) async {
    return await podcastsCollection.document(podcast.id).set({
      'id': podcast.id,
      'title': podcast.title,
      'coverPicture': podcast.coverPicture,
      'audioLink': podcast.audioLink,
      'isLocal': podcast.isLocal,
      'author': podcast.author,
      'category': podcast.category.toString().split('.').last,
      'isFavorite': podcast.isFavorite,
    });
  }

  Future updateFavorite(Podcast podcast) async {
    return await podcastsCollection.document(podcast.id).set({
      'id': podcast.id,
      'title': podcast.title,
      'coverPicture': podcast.coverPicture,
      'audioLink': podcast.audioLink,
      'isLocal': podcast.isLocal,
      'author': podcast.author,
      'category': podcast.category.toString().split('.').last,
      'isFavorite': podcast.isFavorite,
    });
  }
}
