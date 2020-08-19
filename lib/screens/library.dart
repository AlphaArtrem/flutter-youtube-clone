import 'package:flutter/material.dart';

class LibraryTab extends StatefulWidget {
  @override
  _LibraryTabState createState() => _LibraryTabState();
}

class _LibraryTabState extends State<LibraryTab> {
  List<Map> _history = [
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
    {
      'url': 'https://www.youtube.com/watch?v=Jakrc3Tn_y4',
      'thumbnail': 'assets/img/gaming.jpeg',
      'title': 'PS6 Leaks',
      'date': '16 hours ago',
      'views': '100k views',
      'creator': 'Gamer Hub',
      'profile': 'assets/img/gaming.jpeg',
    },
    {
      'url': 'https://www.youtube.com/watch?v=exgoaU3Fr5E',
      'thumbnail': 'assets/img/live.jpeg',
      'title': 'Android Tricks',
      'date': '5 months ago',
      'views': '2M views',
      'creator': 'Screen Junkies',
      'profile': 'assets/img/screen.jpg',
    },
    {
      'url': 'https://www.youtube.com/watch?v=n_kpJj2War8',
      'thumbnail': 'assets/img/fashion.jpeg',
      'title': 'Get Best Deals At Amazon',
      'date': '1 hour ago',
      'views': '30K views',
      'creator': 'MarketingKing',
      'profile': 'assets/img/david.jpg',
    },
    {
      'url': 'https://www.youtube.com/watch?v=I7AJwGhNU5o',
      'thumbnail': 'assets/img/music.jpeg',
      'title': 'Create Digital Music',
      'date': '1 year ago',
      'views': '1M views',
      'creator': 'BeatWithMe',
      'profile': 'assets/img/joe.jpg',
    },
    {
      'url': 'https://www.youtube.com/watch?v=zDME7QO6_tM',
      'thumbnail': 'assets/img/news.jpeg',
      'title': 'Manipulating the Collective Mind',
      'date': '9 months ago',
      'views': '800k views',
      'creator': 'JackTheRipper',
      'profile': 'assets/img/sylfer.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text('Recent', style: TextStyle(fontSize: 15.0),),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]))
            ),
            height: size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _history.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 0.41,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(_history[index]['thumbnail'], height: size.height * 0.12,),
                        SizedBox(height: 8.0,),
                        Text(_history[index]['title'], style: TextStyle(fontSize: 14.0), overflow: TextOverflow.ellipsis,),
                        SizedBox(height: 2.0,),
                        Text(_history[index]['creator'], style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0, bottom: 8.0),
            child: Row(
              children: [
                Icon(Icons.history),
                SizedBox(width: 25.0,),
                Text('History', style: TextStyle(fontSize: 15.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 8.0),
            child: Row(
              children: [
                Icon(Icons.file_download),
                SizedBox(width: 25.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Downloads', style: TextStyle(fontSize: 15.0),),
                    Text('12 videos', style: TextStyle(fontSize: 12.0, color: Colors.grey[400]),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 8.0),
            child: Row(
              children: [
                Icon(Icons.play_circle_outline),
                SizedBox(width: 25.0,),
                Text('Your videos', style: TextStyle(fontSize: 15.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 8.0),
            child: Row(
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(width: 25.0,),
                Text('Purchases', style: TextStyle(fontSize: 15.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 20.0),
            child: Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 25.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Watch Later', style: TextStyle(fontSize: 15.0),),
                    Text('5 unwatched videos', style: TextStyle(fontSize: 12.0, color: Colors.grey[400]),),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]))
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 15, bottom: 25.0),
            child: Text('Playlists', style: TextStyle(fontSize: 18.0),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 8.0),
            child: Row(
              children: [
                Icon(Icons.add, color: Colors.blueAccent,),
                SizedBox(width: 25.0,),
                Text('New playlist', style: TextStyle(fontSize: 15.0, color: Colors.blueAccent, fontWeight: FontWeight.w400),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 20.0),
            child: Row(
              children: [
                Icon(Icons.thumb_up),
                SizedBox(width: 25.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Liked videos', style: TextStyle(fontSize: 15.0),),
                    Text('107 videos', style: TextStyle(fontSize: 12.0, color: Colors.grey[400]),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
