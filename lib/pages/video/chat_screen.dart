import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> chatList = [];
  final TextEditingController textController = new TextEditingController();
  final ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage('assets/background_pink_blue.jpg'),
            fit: BoxFit.cover,
//            colorFilter: new ColorFilter.mode(
//                const Color(0xCC000000), BlendMode.darken),
          ),
        ),
        child: new Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 400, right: 100),
                  child: new Container(
                    height: 300,
                    child: new ListView.builder(
                        controller: scrollController,
                        itemCount: chatList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new ChatTextCard(chatText: chatList[index]);
                        }
                    ),
                  ),
                ),
                new Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: new TextField(
                    controller: textController,
                    onSubmitted: (text) {
                      chatList.add(text);
                      textController.clear();
                      setState(() {
                        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatTextCard extends StatelessWidget {
  final String chatText;
  ChatTextCard ({
    this.chatText,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                chatText,
                style: TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

