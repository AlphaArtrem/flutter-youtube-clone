import 'dart:ui';

import 'package:flutter/material.dart';

class ExploreTab extends StatefulWidget {
  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  Map<String, Widget> _categories = {
    'Trending' : Icon(Icons.trending_up, color: Colors.white,),
    'Music' : Icon(Icons.library_music, color: Colors.white),
    'Gaming': Icon(Icons.gamepad, color: Colors.white),
    'News': Icon(Icons.new_releases, color: Colors.white),
    'Films': Icon(Icons.movie, color: Colors.white),
    'Fashion': Icon(Icons.store, color: Colors.white),
    'Learning': Icon(Icons.library_books, color: Colors.white),
    'Live': Icon(Icons.live_tv, color: Colors.white),
  };

  List<Map> _videos = [
    {
      'url': 'https://www.youtube.com/watch?v=Jakrc3Tn_y4',
      'thumbnail': 'assets/img/layout_explorer.jpg',
      'title': 'Layout Explorer',
      'date': '16 hours ago',
      'views': '100k views',
      'creator': 'Flutter',
      'profile': 'assets/img/flutter.jpg',
    },
    {
      'url': 'https://www.youtube.com/watch?v=exgoaU3Fr5E',
      'thumbnail': 'assets/img/witcher.jpg',
      'title': 'Honest Trailers | The Witcher',
      'date': '5 months ago',
      'views': '2M views',
      'creator': 'Screen Junkies',
      'profile': 'assets/img/screen.jpg',
    },
    {
      'url': 'https://www.youtube.com/watch?v=n_kpJj2War8',
      'thumbnail': 'assets/img/cardano.jpg',
      'title': 'Cardano | Atala Trace & Beefchain (2020)',
      'date': '1 hour ago',
      'views': '30K views',
      'creator': 'David Likes Crypto',
      'profile': 'assets/img/david.jpg',
    },
    {
      'url': 'https://www.youtube.com/watch?v=I7AJwGhNU5o',
      'thumbnail': 'assets/img/keanu.jpg',
      'title': 'Joe Rogan - We Should All Aspire to Be Like Keanu Reeves',
      'date': '1 year ago',
      'views': '1M views',
      'creator': 'JRE Clips',
      'profile': 'assets/img/joe.jpg',
    },
    {
      'url': 'https://www.youtube.com/watch?v=zDME7QO6_tM',
      'thumbnail': 'assets/img/leap_of_faith.jpg',
      'title': 'Spider-Verse | Leap of Faith',
      'date': '9 months ago',
      'views': '800k views',
      'creator': 'Sylfer2812',
      'profile': 'assets/img/sylfer.jpg',
    },
  ];

  List<Widget> _categoriesWidgets = [];

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    Widget row;
    List categories = _categories.keys.toList();
    for(int i = 0; i < _categories.length; i += 2){
      row = Row(
        children: <Widget>[
          Expanded(
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/img/${categories[i].toString().toLowerCase()}.jpeg',
                    fit: BoxFit.cover,
                    height: _screenSize.height * 0.06,
                    width: _screenSize.width * 0.6,
                  ),
                  Container(
                    height: _screenSize.height * 0.06,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Container(
                        color: Colors.black.withOpacity(0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _screenSize.height * 0.015),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        _categories[categories[i]],
                        SizedBox(width : 10),
                        Text(
                          categories[i],
                          style: TextStyle(
                            color: Colors.white, fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/img/${categories[i + 1].toString().toLowerCase()}.jpeg',
                    fit: BoxFit.fill,
                    height: _screenSize.height * 0.06,
                    width: _screenSize.width * 0.6,
                  ),
                  Container(
                    height: _screenSize.height * 0.06,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Container(
                        color: Colors.black.withOpacity(0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _screenSize.height * 0.015),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        _categories[categories[i + 1]],
                        SizedBox(width : 10),
                        Text(
                          categories[i + 1],
                          style: TextStyle(
                            color: Colors.white, fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
      _categoriesWidgets.add(row);
      _categoriesWidgets.add(SizedBox(height: 5,));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: _categoriesWidgets,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[400]))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text('Trending videos', style: TextStyle(fontSize: 15.0),),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                    itemCount: _videos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            AspectRatio(
                              child: Image(
                                image: AssetImage(_videos[index]['thumbnail']),
                                centerSlice: Rect.largest,
                              ),
                              aspectRatio: 16 / 9,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(_videos[index]['profile']),
                              ),
                              title: Text(
                                _videos[index]['title'],
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
                              ),
                              subtitle: Text(_videos[index]['creator']+ " \u22C5 " + _videos[index]['views'] + " \u22C5 "+ _videos[index]['date'], style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                              trailing: Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
