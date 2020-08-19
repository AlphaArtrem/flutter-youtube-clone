import 'package:flutter/material.dart';

class NotificationsTab extends StatefulWidget {
  @override
  _NotificationsTabState createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  List<Map> _notifications = [
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
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      color: Colors.white,
      child: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: Row(
              children: [
                SizedBox(width: 10.0,),
                Expanded(
                  flex:  2,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(_notifications[index]['profile']),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_notifications[index]['creator'] + ' uploaded : ' + _notifications[index]['title'], style: TextStyle(fontSize: 13),),
                      SizedBox(height: 5,),
                      Text(_notifications[index]['date'], style: TextStyle(color: Colors.grey[500]),),
                    ],
                  ),
                ),
                SizedBox(width: 15.0,),
                Expanded(
                  flex: 5,
                  child: Image.asset(_notifications[index]['thumbnail']),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.more_vert, color: Colors.grey[500], size: 18,),
                ),
                SizedBox(width: 10,),
              ],
            ),
          );
        },
      ),
    );
  }
}
