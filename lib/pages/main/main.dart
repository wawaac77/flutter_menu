import 'package:flutter/material.dart';
import 'package:flutter_menu/pages/main/menu_screen.dart';
import 'package:flutter_menu/pages/main/other_screen.dart';
import 'package:flutter_menu/pages/pack/pack_screen.dart';
import 'package:flutter_menu/pages/scaffold/zoom_scaffold.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var activeScreen = restaurantScreen;

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffold(
      contentScreen: activeScreen,
      menuScreen: new MenuScreen() ,
    );
  }
}








