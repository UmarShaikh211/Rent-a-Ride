import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../main.dart';
import '../user/home.dart';

class CarBrandSheet extends StatefulWidget {
  final Function(String) onCarBrandSelected;

  CarBrandSheet({
    required this.onCarBrandSelected,
  });

  @override
  _CarBrandSheetState createState() => _CarBrandSheetState();
}

class _CarBrandSheetState extends State<CarBrandSheet> {
  TextEditingController _textbrand = TextEditingController();

  List<BrandLogo> brands = [];

  @override
  void initState() {
    super.initState();
    _fetchBrands(); // Call _fetchBrands when the widget is initialized
  }

  Future<void> _fetchBrands() async {
    final response = await http.get(Uri.parse('$globalapiUrl/brandlogo/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<BrandLogo> fetchedBrands = data.map((json) {
        return BrandLogo.fromJson(json);
      }).toList();

      setState(() {
        brands = fetchedBrands;
      });
    } else {
      throw Exception('Failed to load brands');
    }
  }

  void _openBottomSheet() {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: 400, // Adjust the maxHeight as needed
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of columns in each row
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: brands.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () =>
                                _selectCarBrand(brands[index].brandname),
                            child: Card(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      brands[index].brandimage,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    brands[index].brandname,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
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
                      _saveText();
                    },
                    child: Text("SAVE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.06,
                            fontFamily: 'Times New Roman')),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectCarBrand(String brand) {
    setState(() {
      _textbrand.text = brand;
    });
  }

  void _saveText() {
    String selectedCarBrand = _textbrand.text;
    widget.onCarBrandSelected(selectedCarBrand);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 50,
            width: 50,
            child: TextField(
              controller: _textbrand,
              readOnly: true,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                labelText: 'Car Brand',
              ),
              onTap: _openBottomSheet,
            ),
          ),
        ],
      ),
    );
  }
}

class BrandLogo {
  final String brandname;
  final String brandimage;

  BrandLogo({required this.brandname, required this.brandimage});

  factory BrandLogo.fromJson(Map<String, dynamic> json) {
    return BrandLogo(
      brandname: json['brandname'],
      brandimage: json['brandimage'],
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
