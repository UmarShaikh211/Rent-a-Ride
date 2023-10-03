import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/main.dart';
import 'package:rentcartest/user/some.dart' as someApi;

import '../../user/global.dart';
import '../../user/widget.dart';
import 'package:http/http.dart' as http;

class ProgramDet extends StatefulWidget {
  const ProgramDet({super.key});

  @override
  State<ProgramDet> createState() => _ProgramDetState();
}

class _ProgramDetState extends State<ProgramDet> {
  String? carval;
  List<Map<String, dynamic>> userCars = [];
  String? selectedCarId = '';
  String? userId;
  String bname = 'Unknown';
  String mname = 'Unknown';
  String fname = 'Unknown';
  String sname = 'Unknown';
  String tname = 'Unknown';
  String lname = 'Unknown';
  String cari = 'Unknown';

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId;

    if (userId != null) {
      fetchUserCars(userId!);
    }
  }

  Future<void> fetchUserCars(String userId) async {
    try {
      print("Fetching user's car objects...");

      if (userId != null) {
        print("User ID: $userId");

        userCars = await someApi.ApiService.getUserCars(userId);

        print("User's car objects fetched: $userCars");

        if (userCars.isNotEmpty) {
          setState(() {
            selectedCarId = userCars[0]['id'].toString();
            fetchCarDetails(selectedCarId!);
          });
        }
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

  Future<void> fetchCarDetails(String carId) async {
    try {
      final response = await http.get(Uri.parse('$globalapiUrl/cars/$carId/'));
      if (response.statusCode == 200) {
        final carData = json.decode(response.body);
        final brand = carData['added_cars'][0]['CarBrand'];
        final model = carData['added_cars'][0]['CarModel'];
        final seats = carData['added_cars'][0]['CarSeat'];
        final fuel = carData['added_cars'][0]['CarFuel'];
        final trans = carData['added_cars'][0]['CarTrans'];
        final location = carData['added_cars'][0]['CarCity'];
        final image = carData['car_image'][0]['Image1'];

        setState(() {
          bname = brand ?? 'Unknown'; // Set the carSeats variable
          mname = model ?? 'Unknown'; // Set the carSeats variable
          sname = seats ?? 'Unknown'; // Set the carSeats variable
          fname = fuel ?? 'Unknown'; // Set the carSeats variable
          tname = trans ?? 'Unknown'; // Set the carSeats variable
          lname = location ?? 'Unknown'; // Set the carSeats variable
          cari = image ?? 'Unknown'; // Set the carSeats variable
        });
      } else {
        // Handle error response (e.g., show an error message)
      }
    } catch (e) {
      // Handle network or other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: customInputDecorationTheme(),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("Car Details")),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedCarId,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCarId = newValue;
                        print("My problem" + selectedCarId!);
                        fetchCarDetails(
                            selectedCarId!); // Call the function here
                      });
                    },
                    items: userCars.map((car) {
                      final carId = car['id'].toString();
                      final carName = getCarNameById(carId);
                      return DropdownMenuItem<String>(
                          value: carId, child: Text('$carName'));
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Select a car',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: Image.network(
                  cari,
                  fit: BoxFit.fill,
                  height: 120,
                  width: 100,
                ),
              ),
              title: Text('$bname $mname'),
              subtitle: Text("$sname"),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(children: [
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: Icon(
                            Icons.battery_6_bar_outlined,
                            color: Colors.white,
                          )),
                      title: Text("Fuel Type"),
                      subtitle: Text(fname),
                    ),
                    Divider(),
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(Icons.gamepad_outlined)),
                      title: Text("Transmission"),
                      subtitle: Text(tname),
                    ),
                    Divider(),
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.location_on)),
                      title: Text("Location"),
                      subtitle: Text(lname),
                    ),
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}

InputDecorationTheme customInputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // Customize the border radius as needed
    borderSide:
        BorderSide(color: Colors.teal), // Customize the border color as needed
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
