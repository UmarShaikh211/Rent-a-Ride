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
  }

  Future<void> fetchLastCarId(String userId) async {
    try {
      print("Fetching last car ID...");
      lastCarId = await someApi.ApiService.getLastCarId(userId);
      print("Last Car ID fetched: $lastCarId");
      setState(() {});
    } catch (e) {
      print("Error fetching last car ID: $e");
    }
  }

  Future<void> _handleCreateCar(String userId) async {
    try {
      print("Creating a new car...");

      final carId = await someApi.ApiService.createCar(userId);

      print("Car created with ID: $carId");
      setState(() {
        lastCarId = carId;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Car created successfully')),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HostLic(userId),
        ),
        (route) => false,
      );
    } catch (e) {
      print("Error creating car: $e");
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Add New Car"),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Card(
            elevation: 0,
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.monetization_on,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  title: Text(
                    "Earn Extra Income",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                  subtitle: Text(
                    "Make money by renting out your car when you're not using it.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.build,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  title: Text(
                    "Low Maintenance Costs",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                  subtitle: Text(
                    "Cover your car's expenses through rentals.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.schedule,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  title: Text(
                    "Flexible Schedule",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                  subtitle: Text(
                    "Choose when and for how long you want to rent your car.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.security,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  title: Text(
                    "Insurance Coverage",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                  subtitle: Text(
                    "Enjoy peace of mind with insurance protection for renters.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(
                    254, 205, 59, 1.0), // Set the background color
                onPrimary: Colors.black,
                side: BorderSide(color: Colors.deepPurple),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            onPressed: () {
              _handleCreateCar(userId);
            },
            child: Text("ADD CAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.06,
                    fontFamily: 'Times New Roman')),
          )
        ],
      ),
    );
  }
}
