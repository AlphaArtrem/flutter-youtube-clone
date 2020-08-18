import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  List<Map> _shortVideos = [
    {
      'time' : '0:54',
      'title' : 'Simple coding trick',
      'creator' : 'freeCodeCamp',
      'thumbnail': 'assets/img/anonymous.jpeg',
    },
    {
      'time' : '0:45',
      'title' : 'Chris Evan Talks About Marvel Future',
      'creator' : 'ScreenGeeks',
      'thumbnail': 'assets/img/chris.jpeg',
    },
    {
      'time' : '0:15',
      'title' : 'New Flash Costume',
      'creator' : 'ComicStorian',
      'thumbnail': 'assets/img/flash.jpeg',
    },
    {
      'time' : '0:30',
      'title' : 'Workout Tip For Women',
      'creator' : 'GirlMuscles',
      'thumbnail': 'assets/img/gym.jpeg',
    },
    {
      'time' : '0:25',
      'title' : 'Independence Day Highlight',
      'creator' : 'IndiaNews',
      'thumbnail': 'assets/img/india.jpeg',
    },
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              index == 0 ? Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey[400]), bottom: BorderSide(color: Colors.grey[400]))
                ),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Short videos', style: TextStyle(fontSize: 15.0),),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: size.height * 0.4,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _videos.length,
                        itemBuilder: (BuildContext context, int ind){
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                children: [
                                  Image.asset(_shortVideos[ind]['thumbnail'], width: size.width * 0.4, height: size.height * 0.4, fit: BoxFit.fitHeight),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                    padding: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(_shortVideos[ind]['time'], style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w600),),
                                  ),
                                  Positioned(
                                      left: size.width * 0.35,
                                      top: 8.0,
                                      child: Icon(Icons.more_vert, color: Colors.white, size: 15.0,)
                                  ),
                                  Container(
                                      width: size.width * 0.35,
                                      padding: EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(_shortVideos[ind]['title'], style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w500)),
                                          SizedBox(height: 10.0,),
                                          Text(_shortVideos[ind]['creator'], style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w400)),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ) : Container()
            ],
          ),
        );
      },
    );
  }
}
