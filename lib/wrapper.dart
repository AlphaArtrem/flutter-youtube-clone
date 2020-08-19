import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtubeclone/helper/accounts.dart';
import 'package:youtubeclone/screens/explore.dart';
import 'package:youtubeclone/screens/home.dart';
import 'package:youtubeclone/screens/library.dart';
import 'package:youtubeclone/screens/notifications.dart';
import 'package:youtubeclone/screens/profile.dart';
import 'package:youtubeclone/screens/search.dart';
import 'package:youtubeclone/screens/stories.dart';
import 'package:youtubeclone/screens/subscription.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[HomeTab(),ExploreTab(),SubscriptionTab(), NotificationsTab(), LibraryTab(),];
  Account _user = Account();
  bool _search = false;
  TextEditingController _controller = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title:  _search ? TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none
            ),
            prefixIcon: Icon(Icons.search, color: Colors.grey[400],),
            hintText: "Search..."
          ),
          onSubmitted: (value) async{
            await Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchPage(value)
            ));
            setState(() {
              _search = false;
            });
          },
        ) : Image.asset('assets/img/logo.png', height: size.width * 0.18,),
        actions: _search? [] : <Widget>[
          IconButton(
            onPressed: () async{
              SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
              await Navigator.push(context, MaterialPageRoute(
                builder: (context) => Stories(MediaQuery.of(context).size),
              ));
              SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              ));
            },
            icon: Icon(Icons.ondemand_video),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.videocam),
          ),
         IconButton(
            onPressed: () {
              setState(() {
                _search = true;
              });
            },
            icon: Icon(Icons.search),
          ),
          _user.currentUser() == null ?IconButton(
            onPressed: () async{
              await _user.signInWithGoogle();
            },
            icon: Icon(Icons.person),
          ) : GestureDetector(
            onTap: () async {
              await Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProfilePage()
              ));
              setState(() {});
            },
            child: CircleAvatar(
              child: ClipOval(
                child: Image.network(_user.currentUser().photoUrl),
              ),
              radius: size.width * 0.055,
            ),
          ),
          SizedBox(width: 5,),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text('Explore'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            title: Text('Subscriptions'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            title: Text('Library'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey[800],
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
