import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/user/widget.dart';
import 'package:rentcartest/user/some.dart' as someApi;

import '../user/global.dart';

class HostRating extends StatefulWidget {
  const HostRating({super.key});

  @override
  State<HostRating> createState() => _HostRatingState();
}

class _HostRatingState extends State<HostRating> {
  String? selectedCarId = " ";
  String? userId;
  List<Map<String, dynamic>> userCars = [];

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId;

    if (userId != null) {
      fetchUserCars(userId!);
    }
  }

  Future<void> fetchUserCars(String userId) async {
    try {
      print("Fetching user's car objects...");

      if (userId != null) {
        print("User ID: $userId");

        userCars = await someApi.ApiService.getUserCars(userId);

        print("User's car objects fetched: $userCars");

        if (userCars.isNotEmpty) {
          setState(() {
            selectedCarId = userCars[0]['id'].toString();
          });
        }
      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error fetching user's car objects: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: customInputDecorationTheme(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Car Rating"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedCarId,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCarId = newValue;
                          print("My problem" + selectedCarId!);
                        });
                      },
                      items: userCars.map((car) {
                        final carId = car['id'].toString();
                        return DropdownMenuItem<String>(
                          value: carId,
                          child: Text('Car ID: $carId'),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Select a car',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // rate(),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 290,
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
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

InputDecorationTheme customInputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // Customize the border radius as needed
    borderSide: BorderSide(
        color: Colors.deepPurple), // Customize the border color as needed
    gapPadding: 5,
  );
  return InputDecorationTheme(
    floatingLabelBehavior:
        FloatingLabelBehavior.auto, // Customize the label behavior if needed
    contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10), // Customize the content padding if needed
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
