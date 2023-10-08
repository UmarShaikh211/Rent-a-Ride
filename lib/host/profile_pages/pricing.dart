import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../user/global.dart';
import '../../user/widget.dart';
import 'package:rentcartest/user/some.dart' as someApi;
import 'package:http/http.dart' as http;

class Pricing extends StatefulWidget {
  const Pricing({super.key, required Map arguments});

  @override
  State<Pricing> createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  String? carval;
  bool light = true;
  TextEditingController amt = TextEditingController();
  // //static const String apiUrl = 'http://172.20.10.3:8000/'; //Umar
  // static const String apiUrl = 'http://192.168.0.120:8000';
  String autosetmax = "\$400/hr";
  String autosetamt = "505";
  String autosetmin = "\$300/hr";
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    final userId = userProvider.userId;

    if (userId != null) {
      fetchUserCars(userId);
    }
    // Set the text fields with recommended values initially
    amt.text = autosetamt;
  }

  List<Map<String, dynamic>> userCars = []; // List to store user's car objects
  String? selectedCarId; // ID of the selected car object

  // Inside your _HostAnlState class
  Future<void> fetchUserCars(String userId) async {
    try {
      print("Fetching user's car objects...");

      if (userId != null) {
        print("User ID: $userId");

        userCars = await someApi.ApiService.getUserCars(userId);

        print("User's car objects fetched: $userCars");

        if (userCars.isNotEmpty) {
          selectedCarId = userCars[0]['id'].toString();
          print("Selected car ID set: $selectedCarId");
        }

        setState(() {});
      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error fetching user's car objects: $e");
    }
  }

  String getCarNameById(String carId) {
    final car = userCars.firstWhere(
      (car) => car['id'].toString() == carId,
      orElse: () => {},
    );

    if (car != null) {
      final addedCars = car['added_cars'] as List<dynamic>;
      if (addedCars.isNotEmpty) {
        final carBrand = addedCars[0]['CarBrand'];
        final carModel = addedCars[0]['CarModel'];

        if (carBrand != null && carModel != null) {
          return '$carBrand $carModel';
        }
      }
    }

    return 'Unknown Car';
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: customInputDecorationTheme(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pricing Control"),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: customInputDecorationTheme(),
          ),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: 320,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: DropdownButtonFormField<String>(
                            value: selectedCarId, // Use selectedCarId here
                            onChanged: (newValue) {
                              setState(() {
                                selectedCarId = newValue;
                              });
                            },
                            items: userCars.map((car) {
                              final carId = car['id'].toString();
                              final carName = getCarNameById(carId);

                              return DropdownMenuItem<String>(
                                value: carId,
                                child: Text('$carName'),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Select a car',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Stack(children: [
                        Container(
                          child: Image.asset("assets/bar.png"),
                        ),
                        Positioned(
                          width: 364,
                          bottom: 12,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 70),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  elevation: 10,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        autosetmin,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                  ),
                                ),
                                Card(
                                  elevation: 10,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        autosetmax,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("Recommended Car Price"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              child: TextField(
                                style: TextStyle(fontSize: 14),
                                controller: amt,
                                keyboardType: TextInputType.number,
                                enabled:
                                    !light, // Disable TextField when autopricing is enabled
                                decoration: InputDecoration(
                                  labelText: "Price/Hr",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          //child:,
                          ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                            elevation: 2,
                            child: ListTile(
                              leading: Icon(Icons.price_check),
                              title: Text("Auto Pricing"),
                              subtitle: Text("Rent-a-ride will set the price"),
                              trailing: Switch(
                                // This bool value toggles the switch.
                                value: light,
                                activeColor: Colors.blueAccent,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    light = value;
                                    if (light) {
                                      amt.text = autosetamt;
                                    } else {
                                      amt.text = "";
                                    }
                                  });
                                },
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 400,
                  child: BottomAppBar(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: Container(
                                width: 320,
                                height: 45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(254, 205, 59,
                                          1.0), // Set the background color
                                      onPrimary: Colors.black,
                                      side:
                                          BorderSide(color: Colors.deepPurple)),
                                  onPressed: () async {
                                    final amountValue = int.tryParse(amt.text);

                                    if (amountValue != null) {
                                      // The parsing was successful, you can use amountValue in the request.
                                      // Continue with the HTTP request.
                                    } else {
                                      // Handle the case where the parsing failed (e.g., show an error message).
                                      print(
                                          "Invalid amount entered: ${amt.text}");
                                    }
                                    print(
                                        "Sending request with amountValue: $amountValue");

                                    final response = await http.post(
                                      Uri.parse(
                                          '$globalapiUrl/price/'), // Replace with your Django backend URL
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                      },
                                      body: jsonEncode(
                                        <String, dynamic>{
                                          'car': selectedCarId,
                                          'amount': amountValue,
                                        },
                                      ),
                                    );

                                    if (response.statusCode == 201) {
                                      print('Success: ${response.body}');
                                    } else {
                                      print(
                                          'Error ${response.statusCode}: ${response.body}');
                                    }
                                  },
                                  child: Text("SAVE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
