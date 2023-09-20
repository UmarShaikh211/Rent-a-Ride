import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/user/some.dart' as someApi;

import '../../user/global.dart';
import '../../user/some.dart';

class SetupMessage extends StatefulWidget {
  SetupMessage({super.key});

  @override
  State<SetupMessage> createState() => _SetupMessageState();
}

class _SetupMessageState extends State<SetupMessage> {
  List<Map<String, dynamic>> userCars = []; // List to store user's car objects

  String? carId; // ID of the selected car object

  @override
  void initState() {
    super.initState();

    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    final userId = userProvider.userId;

    if (userId != null) {
      fetchUserCars(userId);
    }
  }

  // Inside your _HostAnlState class
  Future<void> fetchUserCars(String userId) async {
    try {
      print("Fetching user's car objects...");

      if (userId != null) {
        print("User ID: $userId");

        userCars = await someApi.ApiService.getUserCars(userId);

        print("User's car objects fetched: $userCars");

        if (userCars.isNotEmpty) {
          carId = userCars[0]['id'].toString();
          print("Selected car ID set: $carId");
        }

        setState(() {});
      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error fetching user's car objects: $e");
    }
  }

  TextEditingController _greet = TextEditingController();
  TextEditingController _expectuser = TextEditingController();
  TextEditingController _expecthost = TextEditingController();
  TextEditingController _lastmile = TextEditingController();
  TextEditingController _fast = TextEditingController();

  String? _greethint =
      "Hi I am John I am 23 years old.Welcome Use my Car.Its very good. ";

  String? _expectuserhint =
      "Talk about your Car and any specific details you want to mention.";
  String? _expecthosthint = "Request you take note on this guidelines:\n"
      "1. Car will have 30% fuel at booking start,please return it at same fuel level\n"
      "2. No Smoking inside the Car.\n"
      "3. Do not over-speed.";
  String? _lastmilehint =
      "Give instructions to the quest on how to exactly reach your Car.Be as specific as possible.";
  String? _fasthint =
      "The Car already has a fastag installed for your Conveniencce,reach for out for details required to recharge it.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setup Welcome Message"),
        backgroundColor: Colors.teal,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: customInputDecorationTheme(),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "You can Modify yor welcome message for the "
                      "guests,customised for each car.",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextField(
                          style: TextStyle(fontSize: 12),
                          controller: _greet,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: "Greetings",
                            border: OutlineInputBorder(),
                            hintText: _greethint,
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 12),
                          controller: _expectuser,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                              label: Text(
                                "What do the Guest Expect",
                                style: TextStyle(fontSize: 15),
                              ),
                              border: OutlineInputBorder(),
                              hintText: _expectuserhint,
                              hintStyle: TextStyle(fontSize: 12),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 12),
                          controller: _expecthost,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(
                              label: Text(
                                "What do the Host Expect",
                                style: TextStyle(fontSize: 15),
                              ),
                              border: OutlineInputBorder(),
                              hintText: _expecthosthint,
                              hintStyle: TextStyle(fontSize: 12),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 12),
                          controller: _lastmile,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                              label: Text(
                                "Last Mile Direction",
                                style: TextStyle(fontSize: 15),
                              ),
                              border: OutlineInputBorder(),
                              hintText: _lastmilehint,
                              hintStyle: TextStyle(fontSize: 12),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 12),
                          controller: _fast,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                              label: Text(
                                "FastTag & Fuel",
                                style: TextStyle(fontSize: 15),
                              ),
                              border: OutlineInputBorder(),
                              hintText: _fasthint,
                              hintStyle: TextStyle(fontSize: 12),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomAppBar(
              child: Card(
                child: Container(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final notification1 = _greet.text;
                        final notification2 = _expectuser.text;
                        final notification3 = _expecthost.text;
                        final notification4 = _lastmile.text;
                        final notification5 = _fast.text;

                        // You can similarly get other notification values from controllers

                        await ApiService.createNotification(
                            carId!,
                            notification1,
                            notification2,
                            notification3,
                            notification4,
                            notification5
                            // Add other notifications
                            );

                        // Show success message or navigate to next page
                      } catch (e) {
                        // Show error message or handle errors
                      }
                    },
                    child: Text('Save'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

InputDecorationTheme customInputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius:
        BorderRadius.circular(2), // Customize the border radius as needed
    borderSide: BorderSide(
        color: Colors.blueAccent), // Customize the border color as needed
    gapPadding: 0,
  );
  return InputDecorationTheme(
    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    floatingLabelBehavior:
        FloatingLabelBehavior.always, // Customize the label behavior if needed
    contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20), // Customize the content padding if needed
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
