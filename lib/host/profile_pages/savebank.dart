import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../user/global.dart';
import 'package:http/http.dart' as http;

class SaveBanlk extends StatefulWidget {
  const SaveBanlk({super.key});

  @override
  State<SaveBanlk> createState() => _SaveBanlkState();
}

class _SaveBanlkState extends State<SaveBanlk> {
  String? userId;
  String an = 'Unknown';
  String ifn = 'Unknown';
  String pn = 'Unknown';

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId;
    fetchBankDetails(userId!);
  }

  Future<void> fetchBankDetails(String userId) async {
    try {
      final response = await http.get(Uri.parse('$globalapiUrl/bank/$userId/'));
      if (response.statusCode == 200) {
        final carData = json.decode(response.body);
        final a = carData['acc_no'];
        final i = carData['ifsc'];
        final p = carData['pan'];

        setState(() {
          an = a ?? 'Unknown'; // Set the carSeats variable
          ifn = i ?? 'Unknown'; // Set the carSeats variable
          pn = p ?? 'Unknown'; // Set the carSeats variable
        });
      } else {
        // Handle error response (e.g., show an error message)
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Account Details"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Column(
                    children: [
                      Text("Account Number:" + an),
                      SizedBox(
                        height: 10,
                      ),
                      Text("IFSC Code: " + ifn),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Pan Card Number:" + pn)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
