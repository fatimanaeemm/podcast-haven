import 'package:flutter/material.dart';
import 'package:podcast_player/screens/favorites_screen.dart';
import 'models/audio_manager.dart';
import 'models/podcasts.dart';
import 'screens/category_screen.dart';
import 'screens/podcast_details.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/podcast_library.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static const routeName = '/';
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //int _selectedIndex = 0;

  // final List<Widget> _widgetOptions = [
  //   HomeScreen(),
  //   PodcastDetails(),
  //   FavoritesScreen()
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   if (_selectedIndex == 0) {
  //     Navigator.of(context).pushNamed(HomeScreen.routeName);
  //   } else if (_selectedIndex == 1 && AudioPlayerModel.currentIndex != 0) {
  //     Navigator.of(context).pushNamed(PodcastDetails.routeName,
  //         arguments: AudioPlayerModel.currentIndex.toString());
  //   } else if (_selectedIndex == 1 && AudioPlayerModel.currentIndex == 0) {
  //     Navigator.of(context).pushNamed(PodcastDetails.routeName, arguments: '1');
  //   }
  //   else {
  //     Navigator.of(context).pushNamed(FavoritesScreen.routeName);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AudioPlayerModel()),
        ChangeNotifierProvider(
          create: (ctx) => Podcasts(),
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen(),
          routes: {
            PodcastDetails.routeName: (ctx) => PodcastDetails(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            PodcastLibrary.routeName: (ctx) => PodcastLibrary(),
            FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
            CategoryScreen.routeName: (ctx) => CategoryScreen()
          }),
    );
  }
}
