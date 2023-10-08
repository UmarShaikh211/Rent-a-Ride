import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/user/some.dart' as someApi;

import '../../main.dart';
import '../../user/global.dart';
import 'package:http/http.dart' as http;

class HostLocation extends StatefulWidget {
  const HostLocation({Key? key}) : super(key: key);

  @override
  State<HostLocation> createState() => _HostLocationState();
}

class _HostLocationState extends State<HostLocation> {
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    final userId = userProvider.userId;

    if (userId != null) {
      fetchUserCars(userId);
    }
  }

  List<Map<String, dynamic>> userCars = []; // List to store user's car objects
  String? selectedCarId; // ID of the selected car object

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

  String getCarNameById(String carId) {
    final car = userCars.firstWhere(
      (car) => car['id'].toString() == carId,
      orElse: () => {},
    );

    if (car != null) {
      final addedCars = car['added_cars'] as List<dynamic>;
      if (addedCars.isNotEmpty) {
        final carBrand = addedCars[0]['CarBrand'];
        final carModel = addedCars[0]['CarModel'];

        if (carBrand != null && carModel != null) {
          return '$carBrand $carModel';
        }
      }
    }

    return 'Unknown Car';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Host Location'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    final carName = getCarNameById(carId);

                    return DropdownMenuItem<String>(
                      value: carId,
                      child: Text('$carName'),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select a car',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: latitudeController,
              decoration: InputDecoration(labelText: 'Latitude'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: longitudeController,
              decoration: InputDecoration(labelText: 'Longitude'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // Handle the submission of latitude, longitude, and address here
                String latitude = latitudeController.text;
                String longitude = longitudeController.text;
                String address1 = addressController.text;

                final response = await http.post(
                  Uri.parse(
                      '$globalapiUrl/location/'), // Replace with your Django backend URL
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(
                    <String, dynamic>{
                      'car': selectedCarId,
                      'lat': latitude,
                      'long': longitude,
                      'address': address1
                    },
                  ),
                );

                if (response.statusCode == 201) {
                  print('Success: ${response.body}');
                } else {
                  print('Error ${response.statusCode}: ${response.body}');
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    latitudeController.dispose();
    longitudeController.dispose();
    addressController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: HostLocation(),
  ));
}
