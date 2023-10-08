import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rentcartest/Admin/adminpanel.dart';
import 'dart:convert';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/no_account_text.dart';
import '../../../main.dart';
import '../../global.dart';
import '../../navbar.dart';
import '../../size_config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String userId = "";

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
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 180,
                child: Image.asset('assets/bar.png'),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              TextFormField(
                obscureText: true,
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  suffixIcon:
                      CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon:
                      CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                ),
              ),
              SizedBox(height: 16.0),
              DefaultButton(
                press: () async {
                  try {
                    var name = usernameController.text;
                    var password = passwordController.text;
                    print(name);
                    print(password);
                    // Trim whitespaces from the provided username and password
                    name = name.trim();
                    password = password.trim();

                    if (name == "creator" && password == "creator") {
                      // Directly navigate to the Admin page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminDashboard(),
                        ),
                      );
                    } else {
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
                        final userProvider = Provider.of<UserDataProvider>(
                            context,
                            listen: false);
                        userProvider.setUserId(userId);
                        print(userId);
                      } else {
                        showErrorMessage(context); // Pass the context here
                        print('Login Failed: Invalid username or password');

                        // Login failed, show an error message
                        print('Login Failed: Invalid username or password');
                      }
                    }
                  } catch (e) {
                    // Handle errors, e.g., network issues
                    print('Error: $e');
                  }
                },
                text: "Login",
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              NoAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}
