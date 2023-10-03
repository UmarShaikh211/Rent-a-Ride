import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rentcartest/host/host_navbar.dart';
import 'package:rentcartest/main.dart';

import '../../user/global.dart';

class CarShare3 extends StatefulWidget {
  final int carid;
  final String startdate;
  final String enddate;
  const CarShare3(
      {super.key,
      required this.carid,
      required this.startdate,
      required this.enddate});

  @override
  State<CarShare3> createState() => _CarShare3State();
}

class _CarShare3State extends State<CarShare3> {
  String userId = '';
  @override
  void initState() {
    super.initState();

    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId!;
  }

  Future<void> createCarDate(
      int carId, String sharesDate, String shareeDate) async {
    final apiUrl = '$globalapiUrl/create_car_date/';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'car': carId,
        'sharesdate': sharesDate,
        'shareedate': shareeDate,
      }),
    );

    if (response.statusCode == 201) {
      print('CarDate created successfully');
      // Handle success
    } else {
      print('Failed to create CarDate: ${response.body}');
      // Handle error
    }

    print('Updating isshared for carId: ${widget.carid}');

    // Send a PUT request to update the isshared field
    final response2 = await http.put(
      Uri.parse('$globalapiUrl/car/${widget.carid}/'),
      // Replace apiUrl with your actual API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user': userId,
        'isshared': true, // Set isshared to true
      }),
    );

    print('PUT response status code: ${response2.statusCode}');

    if (response2.statusCode == 200) {
      // Successfully updated isshared
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HostNav(),
        ),
      );
    } else {
      print('Failed to update isshared: ${response2.body}');
      // Handle error here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShareCar"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                createCarDate(widget.carid, widget.startdate, widget.enddate);
              },
              child: Text("Success"))
        ],
      ),
    );
  }
}
