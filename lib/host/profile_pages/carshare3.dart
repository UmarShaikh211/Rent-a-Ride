import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
    DateTime sd = DateTime.parse(widget.startdate);
    DateTime ed = DateTime.parse(widget.enddate);

    return Scaffold(
      appBar: AppBar(
        title: Text("ShareCar"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: 100,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                    child: Text(
                      "Your Car will be added to the Marketplace from " +
                          DateFormat('EEEE, d-MMMM-yyyy').format(sd) +
                          " to " +
                          DateFormat('EEEE, d-MMMM-yyyy').format(ed) +
                          ".",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.deepPurple)),
              onPressed: () {
                createCarDate(widget.carid, widget.startdate, widget.enddate);
              },
              child: Text(
                "SUBMIT",
              ))
        ],
      ),
    );
  }
}
