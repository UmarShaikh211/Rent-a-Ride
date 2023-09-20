import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rentcartest/user/navbar.dart';
import 'package:rentcartest/user/some.dart';

import 'global.dart'; // Import your ApiService

class UserRegistrationPage extends StatefulWidget {
  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Registration')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name')),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final name = nameController.text;
                  final email = emailController.text;
                  final phone = phoneController.text;

                  final userExists =
                      await ApiService.doesUserExist(name, email, phone);

                  if (userExists) {
                    // User already exists, navigate to car creation page
                    final user = await ApiService.getUserByNameEmailPhone(
                        name, email, phone);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => bottomnav(),
                        ));
                    // Navigator.pushNamed(context, '/ccreate',
                    //     arguments: user['id']);

                    final userProvider =
                        Provider.of<UserDataProvider>(context, listen: false);
                    userProvider.setUserId(user['id']); //addede this extra

                    // userData.setUserId(user['id']); // Set the user ID
                    // Navigator.pushNamed(context, '/ccreate');
                  } else {
                    // User does not exist, create a new user
                    await ApiService.createUser(name, email, phone);

                    // After user is created, navigate to car creation page
                    final newUser = await ApiService.getUserByNameEmailPhone(
                        name, email, phone);
                    // Navigator.pushNamed(context, '/ccreate',
                    //     arguments: newUser['id']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => bottomnav(),
                        ));

                    final userProvider =
                        Provider.of<UserDataProvider>(context, listen: false);
                    userProvider.setUserId(newUser['id']);
                    // userData.setUserId(newUser['id']); // Set the user ID
                    // Navigator.pushNamed(context, '/ccreate');
                  }
                } catch (e) {
                  // Show error message or handle errors
                }
              },
              child: Text('Register User'),
            ),
          ],
        ),
      ),
    );
  }
}
//Change ip ADDRESS
