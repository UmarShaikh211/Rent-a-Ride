import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';
import 'cardetailadmin.dart';

class AddCarListScreen extends StatefulWidget {
  @override
  _AddCarListScreenState createState() => _AddCarListScreenState();
}

class _AddCarListScreenState extends State<AddCarListScreen> {
  List<dynamic> addCarList = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('$globalapiUrl/addcars/'));

    if (response.statusCode == 200) {
      setState(() {
        addCarList = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load car data');
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
        title: Text('AddCar List'),
      ),
      body: addCarList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: addCarList.length,
              itemBuilder: (context, index) {
                final addCar = addCarList[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Brand: ${addCar['CarBrand']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.deepPurple,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          'Model: ${addCar['CarModel']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'City: ${addCar['CarCity']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.deepPurpleAccent,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CarDetailAdminScreen(addCar),
                        ),
                      );
                      // Handle addCar item tap, if needed
                    },
                  ),
                );
              },
            ),
    );
  }
}
