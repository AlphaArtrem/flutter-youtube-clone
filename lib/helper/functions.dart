String uploadDuration(String uploadTimestamp){
  String publishedAt = uploadTimestamp;
  Duration difference = DateTime.now().difference(DateTime.parse(publishedAt));

  if(difference.inDays > 0){
    if(difference.inDays > 365){
      publishedAt = (difference.inDays / 365).floor().toString() + ' years ago';
    }
    if(difference.inDays > 30 && difference.inDays < 365){
      publishedAt = (difference.inDays / 30).floor().toString() + ' months ago';
    }
    if(difference.inDays >=1 && difference.inDays < 305){
      publishedAt = difference.inDays.floor().toString() + ' days ago';
    }
  }
  else if(difference.inHours > 0){
    publishedAt = difference.inHours.toString() + ' hours ago';
  }
  else if(difference.inMinutes > 0){
    publishedAt = difference.inMinutes.toString() + ' minutes ago';
  }
  else{
    publishedAt = difference.inSeconds.toString() + ' seconds ago';
  }

  return publishedAt;

}

String formatViewCount(String viewCountText){
  int views = int.parse(viewCountText);
  String viewCount = views.toString() + ' views';

  if(views > 1000 && views < 1000000){
    viewCount = (views ~/ 1000).toString() + 'k views';
  }
  else if(views >= 1000000){
    viewCount = (views ~/ 1000000).toString() + 'M views';
  }
  return viewCount;
}