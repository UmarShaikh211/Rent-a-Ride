import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rentcartest/user/Userlogin/pages/logint.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../main.dart';
import '../../constants.dart';
import '../../global.dart';
import '../../size_config.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String emailError;
  late String passwordError;
  late String phoneError;

  static Future<String> createUser(
      String name, String email, String phone, String pass) async {
    final response = await http.post(
      Uri.parse('$globalapiUrl/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'phone': phone,
        'password': pass,
      }),
    );

    if (response.statusCode == 201) {
      final createdUser = jsonDecode(response.body);
      final userId = createdUser['id'];
      return userId;
    } else {
      throw Exception('Failed to create user');
    }
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: 400,
                    child: Image.asset('assets/bar.png'),
                  ),
                  Text("Register Account", style: headingStyle),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      suffixIcon:
                          CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username cannot be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      suffixIcon:
                          CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be empty';
                      } else {
                        // Trim the value and then check if it's a valid email
                        final trimmedValue = value.trim();
                        if (!isValidEmail(trimmedValue)) {
                          return 'Invalid email address';
                        }
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      suffixIcon:
                          CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone number cannot be empty';
                      } else if (!isValidPhone(value)) {
                        return 'Invalid phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon:
                          CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  DefaultButton(
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        final name = usernameController.text.trim();
                        final email = emailController.text.trim();
                        final phone = phoneController.text.trim();
                        final pass = passwordController.text.trim();

                        final userId =
                            await createUser(name, email, phone, pass);

                        if (userId != null) {
                          // User registration successful, navigate to the desired page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );

                          final userProvider = Provider.of<UserDataProvider>(
                              context,
                              listen: false);
                          userProvider.setUserId(userId);
                        } else {
                          // User registration failed, show an error message
                          // You can use a Snackbar or AlertDialog to display the error message
                        }
                      }
                    },
                    text: 'Register',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  bool isValidPhone(String phone) {
    return phone.length == 10;

    // Add your phone validation logic here
    // You can use regex or other methods to validate phone number
    return true;
  }
}
