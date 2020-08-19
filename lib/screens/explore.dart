import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:youtube_ui/helper/functions.dart';
import 'package:youtube_ui/helper/loading.dart';
import 'package:youtube_ui/helper/youtubeAPI.dart';
import 'package:youtube_ui/screens/videoPlayer.dart';

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

  static String key = 'AIzaSyAqMLu_Grl4Q6AMxT_ieSDF_Ul6jkchk6c';
  YoutubeAPI _api = YoutubeAPI(key);

  List _videos = [];
  List _allVideos = [];
  Map _channelDetails = {};
  List<Widget> _categoriesWidgets = [];
  List<Widget> _videosWidgets = [];

  void setup() async{
    List regions = ['IN','GB', 'US', 'AU', 'CA'];
    for(String region in regions){
      _allVideos.addAll(await _api.getTrendingVideos(region: region, maxResults: 100));
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
    Size _screenSize = MediaQuery.of(context).size;
    Widget row;
    List categories = _categories.keys.toList();
    for(int i = 0; i < _categories.length && _categoriesWidgets.length < _categories.length; i += 2){
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

    for(int index = 0 ; index < _videos.length && _videos.isNotEmpty; index++){
      String publishedAt = uploadDuration(_videos[index]["snippet"]["publishedAt"]);
      String viewCount = formatViewCount(_videos[index]["statistics"]["viewCount"]);
      String thumbnail  = _videos[index]["snippet"]["thumbnails"]["high"]["url"];

      _videosWidgets.add(Container(
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
          ],
        ),
      ));
    }

    return _videos.isEmpty ? spinkit :ListView(
      children: [
        Container(
          height: _screenSize.height * 0.33,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: _categoriesWidgets,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[400]))
          ),
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text('Trending videos', style: TextStyle(fontSize: 15.0),),
        ),
        SizedBox(height: 10,),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _videosWidgets
          ),
        )
      ],
    );
  }
}
