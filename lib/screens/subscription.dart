import 'package:flutter/material.dart';
import 'package:youtubeclone/screens/home.dart';

class SubscriptionTab extends StatefulWidget {
  @override
  _SubscriptionTabState createState() => _SubscriptionTabState();
}

class _SubscriptionTabState extends State<SubscriptionTab> {
  List<Map> _subscriptions = [
    {
      'creator': 'David Likes Crypto',
      'profile': 'assets/img/david.jpg',
    },
    {
      'creator': 'Sylfer2812',
      'profile': 'assets/img/sylfer.jpg',
    },
    {
      'creator': 'JRE Clips',
      'profile': 'assets/img/joe.jpg',
    },
    {
      'creator': 'Sylfer2812',
      'profile': 'assets/img/sylfer.jpg',
    },
    {
      'creator': 'David Likes Crypto',
      'profile': 'assets/img/david.jpg',
    },
    {
      'creator': 'Screen Junkies',
      'profile': 'assets/img/screen.jpg',
    },
  ];

  List<String> _ribbion = [
    'All', 'Today', 'Continue Watching', 'Unwatched', 'Live', 'Posts',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            height: size.height * 0.14,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]))
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _subscriptions.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: size.height * 0.045,
                        backgroundImage: AssetImage(_subscriptions[index]['profile']),
                      ),
                      SizedBox(height: 5,),
                      SizedBox(
                          width: size.height * 0.09,
                          child: Center(child: Text(_subscriptions[index]['creator'], style: TextStyle(color: Colors.grey[500], fontSize: 12), overflow: TextOverflow.ellipsis,))
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.5),
            height: size.height * 0.07,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]))
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _ribbion.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                        child: Center(
                            child: Text(_ribbion[index], style: TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis,)
                        ),
                      )
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: HomeTab(),
          )
        ],
      ),
    );
  }
}
