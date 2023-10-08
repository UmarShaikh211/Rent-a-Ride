import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../main.dart';

class SharedCarDetailAdminScreen extends StatefulWidget {
  final Map<String, dynamic> sharedCarDetails;

  SharedCarDetailAdminScreen(this.sharedCarDetails);

  @override
  _SharedCarDetailAdminScreenState createState() =>
      _SharedCarDetailAdminScreenState();
}

class _SharedCarDetailAdminScreenState
    extends State<SharedCarDetailAdminScreen> {
  Map<String, dynamic> addedCars = {};
  Map<String, dynamic> hostBio = {};
  Map<String, dynamic> cprice = {};
  String hostUsername = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Extract necessary data from widget
    addedCars = widget.sharedCarDetails['added_cars'][0];
    hostBio = widget.sharedCarDetails['host_bio'][0];
    cprice = widget.sharedCarDetails['car_price'][0];

    // Fetch the username based on the user ID
    final userId = hostBio['user'];
    final username = await fetchUsername(userId);

    setState(() {
      hostUsername = username;
    });
  }

  Future<String> fetchUsername(String userId) async {
    final response = await http.get(Uri.parse('$globalapiUrl/users/$userId'));

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      final username = userData['name'];
      return username;
    } else {
      throw Exception('Failed to fetch username');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${addedCars['CarBrand']} ${addedCars['CarModel']}'),
            Text('City: ${addedCars['CarCity']}'),
            Text('License: ${addedCars['License']}'),
            Text('Car Year: ${addedCars['CarYear']}'),
            Text('Car Fuel: ${addedCars['CarFuel']}'),
            Text('Car Transmission: ${addedCars['CarTrans']}'),
            Text('Car Seats: ${addedCars['CarSeat']}'),
            Text('Car Kilometers: ${addedCars['CarKm']}'),
            Text('Car Chassis Number: ${addedCars['CarChassisNo']}'),

            Text('Host Name: $hostUsername'), // Display the fetched username
            Text('Guest Phone Number: ${hostBio['Gphone']}'),

            Text('Rent/Hr: ${cprice['amount']}'),

            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
