import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentcartest/Admin/sharedcar_admin.dart';
import 'dart:convert';

import '../main.dart';
import 'Bank_admin.dart';
import 'Bookings_admin.dart';
import 'Cars_admin.dart';
import 'Host_admin.dart';
import 'Users_admin.dart';
import 'income_admin.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int numberOfUsers = 0;
  int numberOfCars = 0;
  int numberOfTrips = 0;
  int numberOfIncome = 0;
  int numberOfSharedCars = 0;
  int numberOfHost = 0;
  int numberOfBank = 0;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('$globalapiUrl/statistics/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        numberOfUsers = data['numberOfUsers'];
        numberOfCars = data['numberOfCars'];
        numberOfTrips = data['numberOfTrips'];
        numberOfIncome = data['numberOfIncome'];
        numberOfSharedCars = data['numberOfSharedCars'];
        numberOfHost = data['numberOfHost'];
        numberOfBank = data['numberOfBank'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserListScreen(),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text('No of Users'),
                  subtitle: Text('$numberOfUsers'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCarListScreen(),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text('No of Cars'),
                  subtitle: Text('$numberOfCars'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripListScreen(),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text('No of Bookings'),
                  subtitle: Text('$numberOfTrips'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncomeListScreen(),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text('No of Payments'),
                  subtitle: Text('$numberOfIncome'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SharedCarsListScreen(),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text('No of Cars Shared'),
                  subtitle: Text('$numberOfSharedCars'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HostListScreen(),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text('No of Hosts'),
                  subtitle: Text('$numberOfHost'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BankListScreen(),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text('No of Bank Accounts'),
                  subtitle: Text('$numberOfBank'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminDashboard(),
  ));
}
