import 'package:flutter/material.dart';
import 'package:flutter_menu/pages/scaffold/zoom_scaffold.dart';

final otherScreen = new Screen(
    title: "Other Screen",
    background: new DecorationImage (
      image: new AssetImage('assets/background_constellation_purple.jpg'),
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(const Color(0xCC000000), BlendMode.darken),
    ),
    contentBuilder: (BuildContext context) {
      return new Center(
        child: new Container(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: new Card(
              child: new Column(
                children: <Widget>[
                  new Image.asset(
                    'assets/skateboard_mutiple.jpg',
                    fit: BoxFit.contain,
                  ),
                  new Expanded(
                      child: new Center(
                        child: new Text('This is another screen'),
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
);