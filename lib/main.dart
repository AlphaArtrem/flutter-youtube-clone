import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_ui/wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(YoutubeUIClone());
}

class YoutubeUIClone extends StatefulWidget {
  @override
  _YoutubeUICloneState createState() => _YoutubeUICloneState();
}

class _YoutubeUICloneState extends State<YoutubeUIClone> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.black),
      home: Wrapper(),
    );
  }
}
