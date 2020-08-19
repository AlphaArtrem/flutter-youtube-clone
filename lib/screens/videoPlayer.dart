import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtubeclone/helper/firestore.dart';
import 'package:youtubeclone/helper/functions.dart';
import 'package:youtubeclone/helper/loading.dart';
import 'package:youtubeclone/helper/youtubeAPI.dart';
import 'package:share/share.dart';


class VideoPlayer extends StatefulWidget {
  final Map videoDetails;
  VideoPlayer(this.videoDetails);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  bool _liked = false;
  bool _later = false;
  SharedPreferences _sharedPreferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  List _videos = [];
  List<Widget> _videosWidgets = [];
  Map _channelDetails = {};
  String _id;

  static String key = 'AIzaSyAqMLu_Grl4Q6AMxT_ieSDF_Ul6jkchk6c';
  YoutubeAPI _api = YoutubeAPI(key);

  void setup() async{
    _sharedPreferences =  await SharedPreferences.getInstance();
    if(_sharedPreferences.containsKey("history")){
      List<String> recent = _sharedPreferences.getStringList("history");
      if(!recent.contains(widget.videoDetails["id"])){
        recent.add(widget.videoDetails["id"]);
        await _sharedPreferences.setStringList("history", recent);
      }
    }
    else{
      List<String> recent = [];
      recent.add(widget.videoDetails["id"]);
      await _sharedPreferences.setStringList("history", recent);
    }

    if(_sharedPreferences.containsKey("likedVideos")){
      List<String> liked = _sharedPreferences.getStringList("likedVideos");
      if(liked.contains(widget.videoDetails["id"])){
        _liked = true;
      }
    }

    if(_sharedPreferences.containsKey("watchLater")){
      List<String> liked = _sharedPreferences.getStringList("watchLater");
      if(liked.contains(widget.videoDetails["id"])){
        _later = true;
      }
    }

    try{
      _id = widget.videoDetails["id"];
    }catch(e){
      _id = widget.videoDetails["id"]["videoId"];
    }
    _controller = YoutubePlayerController(
      initialVideoId: _id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    _videos = await _api.getRelatedVideos(_id);

    List<String> ids = [];

    for(int i = 0; i < _videos.length; i++){
      ids.add(_videos[i]["snippet"]["channelId"]);
    }

    List channels = await _api.getChannelDetails(ids);
    for(Map channel in channels){
      _channelDetails[channel['id']] = channel;
    }
    setState(() {});

    for(int index = 0 ; index < _videos.length && _videos.isNotEmpty; index++){
      String publishedAt = uploadDuration(_videos[index]["snippet"]["publishedAt"]);
      String thumbnail  = _videos[index]["snippet"]["thumbnails"]["high"]["url"];

      _videosWidgets.add(Container(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () async{
                Map videoDetails = _videos[index];
                videoDetails["channelImage"] = _channelDetails[_videos[0]["snippet"]['channelId']]["snippet"]["thumbnails"]["default"]["url"];
                videoDetails["subscriberCount"] = _channelDetails[_videos[0]["snippet"]['channelId']]["statistics"]["subscriberCount"];
                _controller.pause();
                await Navigator.push(context, MaterialPageRoute(
                    builder : (context) => VideoPlayer(videoDetails)
                ));
                _controller.play();
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
              subtitle: Text(_videos[index]["snippet"]['channelTitle'] + " \u22C5 " + publishedAt, style: TextStyle(color: Colors.grey, fontSize: 12.0)),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),
      ));
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String publishedAt = uploadDuration(widget.videoDetails["snippet"]["publishedAt"]);
    String viewCount;
    try{
      viewCount = formatViewCount(widget.videoDetails["statistics"]["viewCount"]) + " \u22C5 ";
    }catch(e){
      viewCount = "";
    }
    return _videosWidgets.isEmpty ? Container(color: Colors.white, child: spinkit,) : YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(widget.videoDetails["snippet"]['title'], style: const TextStyle(color: Colors.white, fontSize: 18.0,), overflow: TextOverflow.ellipsis, maxLines: 1,),
          ),
        ],
        onEnded: (data) {
          //_controller.load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          _showSnackBar('Video Ended');
        },
      ),
      builder: (context, player) => Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: [
            player,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 15, top: 15),
                  child: Text(widget.videoDetails["snippet"]['title'], style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                  child: Text(viewCount + publishedAt, style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.thumb_up, color: _liked ? Colors.red : Colors.black,),
                        onPressed: () async{
                          if(_sharedPreferences.containsKey("likedVideos")){
                            List<String> liked = _sharedPreferences.getStringList("likedVideos");
                            if( liked.contains(widget.videoDetails["id"])){
                              liked.remove(widget.videoDetails["id"]);
                              setState(() {
                                _liked = false;
                              });
                            }
                            else{
                              liked.add(widget.videoDetails["id"]);
                              setState(() {
                                _liked = true;
                              });
                            }
                            await _sharedPreferences.setStringList("likedVideos", liked);
                          }
                          else{
                            await _sharedPreferences.setStringList("likedVideos", <String>[widget.videoDetails["id"]]);
                            setState(() {
                              _liked = true;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.share),
                        onPressed: (){
                          Share.share(
                              "https://www.youtube.com/watch?v=" + _id + "\n" + widget.videoDetails["snippet"]['title'] + "\n" + widget.videoDetails["snippet"]['description'] ,
                              subject: widget.videoDetails["snippet"]['title']
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.watch_later, color:  _later ? Colors.red : Colors.black,),
                        onPressed: () async{
                          if(_sharedPreferences.containsKey("watchLater")){
                            List<String> liked = _sharedPreferences.getStringList("watchLater");
                            if( liked.contains(widget.videoDetails["id"])){
                              liked.remove(widget.videoDetails["id"]);
                              setState(() {
                                _later = false;
                              });
                            }
                            else{
                              liked.add(widget.videoDetails["id"]);
                              setState(() {
                                _later = true;
                              });
                            }
                            await _sharedPreferences.setStringList("watchLater", liked);
                          }
                          else{
                            await _sharedPreferences.setStringList("watchLater", <String>[widget.videoDetails["id"]]);
                            setState(() {
                              _later = true;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  padding: const EdgeInsets.only(top: 10.0, left: 8.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey[300]),
                        bottom: BorderSide(color: Colors.grey[300])
                    )
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(widget.videoDetails["channelImage"]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.videoDetails["snippet"]['channelTitle'], style: TextStyle( fontSize: 15.0, fontWeight: FontWeight.w400)),
                                  SizedBox(height: 5),
                                  Text(formatViewCount(widget.videoDetails['subscriberCount']), style: TextStyle( fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.grey[500])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text("SUBSCRIBE", style: TextStyle( fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red)),
                      SizedBox(width: 15),
                    ],
                  ),
                )
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 10, bottom: 10),
            child: Text('Related videos', style: TextStyle(fontSize: 15.0),),
          ),
          Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _videosWidgets
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }

}
