import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {

  @override
  VideoScreenState createState() {
    return new VideoScreenState();
  }
}

class VideoScreenState extends State<VideoScreen> {
  static const platform = const MethodChannel('menu.flutter.io/video');

  VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

//    _controller = VideoPlayerController.network(
//        'http://184.72.239.149/vod/smil:BigBuckBunny.smil/playlist.m3u8')
//      ..initialize().then((_) {
//        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//        setState(() {});
//      });
  }

  Future<void> _setVideoSignedCookie() async {
    String batteryLevel;
    await platform.invokeMethod('setVideoSignedCookie');

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image:new AssetImage('assets/background_constellation_purple.jpg'),
            fit: BoxFit.cover,
          )
      ),
      child: new S
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          title: Text('Club SIM'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              }),
        ),
        body: new Stack(
          children: <Widget>[
            Center(
              child: new Text(
                'Here is a video landing page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            new Positioned(
              bottom: 60,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [new BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                    ),]
                ),
                height: 50,
                child: Center(
                  child: new GestureDetector(
                    onTap: () {
                      _setVideoSignedCookie();
                    },
                    child: new Text(
                      'Go to Live Stream',
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
        )



//      Center(
//        child: _controller.value.initialized ? AspectRatio(
//          aspectRatio: _controller.value.aspectRatio,
//          child: VideoPlayer(_controller),
//        )
//            : Container(),
//      ),
//      floatingActionButton: FloatingActionButton(
//          onPressed: () {
//            setState(() {
//              _controller.value.isPlaying
//                  ? _controller.pause()
//                  : _controller.play();
//            });
//          },
//          child: Icon(
//            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//          ),
//      ),
      ),
    );
  }
}
