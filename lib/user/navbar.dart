import 'package:flutter/material.dart';
import 'package:rentcartest/user/location.dart';
import 'package:rentcartest/user/newprofile.dart';
import 'package:rentcartest/user/notificationtester.dart';
import 'package:rentcartest/user/profile.dart';
import 'package:rentcartest/user/retrievetest.dart';
import 'package:rentcartest/user/test.dart';
import 'package:rentcartest/user/trips.dart';
import 'package:rentcartest/user/widget.dart';

import 'bill.dart';
import 'car_detail.dart';
import 'date.dart';
import 'favourite.dart';
import 'home.dart';

class bottomnav extends StatefulWidget {
  static String routeName = "/bottomnav";

  const bottomnav({
    super.key,
  });

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  int _currentIndex = 0;

  @override
  final List<Widget> _children = [
    Home(),
    Favourite(),
    Trip(),
    NewProfile(),
  ];
  Future<bool> _onWillPop() async {
    // Prevent the back button from popping the current route
    return false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: _children[_currentIndex],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.home,
                color: Colors.blueAccent,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              label: "Favourites",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.money_sharp,
                color: Colors.greenAccent,
              ),
              label: 'Trips',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.person, color: Colors.pink),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
