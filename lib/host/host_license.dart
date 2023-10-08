import 'package:flutter/material.dart';
import 'package:rentcartest/host/host_eligibility.dart';
import 'package:rentcartest/user/some.dart' as someApi;
import 'package:rentcartest/user/new.dart';

class HostLic extends StatefulWidget {
  final String userId;

  HostLic(this.userId);

  @override
  State<HostLic> createState() => _HostLicState();
}

class _HostLicState extends State<HostLic> {
  TextEditingController license = TextEditingController();
  String? lastCarId;

  void dispose() {
    license.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchLastCarId(); // Fetch lastCarId if user is pre-existing
  }

  Future<void> fetchLastCarId() async {
    try {
      print("Fetching last car ID...");
      lastCarId = await someApi.ApiService.getLastCarId(widget.userId);
      print("Last Car ID fetched: $lastCarId");
      setState(() {}); // Rebuild the UI to show the lastCarId
    } catch (e) {
      print("Error fetching last car ID: $e");
      // Handle errors when fetching the last car ID
    }
  }

  void _handleAddNotification() async {
    if (lastCarId == null) {
      try {
        lastCarId = await someApi.ApiService.getLastCarId(widget.userId);
      } catch (e) {
        // Handle errors when fetching the last car ID
        return;
      }
    }

    if (lastCarId != null) {
      Navigator.pushNamed(context, '/add_car', arguments: {
        'userId': widget.userId,
        'carId': lastCarId!,
        'licenses': license.text, // Pass the license data here
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please create a car first')),
      );
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: customInputDecorationTheme(),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Add Car"),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: license,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Car License Number',
                    hintText: 'Enter License Number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 90),
                child: Text(
                  "Please Enter in MH02BA1234 format",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.63,
              ),
              BottomAppBar(
                child: Container(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(
                              254, 205, 59, 1.0), // Set the background color
                          onPrimary: Colors.black,
                          side: BorderSide(color: Colors.deepPurple)),
                      onPressed: () {
                        _handleAddNotification();
                      },
                      child: Text("NEXT",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.06)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

InputDecorationTheme customInputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // Customize the border radius as needed
    borderSide: BorderSide(
        color: Colors.deepPurple), // Customize the border color as needed
    gapPadding: 5,
  );
  return InputDecorationTheme(
    floatingLabelBehavior:
        FloatingLabelBehavior.auto, // Customize the label behavior if needed
    contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10), // Customize the content padding if needed
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
