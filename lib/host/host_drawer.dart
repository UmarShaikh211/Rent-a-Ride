import 'package:flutter/material.dart';
import 'package:rentcartest/host/addncar.dart';
import 'package:rentcartest/host/host_features.dart';
import 'package:rentcartest/host/host_license.dart';
import 'package:rentcartest/host/host_navbar.dart';
import 'package:rentcartest/user/navbar.dart';
import 'package:rentcartest/user/some.dart' as someApi;
import 'package:rentcartest/user/new.dart';

import '../main.dart';
import 'host_analytics.dart';
import 'host_home.dart';
import 'host_image.dart';

class HostDraw extends StatefulWidget {
  const HostDraw({super.key});

  @override
  State<HostDraw> createState() => _HostDrawState();
}

class _HostDrawState extends State<HostDraw> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<DrawerItem> _options = [
    DrawerItem(
      widget: InkWell(
        child: Row(
          children: [
            Icon(Icons.access_time_outlined),
            SizedBox(
              width: 20,
            ),
            Text("Your Listings")
          ],
        ),
      ),
    ),
    DrawerItem(
      widget: InkWell(
        onTap: () {
          navigatorKey.currentState?.push(
            MaterialPageRoute(
                builder: (context) => Hostimg(
                      arguments: {},
                    )),
          );
        },
        child: Row(
          children: [
            Icon(Icons.camera_alt_outlined),
            SizedBox(
              width: 20,
            ),
            Text("Upload Your Car Images")
          ],
        ),
      ),
    ),
    DrawerItem(
      widget: InkWell(
        onTap: () {
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => HostHome()),
          );
        },
        child: Row(
          children: [
            Icon(Icons.car_crash_outlined),
            SizedBox(
              width: 20,
            ),
            Text("Add Car Features")
          ],
        ),
      ),
    ),
    DrawerItem(
      widget: InkWell(
        onTap: () {
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => CarAdd()),
          );
        },
        child: Row(
          children: [
            Icon(Icons.directions_car_filled_sharp),
            SizedBox(
              width: 20,
            ),
            Text("Add another Car")
          ],
        ),
      ),
    ),
    DrawerItem(widget: Divider()),
    DrawerItem(
      widget: InkWell(
        child: Row(
          children: [
            Icon(Icons.message_outlined),
            SizedBox(
              width: 20,
            ),
            Text("Help & Support")
          ],
        ),
      ),
    ),
    DrawerItem(
      widget: InkWell(
        child: Row(
          children: [
            Icon(Icons.question_mark_outlined),
            SizedBox(
              width: 20,
            ),
            Text("Frequently Asked Questions")
          ],
        ),
      ),
    ),
    DrawerItem(
      widget: InkWell(
        child: Row(
          children: [
            Icon(Icons.book_outlined),
            SizedBox(
              width: 20,
            ),
            Text("Policies")
          ],
        ),
      ),
    ),
    DrawerItem(
      widget: InkWell(
        onTap: () {
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => bottomnav()),
          );
        },
        child: Row(
          children: [
            Icon(
              Icons.exit_to_app_outlined,
              color: Colors.red,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    ),

    // Add more items as needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView.builder(
          itemCount: _options.length + 1,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            if (index == 0) {
              return drawertop();
            } else {
              final optionIndex = index - 1;
              return ListTile(
                title: _options[optionIndex].widget,
                selected: _selectedIndex == optionIndex,
                onTap: () {
                  _onItemTapped(optionIndex);
                  Navigator.pop(context);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DrawerItem {
  final Widget widget;

  DrawerItem({required this.widget});
}

class drawertop extends StatelessWidget {
  const drawertop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        decoration: BoxDecoration(
            gradient: SweepGradient(
          colors: <Color>[
            Color(0xFF000000), // blue
            Color(0xFF0608E7), // green
            Color(0xFF2500B2), // yellow
            Color(0xFFF400FF), // red
            Color(
                0xFF000A65), // blue again to seamlessly transition to the start
          ],
        )),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            height: 105,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/Profile Image.png"),
                    radius: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Umar Shaikh",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.cyanAccent,
                              fontSize: 17),
                        ),
                        Text(
                          "xyz@gmail.com",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "9833427514",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ])));
  }
}
