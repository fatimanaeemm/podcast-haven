import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast_player/models/audio_manager.dart';
import 'package:podcast_player/models/podcast.dart';
import 'package:podcast_player/screens/podcast_details.dart';
import 'package:provider/provider.dart';
import '../models/podcasts.dart';

class PodcastList extends StatefulWidget {
  final bool showFavs;
  CategoryEnum category;
  int? limit;

  PodcastList(this.showFavs, this.category, [this.limit]);

  @override
  State<PodcastList> createState() => _PodcastListState();
}

class _PodcastListState extends State<PodcastList> {
  late var podcastData;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final getter = Provider.of<Podcasts>(context);
    if (widget.showFavs) {
      podcastData = getter.favoriteItems;
    } else if (widget.category != CategoryEnum.all) {
      podcastData = getter.byCategory(widget.category);
    } else {
      podcastData = getter.allPodcasts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //scrollDirection: Axis.horizontal,
      itemCount: podcastData.length,
      itemBuilder: (BuildContext context, int index) {
        MediaItem metadata = podcastData.sequence[index].tag as MediaItem;
        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(PodcastDetails.routeName,
              arguments: {
                'index': index,
                'showsFavs': widget.showFavs,
                'category': widget.category
              }),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(metadata.artUri.toString()),
            ),
            title: Text(metadata.title),
            subtitle: Text(metadata.artist!),
            trailing: IconButton(
              //iconSize: 5,
              icon: Icon(Provider.of<Podcasts>(context, listen: false)
                      .findById(metadata.id)
                      .isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                Provider.of<Podcasts>(context, listen: false)
                    .toggleFavoriteStatus(metadata.id);
              },
            ),
          ),
        );
      },
    );
  }
}
