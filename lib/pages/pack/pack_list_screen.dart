import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_menu/pages/pack/detail_screen.dart';
import 'package:flutter_menu/model/category_detail_model.dart';
import 'package:http/http.dart' as http;



class PackListScreen extends StatelessWidget {
  final Future<PackDetailModel> result = getPackDetail();

  createPackCard(String packName, String imgUrl, BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen()),
        );
      },
      child: new Card(
        child: new Column(
          children: <Widget>[
            new Image.network(
              'http://www.clubsim.com.hk/clsmw/images/iphone/pubg_banner_e.png',
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              child: new Text(
                'Pack Name',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Club SIM'),
          backgroundColor: Colors.black,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              }),
        ),
        body: new ListView.builder(
          itemBuilder: (context, index) => createPackCard('', '', context),
          itemCount: 3,
        ),


//        new FutureBuilder<PackDetailModel>(
//          future: result,
//          builder: (context, snapshot) {
//            if (snapshot.hasData) {
//              new ListView.builder(
//                itemBuilder: (context, index) => createPackCard('', '', context),
//                itemCount: 3,
//              );
//            } else if (snapshot.hasError) {
//              return new Text(
//                'error',
//                style: TextStyle(
//                  color: Colors.white,
//                  fontSize: 16,
//                ),
//              );
//            }
//            return CircularProgressIndicator();
//          },
//        ),
    );
  }
}

Future<PackDetailModel> getPackDetail() async {
  var queryParam = {
    'action': '230',
    'platform': ('ios'),
    'lang': 'eng',
    'cat': 'game',
    'link': 'true',
  };

  Uri url = Uri.https('uat.clubsim.com.hk', 'clsmw/api', queryParam);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return PackDetailModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
