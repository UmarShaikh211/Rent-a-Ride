import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SharedCarsPage extends StatefulWidget {
  @override
  _SharedCarsPageState createState() => _SharedCarsPageState();
}

class _SharedCarsPageState extends State<SharedCarsPage> {
  List<dynamic> sharedCars = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://172.20.10.3:8000/sharecar'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          sharedCars = jsonData;
        });
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shared Cars'),
        ),
        body: Container(
          color: Colors.teal,
          height: 235,
          child: ListView.builder(
            itemCount: sharedCars.length,
            itemBuilder: (context, index) {
              final car = sharedCars[index];

              // Access the 'CarBrand' field
              final addedCars = car['added_cars'];
              if (addedCars != null && addedCars.isNotEmpty) {
                final brandName = addedCars[0]['CarBrand'];

                return ListTile(
                  title: Text(brandName),
                  // Add more fields as needed
                );
              } else {
                return ListTile(
                  title: Text('CarBrand not available'),
                );
              }
            },
          ),
        ));
  }
}
