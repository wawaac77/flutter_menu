import 'package:flutter/material.dart';
import 'package:flutter_menu/pages/scaffold/zoom_scaffold.dart';
import 'package:flutter_menu/pages/video/chat_screen.dart';
import 'package:flutter_menu/pages/video/video_screen.dart';
import 'package:flutter_menu/pages/web/web_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  AnimationController titleAnimationController;

  @override
  void initState() {
    super.initState();
    titleAnimationController = new AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  void dispose() {
    titleAnimationController.dispose();
    super.dispose();
  }

  createMenuTitle(MenuController menuController) {
    switch (menuController.state) {
      case MenuState.open:
      case MenuState.opening:
        titleAnimationController.forward();
        break;
      case MenuState.closed:
      case MenuState.closing:
        titleAnimationController.reverse();
        break;
    }

    return new AnimatedBuilder(
        animation: titleAnimationController,
        child: OverflowBox(
          maxWidth: double.infinity,
          alignment: Alignment.topLeft,
          child: new Padding(
            padding: const EdgeInsets.all(30.0),
            child: new Text(
              'Menu',
              style: new TextStyle(
                color: const Color(0x88444444),
                fontSize: 240.0,
              ),
              textAlign: TextAlign.left,
              softWrap: false,
            ),
          ),
        ),
        builder: (BuildContext context, Widget child) {
          return new Transform(
            transform: new Matrix4.translationValues(
              250.0 * (1.0 - titleAnimationController.value) - 100,
              0.0,
              0.0,
            ),
            child: child,
          );
        }
    );
  }

  createMenuItems(MenuController menuController) {
    final titles = ['Hot Items', 'Social Pack', 'Music Pack', 'Live & Video', 'Live Chat'];
    final listItems = [];
    final selectedIndex = 0;

    for (var i = 0; i < titles.length; ++i) {
      listItems.add(
          new AnimatedMenuListItem(
          menuListItem: new _MenuListItem(
            title: titles[i],
            isSelected: i == selectedIndex,
            onTap: () {
              menuController.close();
            },
          ),
          menuState: menuController.state,
          duration: const Duration(milliseconds: 250),
          curve: new Interval(0.0, 0.5, curve: Curves.easeOut),
        ),
      );
    }

    return new Transform(
      transform: new Matrix4.translationValues(
        0,
        225.0,
        0,
      ),
      child: new Column(
        children: <Widget>[
          new AnimatedMenuListItem(
            menuListItem: new _MenuListItem(
              title: "Hot Items",
              isSelected: true,
              onTap: () {
                menuController.close();
              },
            ),
            menuState: menuController.state,
            duration: const Duration(milliseconds: 250),
            curve: new Interval(0.0, 0.5, curve: Curves.easeOut),
          ),
          new AnimatedMenuListItem(
            menuListItem: new _MenuListItem(
              title: "Social Pack",
              isSelected: false,
              onTap: () {
                menuController.close();
              },
            ),
            menuState: menuController.state,
            duration: const Duration(milliseconds: 300),
            curve: new Interval(0.1, 0.6, curve: Curves.easeOut),
          ),
          new AnimatedMenuListItem(
            menuListItem: new _MenuListItem(
              title: "Music Pack",
              isSelected: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
                menuController.close();
              },
            ),
            menuState: menuController.state,
            duration: const Duration(milliseconds: 350),
            curve: new Interval(0.2, 0.7, curve: Curves.easeOut),
          ),
          new AnimatedMenuListItem(
            menuListItem: new _MenuListItem(
              title: "Live & Video",
              isSelected: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoScreen()),
                );
                menuController.close();
              },
            ),
            menuState: menuController.state,
            duration: const Duration(milliseconds: 400),
            curve: new Interval(0.3, 0.8, curve: Curves.easeOut),
          ),
          new AnimatedMenuListItem(
            menuListItem: new _MenuListItem(
              title: "Live Chat",
              isSelected: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WebScreen()),
                );
                menuController.close();
              },
            ),
            menuState: menuController.state,
            duration: const Duration(milliseconds: 450),
            curve: new Interval(0.4, 0.9, curve: Curves.easeOut),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffoldMenuController(
      builder: (BuildContext context, MenuController menuController) {
        return new Container(
          width: double.infinity,
          height: double.infinity,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: AssetImage('assets/background_pink_blue.jpg'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  const Color(0xCC000000), BlendMode.darken),
            ),
          ),
          child: new Material(
            color: Colors.transparent,
            child: new Stack(
              children: <Widget>[
                createMenuTitle(menuController),
                createMenuItems(menuController),
              ],
            ),
          ),
        );
      }
    );
  }
}

class AnimatedMenuListItem extends ImplicitlyAnimatedWidget {

  final _MenuListItem menuListItem;
  final MenuState menuState;
  final Duration duration;

  AnimatedMenuListItem ({
    this.menuListItem,
    this.menuState,
    this.duration,
    curve,
  }) : super(duration: duration, curve: curve);

  @override
  _AnimatedMenuListItemState createState() => _AnimatedMenuListItemState();
}

class _AnimatedMenuListItemState extends AnimatedWidgetBaseState<AnimatedMenuListItem> {

  final double closedSlidePosition = 200.0;
  final double openSlidePosition = 0.0;

  Tween<double> _translation;
  Tween<double> _opacity;

  @override
  void forEachTween(visitor) {
    var slide, opacity;
    switch (widget.menuState) {
      case MenuState.closed:
      case MenuState.closing:
        slide = closedSlidePosition;
        opacity = 0.0;
        break;
      case MenuState.open:
      case MenuState.opening:
        slide = openSlidePosition;
        opacity = 1.0;
        break;
    }

    _translation = visitor (
      _translation,
      slide,
          (dynamic value) => new Tween<double>(begin: value),
    );

    _opacity = visitor (
      _opacity,
      opacity,
          (dynamic value ) => new Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Opacity(
      opacity: _opacity.evaluate(animation),
      child: new Transform(
          transform: new Matrix4.translationValues(
            0.0,
            _translation.evaluate(animation),
            0.0,
          ),
        child: widget.menuListItem,
      ),
    );
  }


}


class _MenuListItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;

  _MenuListItem({
    this.title,
    this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: const Color(0x44000000),
      onTap: isSelected
          ? null
          : onTap,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 50, top: 35.0, bottom: 15.0),
          child: new Text(
            title,
            style: new TextStyle(
              color: isSelected? Colors.red : Colors.white,
              fontSize: 22.0,
            ),
          ),
        ),
      ),
    );
  }
}


