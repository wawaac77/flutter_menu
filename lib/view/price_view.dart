import 'package:flutter/material.dart';
import 'package:flutter_menu/model/category_result_model.dart';

class PriceView extends StatelessWidget {
  final ResultModel packResult;
  PriceView ({
    this.packResult,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(Radius.circular(10)),
        ),
        child: new Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              decoration: new BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),),
              ),
              child: Center(
                child: new Text(
                  'PUBG MOBILE',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            new Image.asset(
              'assets/Globe-flamant-rose-DIY.jpg',
              fit: BoxFit.cover,
              height: 150.0,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new Text(
                      "28",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new Text(
                      'ClubPoint',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  new Text(
                    '140',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: new Text(
                'Buy / Extend for SIM 1234567',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: new Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: new Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
