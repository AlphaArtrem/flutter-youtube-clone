import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtubeclone/helper/functions.dart';
import 'package:youtubeclone/helper/loading.dart';
import 'package:youtubeclone/helper/youtubeAPI.dart';
import 'package:youtubeclone/screens/videoPlayer.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  //static String key = 'Your-API-Key';
  static String key = 'AIzaSyAqMLu_Grl4Q6AMxT_ieSDF_Ul6jkchk6c';
  YoutubeAPI _api = YoutubeAPI(key);

  List _videos = [];
  List _allVideos = [];
  Map _channelDetails = {};

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

  void setup() async{
    List regions = ['IN','GB', 'US', 'AU', 'CA'];
    for(String region in regions){
      _allVideos.addAll(await _api.getTrendingVideos(region: region, maxResults: 5));
    }

    Random random = Random();

    List<String> ids = [];

    for(int i = 0; i < 10; i++){
      var nextVid = _allVideos[random.nextInt(_allVideos.length)];
      if(_videos.contains(nextVid)){
        i--;
        continue;
      }
      _videos.add(nextVid);
      ids.add(_videos[i]["snippet"]["channelId"]);
    }

    List channels = await _api.getChannelDetails(ids);
    for(Map channel in channels){
      _channelDetails[channel['id']] = channel;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setup();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _videos.isEmpty ? spinkit : ListView.builder(
      itemCount: _videos.length,
      itemBuilder: (BuildContext context, int index) {
        String publishedAt = uploadDuration(_videos[index]["snippet"]["publishedAt"]);
        String viewCount = formatViewCount(_videos[index]["statistics"]["viewCount"]);
        String thumbnail  = _videos[index]["snippet"]["thumbnails"]["high"]["url"];

        return Container(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () async{
                  Map videoDetails = _videos[index];
                  videoDetails["channelImage"] = _channelDetails[_videos[0]["snippet"]['channelId']]["snippet"]["thumbnails"]["default"]["url"];
                  videoDetails["subscriberCount"] = _channelDetails[_videos[0]["snippet"]['channelId']]["statistics"]["subscriberCount"];
                  await Navigator.push(context, MaterialPageRoute(
                      builder : (context) => VideoPlayer(videoDetails)
                  ));
                },
                child: AspectRatio(
                  child: Image(
                    image: NetworkImage(thumbnail),
                    fit: BoxFit.cover,
                  ),
                  aspectRatio: 16 / 9,
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_channelDetails[_videos[0]["snippet"]['channelId']]["snippet"]["thumbnails"]["default"]["url"]),
                ),
                title: Text(
                  _videos[index]["snippet"]['title'],
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
                ),
                subtitle: Text(_videos[index]["snippet"]['channelTitle'] + " \u22C5 " + viewCount + " \u22C5 "  + publishedAt, style: TextStyle(color: Colors.grey, fontSize: 12.0)),
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
