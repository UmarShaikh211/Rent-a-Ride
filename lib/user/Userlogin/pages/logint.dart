import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../main.dart';
import '../../navbar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static Future<bool> login(String name, String password) async {
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
              return true; // User with provided credentials exists and password matches
            }
          }
        }
      }
    }
    return false; // User with provided credentials does not exist or password is incorrect
  }

  void showErrorMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login Failed: Invalid username or password'),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                try {
                  var name = usernameController.text;
                  var password = passwordController.text;
                  print(name);
                  print(password);
                  // Trim whitespaces from the provided username and password
                  name = name.trim();
                  password = password.trim();

                  final loggedIn = await login(name, password);
                  print(loggedIn);
                  if (loggedIn) {
                    // Login successful, navigate to the desired page
                    print('Login Successful');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => bottomnav(),
                      ),
                    );
                  } else {
                    showErrorMessage(context); // Pass the context here
                    print('Login Failed: Invalid username or password');

                    // Login failed, show an error message
                    print('Login Failed: Invalid username or password');
                  }
                } catch (e) {
                  // Handle errors, e.g., network issues
                  print('Error: $e');
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
