import 'dart:convert';
import 'package:http/http.dart' as http;

class YoutubeAPI{
  final String key;
  YoutubeAPI(this.key);

  Future<List> getTrendingVideos({String region = 'us', int maxResults = 10}) async{
    Map<String, dynamic> options = {
      "part": ["snippet,contentDetails,statistics"],
      "chart": "mostPopular",
      "maxResults": "$maxResults",
      "regionCode": "$region",
      "key": "${this.key}",
    };

    Uri uri = Uri(scheme:'https', host: "www.googleapis.com", path: "youtube/v3/videos", queryParameters: options);

    //Uri url = Uri.https("www.googleapis.com", "youtube/v3/videos", options);
    var res = await http.get(uri, headers: {"Accept": "application/json"});
    Map jsonData = json.decode(res.body);

    //print(jsonData["items"][0].keys);
    return jsonData['items'];
  }
}