import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/host/host_license.dart';
import 'package:rentcartest/host/host_navbar.dart';
import 'package:rentcartest/user/some.dart' as someApi;
import 'package:rentcartest/user/new.dart';

import '../user/global.dart';

class CarAdd extends StatefulWidget {
  CarAdd({super.key});

  @override
  State<CarAdd> createState() => _CarAddState();
}

class _CarAddState extends State<CarAdd> {
  String? lastCarId;
  late String userId;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId!;

    if (userId != null) {
      fetchLastCarId(userId);
    }
    // Fetch lastCarId if user is pre-existing
  }

  Future<void> fetchLastCarId(String userId) async {
    try {
      print("Fetching last car ID...");
      lastCarId = await someApi.ApiService.getLastCarId(userId);
      print("Last Car ID fetched: $lastCarId");
      setState(() {}); // Rebuild the UI to show the lastCarId
    } catch (e) {
      print("Error fetching last car ID: $e");
      // Handle errors when fetching the last car ID
    }
  }

  Future<void> _handleCreateCar(String userId) async {
    try {
      print("Creating a new car...");

      final carId =
          await someApi.ApiService.createCar(userId); // Create a shared car

      print("Car created with ID: $carId");
      setState(() {
        lastCarId = carId;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HostNav())); //HostLic(userId)

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Car created successfully')),
      );
    } catch (e) {
      print("Error creating car: $e");
      // Show error message or handle errors
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Car"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Card(
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.ac_unit_outlined,
                    ),
                    title: Text("You will Become Rich"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.ac_unit_outlined,
                    ),
                    title: Text("You will Become Rich"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.ac_unit_outlined,
                    ),
                    title: Text("You will Become Rich"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.ac_unit_outlined,
                    ),
                    title: Text("You will Become Rich"),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                _handleCreateCar(userId);
              },
              child: Text("Add Car"))
        ],
      ),
    );
  }
}
