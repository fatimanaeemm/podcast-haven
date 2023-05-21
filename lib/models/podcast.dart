import 'package:flutter/material.dart';
import '../consts/app_images.dart';

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
      required this.isFavorite});

  static CategoryEnum mapStringToCategoryEnum(String value) {
    switch (value) {
      case 'technology':
        return CategoryEnum.technology;
      case 'sports':
        return CategoryEnum.sports;
      case 'entertainment':
        return CategoryEnum.entertainment;
      case 'politics':
        return CategoryEnum.politics;
      case 'all':
        return CategoryEnum.all;
      default:
        return CategoryEnum.all;
    }
  }

  static Podcast fromMap(Map<String, dynamic> map) {
    return Podcast(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      coverPicture: map['coverPicture'] ?? AppImages.podcastImages[0],
      audioLink: map['audioLink'] ?? '',
      isLocal: map['isLocal'] ?? false,
      author: map['author'] ?? '',
      category: mapStringToCategoryEnum(map['category']),
      isFavorite: map['isFavourite'] ?? false,
    );
  }
}
