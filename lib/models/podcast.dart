import 'package:flutter/material.dart';

enum CategoryEnum { technology, sports, entertainment, politics, all }

class Podcast with ChangeNotifier {
  String id;
  String title;
  String coverPicture;
  String audioLink;
  bool isLocal;
  String author;
  bool isFavorite;
  CategoryEnum category;
  Podcast(
      {required this.id,
      required this.title,
      required this.coverPicture,
      required this.audioLink,
      required this.isLocal,
      required this.author,
      required this.category,
      this.isFavorite = false});
}
