import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/user/some.dart' as someApi;

import '../user/global.dart';

class ShareCar extends StatefulWidget {
  const ShareCar({super.key});

  @override
  State<ShareCar> createState() => _ShareCarState();
}

class _ShareCarState extends State<ShareCar> {
  List<Map<String, dynamic>> userCars = []; // List to store user's car objects
  String? selectedCarId; // ID of the selected car object

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
          selectedCarId = userCars[0]['id'].toString();
          print("Selected car ID set: $selectedCarId");
        }

        setState(() {});
      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error fetching user's car objects: $e");
    }
  }

  // Function to update isshared
  Future<void> updateIsShared() async {
    try {
      if (selectedCarId != null) {
        print("Updating isshared for car ID: $selectedCarId");
        // Call your API or service to update the isshared field for the selected car
        await someApi.ApiService.updateIsShared(selectedCarId!, true);

        print("isshared updated successfully.");
      } else {
        print("Selected car ID is null.");
      }
    } catch (e) {
      print("Error updating isshared: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Car"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 320,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: DropdownButtonFormField<String>(
                value: selectedCarId, // Use selectedCarId here
                onChanged: (newValue) {
                  setState(() {
                    selectedCarId = newValue;
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
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                updateIsShared();
              },
              child: Text("Confirm"))
        ],
      ),
    );
  }
}
