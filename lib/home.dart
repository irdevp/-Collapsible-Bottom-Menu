import 'package:CollapsibleBottomMenu/Curves.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart' as BottomNavigationBarOverride;

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool showBottomMenu = false;
  bool showIconMenu = false;
  static List<Widget> _widgetOptions = <Widget>[
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.green,
    )
  ];
  //Animation
  AnimationController _menuController;
  Animation<double> menuAnimation;
  bool forwardAnimation = false;
  AnimationController _controller;
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _menuController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    menuAnimation = Tween<double>(begin: 400, end: 70).animate(_menuController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            forwardAnimation = true;
          });
        } else {
          setState(() {
            forwardAnimation = false;
          });
        }
      });
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _menuController.forward();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _widgetOptions.elementAt(_selectedIndex),
            AnimatedContainer(
              duration: Duration(milliseconds: 120),
              alignment: forwardAnimation
                  ? Alignment.bottomRight
                  : Alignment.bottomCenter,
              onEnd: () {
                if (forwardAnimation) {
                  setState(() {
                    showIconMenu = true;
                    _controller.forward();
                  });
                }
              },
              child: Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8, horizontal: showIconMenu ? 0 : 10),
                      child: Container(
                          height: 70.0,
                          width: menuAnimation.value,
                          decoration: BoxDecoration(
                            color: Color(0xff373335),
                            borderRadius: BorderRadius.circular(45),
                            boxShadow: !showIconMenu
                                ? [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 8,
                                        offset: Offset(2.0, 3.0),
                                        spreadRadius: 0.6)
                                  ]
                                : [],
                          ),
                          child: ClipRRect(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: BorderRadius.circular(45),
                              child: menuAnimation.value < 370
                                  ? Material(
                                      color: Color(0xff373335),
                                      child: InkWell(
                                        onTap: () {
                                          _menuController.reverse();
                                          _controller.reverse();
                                          setState(() {
                                            showIconMenu = false;
                                          });
                                        },
                                        child: showIconMenu
                                            ? RotationTransition(
                                                turns:
                                                    Tween(begin: 0.0, end: 0.5)
                                                        .animate(_controller),
                                                child: Icon(
                                                  Icons.menu,
                                                  color: Colors.white,
                                                ))
                                            : null,
                                      ))
                                  : BottomNavigationBarOverride
                                      .BottomNavigationBar(
                                      backgroundColor: Color(0xff373335),
                                      elevation: 0,
                                      type: BottomNavigationBarOverride
                                          .BottomNavigationBarType.fixed,
                                      showUnselectedLabels: false,
                                      showSelectedLabels: false,
                                      onTap: _onItemTapped,
                                      currentIndex: _selectedIndex,
                                      unselectedItemColor: Color(0xffa9a6a8),
                                      items: <BottomNavigationBarItem>[
                                        BottomNavigationBarItem(
                                          icon: Icon(
                                            Icons.account_balance_wallet,
                                          ),
                                          activeIcon: Container(
                                            width: 120,
                                            height: 120,
                                            child: Ink(
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFFffbf1b),
                                                shape: CircleBorder(),
                                              ),
                                              child: Icon(
                                                Icons.account_balance_wallet,
                                                color: Color(0xff373335),
                                              ),
                                            ),
                                          ),
                                          title: Text('1'),
                                        ),
                                        BottomNavigationBarItem(
                                          activeIcon: Container(
                                            width: 120,
                                            height: 120,
                                            child: Ink(
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFFffbf1b),
                                                shape: CircleBorder(),
                                              ),
                                              child: Icon(
                                                Icons.compare_arrows,
                                                color: Color(0xff373335),
                                              ),
                                            ),
                                          ),
                                          icon: Icon(
                                            Icons.compare_arrows,
                                          ),
                                          title: Text('3'),
                                        ),
                                        BottomNavigationBarItem(
                                          activeIcon: Container(
                                            width: 120,
                                            height: 120,
                                            child: Ink(
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFFffbf1b),
                                                shape: CircleBorder(),
                                              ),
                                              child: Icon(
                                                Icons.monetization_on,
                                                color: Color(0xff373335),
                                                size: 27,
                                              ),
                                            ),
                                          ),
                                          icon: Icon(
                                            Icons.monetization_on,
                                          ),
                                          title: Text('3'),
                                        ),
                                        BottomNavigationBarItem(
                                          icon: Icon(Icons.border_all),
                                          activeIcon: Ink(
                                            decoration: const ShapeDecoration(
                                              color: Color(0xFFFffbf1b),
                                              shape: CircleBorder(),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Icon(
                                                Icons.border_all,
                                                size: 17,
                                                color: Color(0xff373335),
                                              ),
                                            ),
                                          ),
                                          title: Text('News'),
                                        ),
                                      ],
                                    )))),
                  Positioned(
                      right: 25,
                      bottom: 95,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        child: showIconMenu
                            ? CustomPaint(
                                painter: ShapesPainter(),
                              )
                            : SizedBox(),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
