// import 'package:flutter/material.dart';
// import 'package:just_audio_background/just_audio_background.dart';
// import 'package:podcast_player/models/audio_manager.dart';
// import 'package:provider/provider.dart';

// class BottomPlayerBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     MediaItem current = AudioPlayerModel.currentPlaying
//         .sequence[AudioPlayerModel.currentIndex].tag as MediaItem;
//     return PreferredSize(
//       preferredSize: Size.fromHeight(60.0),
//       child:BottomAppBar(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     current.title ?? '',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     current.artist ?? '',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 //Navigator.pushNamed(context, '/music_player');
//               },
//               icon: Icon(Icons.arrow_upward),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
