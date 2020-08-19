import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Stories extends StatefulWidget {
  final Size size;
  Stories(this.size);
  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  List<Map> _stories = [
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


  List<Widget> _storyCards = [];
  List<Widget> _storyCardsRemoved = [];

  @override
  void initState() {
    super.initState();
    if(_storyCards.isEmpty){
      _storyCards = _getStoryCards();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: _storyCards,
        ),
      ),
    );
  }

  List<Widget> _getStoryCards() {
    List<Widget> cardList = List();
    for (int i = 0; i < _stories.length; i++) {
      cardList.add(Positioned(
        child: Draggable(
          onDragEnd: (drag){
            if(drag.offset.direction > 1){
              if(_storyCardsRemoved.length > 0){
                _storyCards.add(_storyCardsRemoved.removeLast());
                setState(() {});
              }

            }
            else {
              if(_storyCards.length > 1){
                _storyCardsRemoved.add(_storyCards.removeLast());
                setState(() {});
              }
            }
          },
          childWhenDragging: Container(),
          feedback: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Image.asset(_stories[i]['thumbnail'], height: widget.size.height * 0.8, fit: BoxFit.cover, width: widget.size.width * 0.9,),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Image.asset(_stories[i]['thumbnail'], height: widget.size.height * 0.96, fit: BoxFit.cover, width: widget.size.width),
                  Positioned(
                    top: 10,
                    left: widget.size.width * 0.85,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Icon(Icons.thumb_up, color: Colors.white,),
                    ),
                  ),
                  Positioned(
                    top: widget.size.height * 0.9,
                    left: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_stories[i]['title'], style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500)),
                        Text(_stories[i]['creator'], style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }
    return cardList;
  }
}
