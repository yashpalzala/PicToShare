// this is a bootm navigation widget , the naviation is just UI Concept 
//NOT IMPLEMENTED YET
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
/*   final List _children = [
    DashBoardPage(),
  ]; */

  onTapped(index) {
    setState(
      () {
        _currentIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Explore'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
      ],
      onTap: onTapped,
    );
  }
}
