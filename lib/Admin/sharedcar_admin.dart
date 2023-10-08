import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentcartest/Admin/sharedcar_detail_admin.dart';
import 'dart:convert';

import '../main.dart';

class SharedCarsListScreen extends StatefulWidget {
  @override
  _SharedCarsListScreenState createState() => _SharedCarsListScreenState();
}

class _SharedCarsListScreenState extends State<SharedCarsListScreen> {
  List<dynamic> sharedCarsList = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('$globalapiUrl/sharecar/'));

    if (response.statusCode == 200) {
      setState(() {
        sharedCarsList = jsonDecode(response.body);
      });
    } else {
      throw Exception(
          'Failed to load shared cars data. Response: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Cars List'),
      ),
      body: sharedCarsList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: sharedCarsList.length,
              itemBuilder: (context, index) {
                final sharedCar = sharedCarsList[index];
                final addedCars = sharedCar['added_cars'];
                final hostBio = sharedCar['host_bio'];
                final cprice = sharedCar['car_price'];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Car Brand: ${addedCars[0]['CarBrand']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          'Model: ${addedCars[0]['CarModel']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'City: ${addedCars[0]['CarCity']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SharedCarDetailAdminScreen(sharedCar),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SharedCarsListScreen(),
  ));
}
