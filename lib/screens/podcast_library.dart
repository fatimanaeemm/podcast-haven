import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:podcast_player/models/podcast.dart';
import 'package:podcast_player/widgets/podcast_list.dart';

import '../widgets/bottom_player_bar.dart';

class PodcastLibrary extends StatelessWidget {
  static const routeName = '/podcast-library';
  const PodcastLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomPlayerBar(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff0ecec),
        title: Text(
          'Podcasts',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.2,
              color: Color(0xff141f5a),
            ),
          ),
        ),
        leading: const BackButton(
          color: Color(0xb2141f5a),
        ),
        centerTitle: true,
      ),
      body: PodcastList(false, CategoryEnum.all),
    );
  }
}
