import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
