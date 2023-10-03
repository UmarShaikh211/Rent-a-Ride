import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rentcartest/host/host_navbar.dart';
import '../../../main.dart';
import '../user/global.dart';

class HostLogin extends StatefulWidget {
  @override
  _HostLoginState createState() => _HostLoginState();
}

class _HostLoginState extends State<HostLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String userId = "";
  static Future login(String name, String password) async {
    final response = await http.get(
      Uri.parse('$globalapiUrl/users/?name=$name'),
    );

    if (response.statusCode == 200) {
      final users = jsonDecode(response.body);
      if (users is List && users.isNotEmpty) {
        for (final user in users) {
          // Check if the provided username matches the user's username
          if (user['name'] == name) {
            // Check if the provided password matches the user's password
            if (user['password'] == password) {
              return user['id']; // Return the user's ID
            }
          }
        }
      }
    }
    return () {}; // Return null if login fails
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                var name = usernameController.text;
                var password = passwordController.text;
                // Inside your onPressed callback:
                final loggedInUserId = await login(name, password);
                if (loggedInUserId != null) {
                  // Login successful, set the userId and navigate to the desired page
                  setState(() {
                    userId = loggedInUserId;
                  });
                  print('Login Successful');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HostNav(),
                    ),
                  );
                  final userProvider =
                      Provider.of<UserDataProvider>(context, listen: false);
                  userProvider.setUserId(userId);
                  print(userId);
                } else {
                  // Login failed, show an error message
                  print('Login Failed: Invalid username or password');
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
