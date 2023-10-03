import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/host/addncar.dart';
import 'package:rentcartest/host/faq.dart';
import 'package:rentcartest/host/host_bio.dart';
import 'package:rentcartest/host/host_features.dart';
import 'package:rentcartest/host/host_license.dart';
import 'package:rentcartest/host/host_navbar.dart';
import 'package:rentcartest/host/hpolicy.dart';
import 'package:rentcartest/host/profile_pages/pricing.dart';
import 'package:rentcartest/user/navbar.dart';
import 'package:rentcartest/user/some.dart' as someApi;
import 'package:rentcartest/user/new.dart';

import '../main.dart';
import '../user/global.dart';
import 'host_analytics.dart';
import 'host_home.dart';
import 'host_image.dart';
import 'package:http/http.dart' as http;

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
        onTap: () {
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CarAdd()),
            (route) => false,
          );
        },
        child: Row(
          children: [
            Icon(Icons.directions_car_filled_sharp),
            SizedBox(
              width: 20,
            ),
            Text("Add a Car")
          ],
        ),
      ),
    ),
    DrawerItem(
      widget: InkWell(
        onTap: () {
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => Hostimg()),
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
            MaterialPageRoute(builder: (context) => HostBio()),
          );
        },
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 20,
            ),
            Text("Add Host Bio")
          ],
        ),
      ),
    ),
    DrawerItem(
      widget: InkWell(
        onTap: () {
          navigatorKey.currentState?.push(
            MaterialPageRoute(
                builder: (context) => Pricing(
                      arguments: {},
                    )),
          );
        },
        child: Row(
          children: [
            Icon(Icons.money_sharp),
            SizedBox(
              width: 20,
            ),
            Text("Set Car Price")
          ],
        ),
      ),
    ),
    DrawerItem(
        widget: Divider(
      thickness: 2,
    )),
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
        onTap: () {
          navigatorKey.currentState
              ?.push(MaterialPageRoute(builder: (context) => FAQPage()));
        },
        child: Row(
          children: [
            Icon(Icons.question_mark_outlined),
            SizedBox(
              width: 20,
            ),
            Text("FAQ")
          ],
        ),
      ),
    ),
    DrawerItem(
      widget: InkWell(
        onTap: () {
          navigatorKey.currentState
              ?.push(MaterialPageRoute(builder: (context) => HostPolicy()));
        },
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

class drawertop extends StatefulWidget {
  const drawertop({
    super.key,
  });

  @override
  State<drawertop> createState() => _drawertopState();
}

class _drawertopState extends State<drawertop> {
  String? userId;
  String uname = 'Unknown';
  String uemail = 'Unknown';
  String uphone = 'Unknown';

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId;
    fetchUserDetails(userId!);
  }

  Future<void> fetchUserDetails(String userId) async {
    try {
      final response =
          await http.get(Uri.parse('$globalapiUrl/users/$userId/'));
      if (response.statusCode == 200) {
        final carData = json.decode(response.body);
        final a = carData['name'];
        final i = carData['email'];
        final p = carData['phone'];

        setState(() {
          uname = a ?? 'Unknown'; // Set the carSeats variable
          uemail = i ?? 'Unknown'; // Set the carSeats variable
          uphone = p ?? 'Unknown'; // Set the carSeats variable
        });
      } else {
        // Handle error response (e.g., show an error message)
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

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
                          uname,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.cyanAccent,
                              fontSize: 17),
                        ),
                        Text(
                          uemail,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          uphone,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ])));
  }
}
