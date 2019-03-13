import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebScreen extends StatelessWidget {
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
        body: new WebviewScaffold(
          url: "https://uat.clubsim.com.hk/clsmw/api/?action=300&platform=ios&lang=eng&sid=eyJraWQiOiI4MDU4NDY0NjcxIiwidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJleHAiOjE1NTYwODY3OTh9.9as-vtCCsvyHig9SI7ZHatChQyPBix5of2kEfdEwrgE&mrt=93219170&name=ClubSIM%20BPU&module=CLUBSIM_APP_HOME&utm_source=clubsim.ios&utm_medium=app&utm_campaign=clubsim.app",
          initialChild: Container(
            color: Colors.redAccent,
            child: const Center(
              child: Text('Waiting.....'),
            ),
          ),
        ),
    );
  }
}
