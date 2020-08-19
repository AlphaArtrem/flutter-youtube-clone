import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtubeclone/helper/loading.dart';
import 'package:youtubeclone/helper/youtubeAPI.dart';
import 'package:youtubeclone/screens/videoPlayer.dart';

class LibraryTab extends StatefulWidget {
  @override
  _LibraryTabState createState() => _LibraryTabState();
}

class _LibraryTabState extends State<LibraryTab> {
  List _recent = [];
  SharedPreferences _sharedPreferences;
  static String key = 'AIzaSyAqMLu_Grl4Q6AMxT_ieSDF_Ul6jkchk6c';
  bool _loading = true;
  Map _channelDetails = {};

  YoutubeAPI _api = YoutubeAPI(key);

  void setup() async{
    _sharedPreferences = await SharedPreferences.getInstance();
    List<String> ids = [];
    if(_sharedPreferences.containsKey("history")){
      List _history = _sharedPreferences.getStringList("history");
      if(_history.length > 10){
        _recent = await _api.getVideos(_history.sublist(_history.length - 11, _history.length -1));
      }
      else{
        _recent = await _api.getVideos(_history);
      }

      for(int i = 0; i < _recent.length; i++){
        ids.add(_recent[i]["snippet"]["channelId"]);
      }

      List channels = await _api.getChannelDetails(ids);

      for(Map channel in channels) {
        _channelDetails[channel['id']] = channel;
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

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
            child: _loading ? Center(child: spinkit) : _recent.isEmpty ? Center(child: Text("No history found"),) : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recent.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 0.41,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child:  AspectRatio(
                            child: Image(
                              image: NetworkImage(_recent[index]["snippet"]["thumbnails"]["standard"]["url"]),
                              fit: BoxFit.cover,
                            ),
                            aspectRatio: 16 / 9,
                          ),
                          onTap: () async{
                              Map videoDetails = _recent[index];

                              videoDetails["channelImage"] = _channelDetails[_recent[index]["snippet"]['channelId']]["snippet"]["thumbnails"]["default"]["url"];
                              videoDetails["subscriberCount"] = _channelDetails[_recent[index]["snippet"]['channelId']]["statistics"]["subscriberCount"];
                              await Navigator.push(context, MaterialPageRoute(
                              builder : (context) => VideoPlayer(videoDetails)
                              ));
                           },
                        ),
                        SizedBox(height: 8.0,),
                        Text(_recent[index]["snippet"]['title'], style: TextStyle(fontSize: 14.0), overflow: TextOverflow.ellipsis,),
                        SizedBox(height: 2.0,),
                        Text(_recent[index]["snippet"]['channelTitle'], style: TextStyle(color: Colors.grey, fontSize: 12.0)),
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
