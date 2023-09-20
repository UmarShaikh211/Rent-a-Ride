import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rentcartest/user/widget.dart';

class HostRating extends StatefulWidget {
  const HostRating({super.key});

  @override
  State<HostRating> createState() => _HostRatingState();
}

class _HostRatingState extends State<HostRating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Rating"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Buggati Chiron AT Petrol",
            style: TextStyle(
                fontSize: 17,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Text("MH02TV2389"),
          SizedBox(
            height: 15,
          ),
          rate(),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Your Rating will be affected if you don't follow thes"
              "e Steps!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "Roboto",
                  fontSize: 15),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("Things to keep in mind before Sharing!"),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 260,
              width: 320,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent),
              child: ListView(children: [
                ListTile(
                  horizontalTitleGap: 0,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Searve Booking Assigned.",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  subtitle: Text(
                    "Always Serve Bookings on Time.",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  trailing: Image.asset(
                    "assets/rolls.png",
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Keep Car at Right Location.",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  subtitle: Text(
                    "Help the Guests to find the Car.",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  trailing: Image.asset(
                    "assets/rolls.png",
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Maintain Driving Condition.",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  subtitle: Text(
                    "Give Guest a Great Experience! ",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  trailing: Image.asset(
                    "assets/rolls.png",
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Keep Car Clean.",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  subtitle: Text(
                    "Clean Car Attract Great Raings :)",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  trailing: Image.asset(
                    "assets/rolls.png",
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
