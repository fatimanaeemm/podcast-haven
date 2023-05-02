import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast_player/models/audio_manager.dart';
import 'package:podcast_player/models/podcast.dart';
import 'package:podcast_player/screens/podcast_details.dart';
import 'package:provider/provider.dart';
import '../models/podcasts.dart';

class PodcastList extends StatelessWidget {
  final bool showFavs;
  CategoryEnum category;
  int? limit;

  PodcastList(this.showFavs, this.category, [this.limit]);

  @override
  Widget build(BuildContext context) {
    final getter = Provider.of<Podcasts>(context);
    var podcastData;
    if (showFavs) {
      podcastData = getter.favoriteItems;
    } else if (category != CategoryEnum.all) {
      podcastData = getter.byCategory(category);
    } else {
      podcastData = getter.allPodcasts;
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: this.limit ?? podcastData.length,
      itemBuilder: (BuildContext context, int index) {
        MediaItem metadata = podcastData.sequence[index].tag as MediaItem;
        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(PodcastDetails.routeName,
              arguments: {
                'index': index,
                'showsFavs': showFavs,
                'category': category
              }),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(metadata.artUri.toString()),
            ),
            title: Text(metadata.title),
            subtitle: Text(metadata.artist!),
            trailing: IconButton(
              //iconSize: 5,
              icon: Icon(getter.findById(metadata.id).isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                getter.toggleFavoriteStatus(metadata.id);
              },
            ),
          ),
        );
      },
    );
  }
}
