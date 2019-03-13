import 'package:flutter/material.dart';

class DescriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: new Column(
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
              ),
              height: 50,
              width: double.infinity,
              child: Center(
                child: new Text(
                  'Pack Details',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                'This is a very long long text. This is a very long long text. This is a very long long text. This is a very long long text. This is a very long long text. This is a very long long text. This is a very long long text. This is a very long long text. This is a very long long text. This is a very long long text.',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

