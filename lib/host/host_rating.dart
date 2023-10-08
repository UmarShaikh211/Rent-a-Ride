import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/user/widget.dart';
import 'package:rentcartest/user/some.dart' as someApi;

import '../main.dart';
import '../user/global.dart';
import 'package:http/http.dart' as http;

class HostRating extends StatefulWidget {
  const HostRating({super.key});

  @override
  State<HostRating> createState() => _HostRatingState();
}

class _HostRatingState extends State<HostRating> {
  String? selectedCarId = " ";
  String? userId;
  List<Map<String, dynamic>> userCars = [];
  double? totalRating = 0.0;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId;

    if (userId != null) {
      fetchUserCars(userId!);
    }
    if (userCars.isNotEmpty) {
      selectedCarId = userCars[0]['id'].toString();
    }
    fetchTotalRating(selectedCarId!);
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
        print(selectedCarId);
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

  Future<void> fetchTotalRating(String selectedCarId) async {
    final response = await http.get(
      Uri.parse('$globalapiUrl/cars/$selectedCarId/total_rating/'),
    );
    print(response);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response: $data'); // Add this line for debugging
      final total = data['total_rating'] ?? 0.0;
      setState(() {
        totalRating = total.toDouble();
      });
    } else {
      print('API Error: ${response.statusCode} - ${response.body}');
      // Handle error
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
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text("Add Car"),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          fetchTotalRating(selectedCarId!);

                          print("My problem" + selectedCarId!);
                        });
                      },
                      items: userCars.map((car) {
                        final carId = car['id'].toString();
                        final carName = getCarNameById(carId);

                        return DropdownMenuItem<String>(
                            value: carId, child: Text('$carName'));
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Select a car',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 130,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 50, // Adjust the size as needed
                    ),
                    SizedBox(
                        width:
                            8.0), // Add some spacing between the star and rating
                    Text(
                      totalRating!.toStringAsFixed(
                          1), // Format rating to one decimal place
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 290,
                    width: 320,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Colors.deepPurple)),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _buildListItem(
                          title: "Serve Booking Assigned.",
                          subtitle: "Always Serve Bookings on Time.",
                          icon: Icons.schedule,
                        ),
                        _buildListItem(
                          title: "Keep Car at Right Location.",
                          subtitle: "Help the Guests to find the Car.",
                          icon: Icons.location_on,
                        ),
                        _buildListItem(
                          title: "Maintain Driving Condition.",
                          subtitle: "Give Guest a Great Experience!",
                          icon: Icons.directions_car,
                        ),
                        _buildListItem(
                          title: "Keep Car Clean.",
                          subtitle: "Clean Car Attracts Great Ratings :)",
                          icon: Icons.cleaning_services,
                        ),
                      ],
                    ),
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

Widget _buildListItem(
    {required String title, required String subtitle, required IconData icon}) {
  return ListTile(
    horizontalTitleGap: 0,
    titleAlignment: ListTileTitleAlignment.center,
    title: Text(
      title,
      style: TextStyle(
          fontSize: 14, color: Colors.deepPurple, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      subtitle,
      style: TextStyle(fontSize: 11, color: Colors.black),
    ),
    trailing: Icon(
      icon,
      color: Colors.deepPurple,
      size: 30,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
  );
}
