import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_menu/model/category_result_model.dart';
import 'package:flutter_menu/view/description_view.dart';
import 'package:flutter_menu/view/price_view.dart';

class DetailScreen extends StatelessWidget {

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
      body: new Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(40, 40, 40, 1),
        ),
        height: double.infinity,
        child: new Stack(
          children: <Widget>[
            new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return new Column(
                    children: <Widget>[
                      new PriceView(),
                      new DescriptionView(),
                    ],
                  );
                };
              },
            ),
            new Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [new BoxShadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                  ),]
                ),
                height: 80,
                padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: new Text(
                      'Buy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
