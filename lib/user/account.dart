import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

import '../main.dart';
import 'global.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? userId;
  String uname = 'Unknown';
  String uemail = 'Unknown';
  String uphone = 'Unknown';
  bool isLoading = true; // Add a loading indicator

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId;
    fetchUserDetails(userId!);
  }

  Future<void> fetchUserDetails(String userId) async {
    try {
      final response =
          await http.get(Uri.parse('$globalapiUrl/users/$userId/'));
      if (response.statusCode == 200) {
        final carData = json.decode(response.body);
        final a = carData['name'];
        final i = carData['email'];
        final p = carData['phone'];

        setState(() {
          uname = a ?? 'Unknown';
          uemail = i ?? 'Unknown';
          uphone = p ?? 'Unknown';
          isLoading = false; // Data has loaded, set loading to false
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
        isLoading = false; // Handle error and set loading to false
      }
    } catch (e) {
      print('Error: $e');
      isLoading = false; // Handle network error and set loading to false
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("My Account"),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 250,
            child: isLoading // Check if data is loading
                ? ShimmerLoading() // Display shimmer while loading
                : UserDataWidget(), // Display user data when loaded
          ),
        ),
      ),
    );
  }

  Widget ShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 200,
            color: Colors.white,
          ),
          SizedBox(height: 16),
          Container(
            height: 20,
            width: 150,
            color: Colors.white,
          ),
          SizedBox(height: 16),
          Container(
            height: 20,
            width: 180,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget UserDataWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'User Name:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            uname,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Email:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            uemail,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Phone Number:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            uphone,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
