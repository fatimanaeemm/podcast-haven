import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:podcast_player/screens/category_screen.dart';
import 'package:podcast_player/screens/favorites_screen.dart';
import 'package:podcast_player/screens/podcast_library.dart';
import 'package:podcast_player/widgets/bottom_player_bar.dart';
import '../models/podcast.dart';
import '../widgets/podcast_list.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/music-library';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // var categories = List<String>.filled(20, 'category');
    ScrollController _scrollController = ScrollController();
    int count = 0;
    var categories = CategoryEnum.values;

    var ffem = 0.8;
    var fem = 0.8;
    //   'Self Development': 'assets/images/image.JPG',
    //   'Motivation': 'assets/images/image.JPG',
    //   'Books': 'assets/images/image.JPG',
    //   'Category' : 'assets/images/image.JPG',
    //   'Category' : 'assets/images/image.JPG',
    // };
    void _scrollToNextItem() {
      double currentOffset = _scrollController.offset;
      _scrollController.animateTo(
        currentOffset + MediaQuery.of(context).size.width - 49 * fem,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(49 * fem, 49 * fem, 49 * fem, 0 * fem),
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 49 * fem,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      // width: MediaQuery.of(context).size.width - 100,
                      // height: 55 * fem,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8 * fem),
                                child: Image.asset("assets/girl.png",
                                    fit: BoxFit.cover)),
                          ),
                          Expanded(
                            flex: 4,
                            //height: 60 * fem,
                            // width: double.infinity,
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome Back! ',
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      fontSize: 18 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2 * ffem / fem,
                                      color: Color(0xb2141f5a),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Daniyah Imran',
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      fontSize: 18 * ffem,
                                      fontWeight: FontWeight.w700,
                                      //height: 1.2 * ffem / fem,
                                      color: Color(0xff141f5a),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            size: 30 * fem,
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(FavoritesScreen.routeName),
                        )),
                  ],
                ),
              ),
            ),
            // Container(
            //   padding:
            //       EdgeInsets.fromLTRB(10 * fem, 16 * fem, 0 * fem, 18 * fem),
            //   width: double.infinity,
            //   height: 55 * fem,
            //   decoration: BoxDecoration(
            //     color: Color(0x19141f5a),
            //     borderRadius: BorderRadius.circular(16 * fem),
            //   ),
            //   child: Row(
            //     //crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Container(
            //         margin: EdgeInsets.fromLTRB(
            //             0 * fem, 0 * fem, 69 * fem, 0 * fem),
            //         height: double.infinity,
            //         child: Row(
            //           //mainAxisAlignment: MainAxisAlignment.start,
            //           //crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Expanded(
            //               // margin: EdgeInsets.fromLTRB(
            //               //     10 * fem, 0 * fem, 16 * fem, 0 * fem),
            //               // width: 18 * fem,
            //               // height: 18 * fem,
            //               child: Icon(Icons.search, size: 16 * ffem),
            //             ),
            //             Text('What would you like to listen to today?',
            //                 style: GoogleFonts.lato(
            //                   textStyle: TextStyle(
            //                     fontSize: 16 * ffem,
            //                     fontWeight: FontWeight.w400,
            //                     height: 1.2 * ffem / fem,
            //                     color: Color(0xff141f5a),
            //                   ),
            //                 )),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              flex: 2,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        // margin: EdgeInsets.fromLTRB(
                        //     0 * fem, 0 * fem, 161 * fem, 0 * fem),
                        child: Text(
                          'Popular Categories',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2 * ffem / fem,
                              color: Color(0xff141f5a),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _scrollToNextItem,
                        icon: Icon(
                          Icons.forward,
                        ),
                        iconSize: 22 * fem,
                      )
                    ],
                  ),
                ),
                Expanded(
                    flex: 3,
                    //height: 100, // Set the desired height of the list view
                    child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis
                            .horizontal, // Set the scroll direction to horizontal
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                  CategoryScreen.routeName,
                                  arguments: categories[index]),
                              child: Card(
                                  child: Container(
                                      width:
                                          150, // Set the desired width of each list item
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8 * fem),
                                              child: Image.asset(
                                                  "assets/girl.png",
                                                  fit: BoxFit.cover)),
                                          Text(
                                              categories[index].name.toString())
                                        ],
                                      ))));
                        })),
              ]),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        // margin: EdgeInsets.fromLTRB(
                        //     0 * fem, 0 * fem, 161 * fem, 0 * fem),
                        child: Text(
                          'Browse',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2 * ffem / fem,
                              color: Color(0xff141f5a),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(PodcastLibrary.routeName);
                        },
                        icon: Icon(
                          Icons.forward,
                        ),
                        iconSize: 22 * fem,
                      )
                    ],
                  ),
                  Expanded(
                    flex: 4,
                    //height: 100, // Set the desired height of the list view
                    child: PodcastList(false, CategoryEnum.all),
                  ),
                ]),
              ),
            ),

            //Expanded(flex: 1, child: BottomPlayerBar())
          ],
        ),
      ),
      bottomNavigationBar: BottomPlayerBar(),
    );
  }
}
