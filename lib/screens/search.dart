import 'package:flutter/material.dart';
import 'package:youtubeclone/helper/functions.dart';
import 'package:youtubeclone/helper/loading.dart';
import 'package:youtubeclone/helper/youtubeAPI.dart';
import 'package:youtubeclone/screens/videoPlayer.dart';

class SearchPage extends StatefulWidget {
  final String search;
  SearchPage(this.search);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  List _videos = [];
  Map _channelDetails = {};

  static String key = 'AIzaSyAqMLu_Grl4Q6AMxT_ieSDF_Ul6jkchk6c';
  YoutubeAPI _api = YoutubeAPI(key);

  void setup() async{

    _videos = await _api.searchVideos(widget.search);

    List<String> ids = [];

    for(int i = 0; i < _videos.length; i++){
      ids.add(_videos[i]["snippet"]["channelId"]);
    }

    List channels = await _api.getChannelDetails(ids);

    for(Map channel in channels) {
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1.0,
        title: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none
              ),
              prefixIcon: Icon(Icons.search, color: Colors.grey[400],),
              hintText: widget.search,
          ),
          onSubmitted: (value) async{
            await Navigator.push(context, MaterialPageRoute(
                builder: (context) => SearchPage(value)
            ));
          },
        ),
      ),
      body: _videos.isEmpty ? spinkit : Padding(
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
                        videoDetails["channelImage"] = _channelDetails[_videos[0]["snippet"]['channelId']]["snippet"]["thumbnails"]["default"]["url"];
                        videoDetails["subscriberCount"] = _channelDetails[_videos[0]["snippet"]['channelId']]["statistics"]["subscriberCount"];
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
