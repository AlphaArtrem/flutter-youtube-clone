import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_ui/helper/loading.dart';
import 'package:youtube_ui/helper/youtubeAPI.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  static String key = 'Your_Api_Key';
  YoutubeAPI _api = YoutubeAPI(key);

  List _videos = [];

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
    _videos = await _api.getTrendingVideos(region: 'US', maxResults: 100);
    print(_videos[0]["snippet"]["thumbnails"]['high']['url']);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setup();
  }
  var a = {
      "kind": "youtube#video",
      "etag": "psSyD50a5d343kVOXE2xIqMdGlA",
      "id": "oxoWhyS9buA",
      "snippet": {
        "publishedAt": "2020-08-18T15:00:02Z",
        "channelId": "UC3IZKseVpdzPSBaWxBxundA",
        "title": "BTS (방탄소년단) 'Dynamite' Official Teaser",
        "description": "BTS (방탄소년단) 'Dynamite' Official Teaser\n\nBTS (방탄소년단) 'Dynamite' Official MV will be released at 1PM(KST), 12AM(EST) on August 21, 2020\n\n\nCredits:\nDirector: Yong Seok Choi (Lumpens)\nAssistant Director: Jihye Yoon (Lumpens)\n\nDirector of Photography: Hyunwoo Nam (GDW)\nB Camera Operator: Eumko\nFocus Puller: Sangwoo Yun, Youngwoo Lee\n2nd AC: Eunki Kim\n3rd AC: Kyuwon Seo\nDIT: Eunil Lee\n\nGaffer: Song Hyunsuk\nLighting Crew: Choi Jung Hyun, Hwang Uigyu, Kim Hyun Ju, Park Cheonil, Park Yeonghwan, Yeom Jaehyeok\n\nJimmy Jib Operator: Youngjung Kim\nJimmy Jib Assistant: Hyun in Kim, Sung Hoon Kim\n\nArt Director: Bona Kim, Jinsil Park (MU:E)\nAssistant Art Team: Yeri Kang (MU:E)\nArt-team Manager: ilho Heo (MU:E)\n\nProducer: Emma Sungeun Kim (GE Production)\nLocation Manager: Ji Hoon Han\n\nVFX STUDIO: PLASTIC BEACH\nVFX Supervisor: Ohzeon\nVFX Assistant Supervisor: Jojeem\nVFX Project Manager: Chanyoung Song, Jieun Jeong\nVFX Producer: Kyutae Jang\n3D Artist: Kwangwon Lee, Doyeon Kim, Jeonghwa Lee, Jiwon Jeon\n2D Artist: Gihoon Jang, Hyunjun Lee\n\nVisual Creative: Nu Kim, Sabinne Cheon, Lee Sun Kyoung, Kim Ga Eun, Jung Su Jung\nPerformance Directing: Son Sung Deuk, Lee Ga Hun, Lee Byung Eun, Hyewon Park\nArtist Management: Kim Shin Gyu, Kim Su Bin, Kim Dae Young, Park Jun Tae, An Da Sol, Ahn Jong Hun, Yun Tae Woong, Lee Seung Byeong, Lee Jung Min\n\nBig Hit Entertainment. Rights are reserved selectively in the video. Unauthorized reproduction is a violation of applicable laws. Manufactured by Big Hit Entertainment, Seoul, Korea.\n\nConnect with BTS: \nhttps://ibighit.com/bts \nhttp://twitter.com/BTS_bighit\nhttp://twitter.com/BTS_twt \nhttp://www.facebook.com/bangtan.official \nhttps://www.youtube.com/user/BANGTANTV \nhttp://instagram.com/BTS.bighitofficial \nhttps://channels.vlive.tv/FE619 \nhttps://www.tiktok.com/@bts_official_bighit\nhttps://weverse.onelink.me/qt3S/94808190\nhttps://www.weibo.com/BTSbighit\nhttps://www.weibo.com/BTSmembers \nhttp://i.youku.com/btsofficial \nhttp://btsblog.ibighit.com\n\n\n#BTS #방탄소년단 #BTS_Dynamite #Dynamite #Teaser",
        "thumbnails": {
          "default": {
            "url": "https://i.ytimg.com/vi/oxoWhyS9buA/default.jpg",
            "width": 120,
            "height": 90
          },
          "medium": {
            "url": "https://i.ytimg.com/vi/oxoWhyS9buA/mqdefault.jpg",
            "width": 320,
            "height": 180
          },
          "high": {
            "url": "https://i.ytimg.com/vi/oxoWhyS9buA/hqdefault.jpg",
            "width": 480,
            "height": 360
          },
          "standard": {
            "url": "https://i.ytimg.com/vi/oxoWhyS9buA/sddefault.jpg",
            "width": 640,
            "height": 480
          },
          "maxres": {
            "url": "https://i.ytimg.com/vi/oxoWhyS9buA/maxresdefault.jpg",
            "width": 1280,
            "height": 720
          }
        },
        "channelTitle": "Big Hit Labels",
        "tags": [
          "BIGHIT",
          "빅히트",
          "방탄소년단",
          "BTS",
          "BANGTAN",
          "방탄"
        ],
        "categoryId": "10",
        "liveBroadcastContent": "none",
        "defaultLanguage": "ko",
        "localized": {
          "title": "BTS (방탄소년단) 'Dynamite' Official Teaser",
          "description": "BTS (방탄소년단) 'Dynamite' Official Teaser\n\nBTS (방탄소년단) 'Dynamite' Official MV will be released at 1PM(KST), 12AM(EST) on August 21, 2020\n\n\nCredits:\nDirector: Yong Seok Choi (Lumpens)\nAssistant Director: Jihye Yoon (Lumpens)\n\nDirector of Photography: Hyunwoo Nam (GDW)\nB Camera Operator: Eumko\nFocus Puller: Sangwoo Yun, Youngwoo Lee\n2nd AC: Eunki Kim\n3rd AC: Kyuwon Seo\nDIT: Eunil Lee\n\nGaffer: Song Hyunsuk\nLighting Crew: Choi Jung Hyun, Hwang Uigyu, Kim Hyun Ju, Park Cheonil, Park Yeonghwan, Yeom Jaehyeok\n\nJimmy Jib Operator: Youngjung Kim\nJimmy Jib Assistant: Hyun in Kim, Sung Hoon Kim\n\nArt Director: Bona Kim, Jinsil Park (MU:E)\nAssistant Art Team: Yeri Kang (MU:E)\nArt-team Manager: ilho Heo (MU:E)\n\nProducer: Emma Sungeun Kim (GE Production)\nLocation Manager: Ji Hoon Han\n\nVFX STUDIO: PLASTIC BEACH\nVFX Supervisor: Ohzeon\nVFX Assistant Supervisor: Jojeem\nVFX Project Manager: Chanyoung Song, Jieun Jeong\nVFX Producer: Kyutae Jang\n3D Artist: Kwangwon Lee, Doyeon Kim, Jeonghwa Lee, Jiwon Jeon\n2D Artist: Gihoon Jang, Hyunjun Lee\n\nVisual Creative: Nu Kim, Sabinne Cheon, Lee Sun Kyoung, Kim Ga Eun, Jung Su Jung\nPerformance Directing: Son Sung Deuk, Lee Ga Hun, Lee Byung Eun, Hyewon Park\nArtist Management: Kim Shin Gyu, Kim Su Bin, Kim Dae Young, Park Jun Tae, An Da Sol, Ahn Jong Hun, Yun Tae Woong, Lee Seung Byeong, Lee Jung Min\n\nBig Hit Entertainment. Rights are reserved selectively in the video. Unauthorized reproduction is a violation of applicable laws. Manufactured by Big Hit Entertainment, Seoul, Korea.\n\nConnect with BTS: \nhttps://ibighit.com/bts \nhttp://twitter.com/BTS_bighit\nhttp://twitter.com/BTS_twt \nhttp://www.facebook.com/bangtan.official \nhttps://www.youtube.com/user/BANGTANTV \nhttp://instagram.com/BTS.bighitofficial \nhttps://channels.vlive.tv/FE619 \nhttps://www.tiktok.com/@bts_official_bighit\nhttps://weverse.onelink.me/qt3S/94808190\nhttps://www.weibo.com/BTSbighit\nhttps://www.weibo.com/BTSmembers \nhttp://i.youku.com/btsofficial \nhttp://btsblog.ibighit.com\n\n\n#BTS #방탄소년단 #BTS_Dynamite #Dynamite #Teaser"
        },
        "defaultAudioLanguage": "en"
      },
      "contentDetails": {
        "duration": "PT29S",
        "dimension": "2d",
        "definition": "hd",
        "caption": "false",
        "licensedContent": true,
        "contentRating": {},
        "projection": "rectangular"
      },
      "statistics": {
        "viewCount": "29134422",
        "likeCount": "3675872",
        "dislikeCount": "59858",
        "favoriteCount": "0",
        "commentCount": "775217"
      }
    };


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _videos.isEmpty ? spinkit : ListView.builder(
      itemCount: _videos.length,
      itemBuilder: (BuildContext context, int index) {
        String publishedAt = '';
        Duration difference = DateTime.now().difference(DateTime.parse(_videos[index]["snippet"]["publishedAt"]));

        if(difference.inDays > 0){
          if(difference.inDays > 365){
            publishedAt += (difference.inDays / 365).floor().toString() + ' years ago';
          }
          if(difference.inDays > 30 && difference.inDays < 365){
            publishedAt += (difference.inDays / 30).floor().toString() + ' months ago';
          }
          if(difference.inDays >=1 && difference.inDays < 305){
            publishedAt += difference.inDays.floor().toString() + ' days ago';
          }
        }
        else if(difference.inHours > 0){
          publishedAt += difference.inHours.toString() + ' hours ago';
        }
        else if(difference.inMinutes > 0){
          publishedAt += difference.inMinutes.toString() + ' minutes ago';
        }
        else{
          publishedAt += difference.inSeconds.toString() + ' seconds ago';
        }

        String viewOriginal = _videos[index]["statistics"]["viewCount"];
        int views = int.parse(viewOriginal);
        String viewCount = views.toString() + ' views';

        if(views > 1000 && views < 1000000){
          viewCount = (views ~/ 1000).toString() + 'k views';
        }
        else if(views >= 1000000){
          viewCount = (views ~/ 1000000).toString() + 'M views';
        }


        String thumbnail  = _videos[index]["snippet"]["thumbnails"]["high"]["url"];

        return Container(
          child: Column(
            children: <Widget>[
              AspectRatio(
                child: Image(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover,
                ),
                aspectRatio: 16 / 9,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/img/david.jpg'),
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
