import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:podcast_player/widgets/podcast_list.dart';
import '../models/podcast.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category-screen';
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryEnum category =
    ModalRoute.of(context)!.settings.arguments as CategoryEnum;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff0ecec),
        title: Text(
          category.name,
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
      body: PodcastList(false, category),
    );
  }
}
