import 'package:flutter/material.dart';
import 'package:rentcartest/host/host_analytics.dart';
import 'package:rentcartest/host/host_booking.dart';
import 'package:rentcartest/host/host_finance.dart';
import 'package:rentcartest/host/host_home.dart';
import 'package:rentcartest/host/host_profile.dart';
import 'package:rentcartest/user/new.dart';

import '../user/widget.dart';

class HostNav extends StatefulWidget {
  HostNav({super.key});

  @override
  _HostNavState createState() => _HostNavState();
}

class _HostNavState extends State<HostNav> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HostHome(),
    Hostbook(),
    HostFin(),
    HostAnl(),
    HostPro(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Icons.calendar_month_sharp,
              color: Colors.orange,
            ),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.money_sharp,
              color: Colors.greenAccent,
            ),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.animation,
              color: Colors.cyanAccent,
            ),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.person,
              color: Colors.pinkAccent,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Rest of the code remains the same
