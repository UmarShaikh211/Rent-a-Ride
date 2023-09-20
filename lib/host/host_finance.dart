import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../user/global.dart';
import 'host_drawer.dart';
import 'package:rentcartest/user/some.dart' as someApi;

class HostFin extends StatefulWidget {
  const HostFin({super.key});

  @override
  State<HostFin> createState() => _HostFinState();
}

class _HostFinState extends State<HostFin> {
  List<Map<String, dynamic>> userCars = [];
  String? selectedCarId = " ";
  String? userId;
  //static const String apiUrl = 'http://172.20.10.3:8000/'; //Umar
  static const String apiUrl = 'http://192.168.0.120:8000/';
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
          });
        }
      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error fetching user's car objects: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HostDraw(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Performance DashBoard"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
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
                    });
                  },
                  items: userCars.map((car) {
                    final carId = car['id'].toString();
                    return DropdownMenuItem<String>(
                      value: carId,
                      child: Text('Car ID: $carId'),
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
              height: 20,
            ),
            Container(
              height: 200,
              width: 400,
              child: Image.asset("assets/bar.png"),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future:
                  fetchTripsByCarId(selectedCarId!), // Pass selectedCarId here
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.isEmpty) {
                  return Center(child: Text('No Income available.'));
                } else {
                  return IncomeList(incomes: snapshot.data!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchTripsByCarId(String? carId) async {
    try {
      if (carId == null) {
        // Return an empty list if carId is null
        return [];
      }

      print('Fetching trips for car ID: $carId'); // For debugging

      final response = await http.get(
        Uri.parse('$apiUrl/income/?car=$carId'),
      );

      print('API Response: ${response.body}'); // For debugging

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Filter data by "car" attribute
        final filteredData =
            data.where((item) => item['car'] == int.parse(carId)).toList();

        return filteredData
            .map((item) => item as Map<String, dynamic>)
            .toList();
      } else {
        throw Exception('Failed to load Income');
      }
    } catch (error) {
      print('Error: $error');
      return []; // Return an empty list in case of an error
    }
  }
}

class IncomeList extends StatelessWidget {
  final List<Map<String, dynamic>> incomes;

  IncomeList({required this.incomes});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      child: ListView.builder(
        itemCount: incomes.length,
        itemBuilder: (BuildContext context, int index) {
          final income = incomes[index];

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
                elevation: 3,
                child: Container(
                  height: 50,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.cyanAccent),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              '${income['sidate']}' +
                                  "-" +
                                  '${income['eidate']}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${income['cname']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                '+' + '\$' + '${income['cinc']}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
