import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtubeclone/helper/functions.dart';
import 'package:youtubeclone/helper/loading.dart';
import 'package:youtubeclone/helper/youtubeAPI.dart';
import 'package:youtubeclone/screens/videoPlayer.dart';


class PrefVideos extends StatefulWidget {
  final String prefKey;
  final String title;
  PrefVideos(this.prefKey, this.title);
  @override
  _PrefVideosState createState() => _PrefVideosState();
}

class _PrefVideosState extends State<PrefVideos> {
  TextEditingController _controller = TextEditingController();
  List _videos = [];
  Map _channelDetails = {};
  SharedPreferences _sharedPreferences;
  bool _loading = true;

  YoutubeAPI _api = YoutubeAPI();

  void setup() async{
    _sharedPreferences = await SharedPreferences.getInstance();
    List<String> ids = [];
    if(_sharedPreferences.containsKey(widget.prefKey)){
      List _history = _sharedPreferences.getStringList(widget.prefKey);
      if(_history.length > 10){
        _videos = await _api.getVideos(_history.sublist(_history.length - 11, _history.length -1).reversed.toList());
      }
      else{
        _videos = await _api.getVideos(_history.reversed.toList());
      }

      if(_videos == null){
        _videos = [];
      }

      for(int i = 0; i < _videos.length ; i++){
        ids.add(_videos[i]["snippet"]["channelId"]);
      }

      List channels = await _api.getChannelDetails(ids);

      if(channels == null){
        channels = [];
      }

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
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(widget.title),
      ),
      body: _loading ? spinkit : _videos.isEmpty ? Center(child: Text("No ${widget.title} found"),) : Padding(
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: ListView.builder(
          itemCount: _videos.length,
          itemBuilder: (context, index){
            String publishedAt = uploadDuration(_videos[index]["snippet"]["publishedAt"]);
            String thumbnail  = _videos[index]["snippet"]["thumbnails"]["standard"]["url"];
            return Container(
              padding: EdgeInsets.only(right: 15, bottom: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () async{
                        Map videoDetails = _videos[index];
                        videoDetails["channelImage"] = _channelDetails[_videos[index]["snippet"]['channelId']]["snippet"]["thumbnails"]["default"]["url"];
                        videoDetails["subscriberCount"] = _channelDetails[_videos[index]["snippet"]['channelId']]["statistics"]["subscriberCount"];
                        await Navigator.push(context, MaterialPageRoute(
                            builder : (context) => VideoPlayer(videoDetails)
                        ));
                      },
                      child: Image(
                        image: NetworkImage(thumbnail),
                        fit: BoxFit.cover,
                        width: size.width * 0.4,
                        height: size.height * 0.1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _videos[index]["snippet"]['title'],
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.0),
                        Text(_videos[index]["snippet"]['channelTitle'], style: TextStyle(color: Colors.grey, fontSize: 12.0), maxLines: 1, overflow: TextOverflow.ellipsis,),
                        Text(publishedAt, style: TextStyle(color: Colors.grey, fontSize: 12.0), maxLines: 1, overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
