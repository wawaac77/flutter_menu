import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_menu/model/category_result_model.dart';
import 'package:flutter_menu/pages/pack/pack_list_screen.dart';
import 'package:flutter_menu/pages/scaffold/zoom_scaffold.dart';
import 'package:http/http.dart' as http;

final Future<ResultModel> result = fetchPost();

final Screen restaurantScreen = new Screen(
    title: "Club SIM",
    background: new DecorationImage(
      image: new AssetImage('assets/background_blue_gold.jpg'),
      fit: BoxFit.cover,
    ),
    contentBuilder: (BuildContext context) {
      PackIconListView packIconListView;
      ScrollController _scrollController;
      _scrollController = new ScrollController()
        ..addListener(() {
          print("offset in add listener = ${_scrollController.offset}");
        });
      return new FutureBuilder<ResultModel>(
        future: result,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            packIconListView = new PackIconListView(snapshot: snapshot, scrollController: _scrollController,);
            return new Row(
              children: <Widget>[
                new Container(
                  child: packIconListView,
                  width: 40,
                  height: MediaQuery.of(context).size.height,
                ),
                new Expanded(
                  child: new Listener(
                    child: new ListView.builder(
                      itemBuilder: (context, index) => new _PackCard(
                        headImageAssetPath: snapshot.data.categoryList[index].img,
                        title: snapshot.data.categoryList[index].name,
                        subTitle: 'Candy with name of person you love',
                        icon: Icons.fastfood,
                        iconBackgroundColor: Color(int.parse('0x' + snapshot.data.categoryList[index].color.replaceFirst('#', ''))).withOpacity(1.0),
                        heartCount: 23,
                      ),
                      controller: _scrollController,
                      itemCount: snapshot.data.categoryList.length,
                    ),
                    onPointerMove: (PointerMoveEvent moveEvent) {
                      print("offset = ${_scrollController.offset}");
                    },
                    onPointerUp: (PointerUpEvent moveEvent) {
                      print("offset onPointerUp = ${_scrollController.offset}");
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return new Text(
              'error',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    }
);

Future<ResultModel> fetchPost() async {
  String lang = 'eng';
  String strUrl = 'https://uat.clubsim.com.hk/clsmw/api/?action=240&platform=ios&lang=$lang&link=true';
  final response = await http.get(strUrl);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print('call api');
    return ResultModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class _PackIcon extends StatefulWidget {
  ScrollController controller;
  final double index;
  final String avatarImagePath;
  final bool isSelected;

  _PackIcon ({
    this.controller,
    this.index,
    this.avatarImagePath,
    this.isSelected,
  });

  @override
  _PackIconState createState() {
    return new _PackIconState();
  }
}

class _PackIconState extends State<_PackIcon> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        widget.controller.animateTo(widget.index * 200, duration: new Duration(seconds: 1), curve: Curves.ease);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: new Container(
          height: widget.isSelected? 50 : 40,
          padding: EdgeInsets.all(5.0),
          child: Image.network(
            widget.avatarImagePath,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}

class _PackCard extends StatelessWidget {
  final String headImageAssetPath;
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subTitle;
  final int heartCount;


  _PackCard({
    this.headImageAssetPath,
    this.icon,
    this.iconBackgroundColor,
    this.title,
    this.subTitle,
    this.heartCount,
  });

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PackListScreen()),
//          MaterialPageRoute(builder: (context) => WebScreen()),

        );
      },
      child: new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
        child: new Card(
          elevation: 8.0,
          child: new Column(
            children: <Widget>[
              new Image.network(
                headImageAssetPath,
                width: double.infinity,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              new Row(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                        color: iconBackgroundColor,
                        borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
                      ),
                      child: new Icon(
                        icon,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        new Text(
                          subTitle,
                          style: const TextStyle(
                            fontSize: 13.0,
                            letterSpacing: 0.5,
                            color: const Color(0xFFAAAAAA),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    width: 2.0,
                    height: 70.0,
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white,
                          const Color(0xFFAAAAAA),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right:15.0),
                    child: new Column(
                      children: <Widget>[
                        new Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                        new Text(
                          '$heartCount',
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PackIconListView extends StatefulWidget {
  final ScrollController scrollController;
  final AsyncSnapshot snapshot;
  Function() updateIconList;
  PackIconListView ({
    this.snapshot,
    this.scrollController,
    this.updateIconList,
  });

  @override
  _PackIconListViewState createState() => _PackIconListViewState();
}

class _PackIconListViewState extends State<PackIconListView> {

  @override
  Widget build(BuildContext context) {
    return new ListView.builder (
      itemBuilder: (context, index) => new _PackIcon(
        controller: widget.scrollController,
        index: index.toDouble(),
        avatarImagePath: widget.snapshot.data.categoryList[index].avatar,
        isSelected: isPackIconSelected(widget.scrollController.offset, index, widget.snapshot.data.categoryList.length),
        //widget.updateIconList(),
      ),
      itemCount: widget.snapshot.data.categoryList.length,
    );
  }
}


bool isPackIconSelected (double offset, int index, int total) {
  int tmpIndex = (offset / 2351 * total).toInt();
  if (tmpIndex < 0) tmpIndex = 0;
  if (tmpIndex > total - 1) tmpIndex = total - 1;

  if (index == tmpIndex) {
    return true;
  } else {
    return false;
  }
}