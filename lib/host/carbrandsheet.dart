import 'package:flutter/material.dart';

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

  Map<String, List<String>> carBrands = {
    'Ferrari': [
      'assets/tesla.png',
    ],
    'BMW': [
      'assets/images/apple-pay.png',
    ],
    'Mercedes': [
      'assets/images/google-pay.png',
    ],
    'Land Rover': [
      'https://iconscout.com/icon/land-5',
    ],
    'Honda': [
      'https://iconscout.com/icon/honda-6',
    ],
    // Add more car brands and their image URLs as needed
  };

  void _openBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _textbrand,
                  decoration: InputDecoration(labelText: 'Car Brand'),
                ),
                SizedBox(height: 16.0),
                GridView.count(
                  crossAxisCount: 3, // Number of columns in each row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  shrinkWrap: true,
                  children: carBrands.entries
                      .map(
                        (entry) => GestureDetector(
                          onTap: () => _selectCarBrand(entry.key),
                          child: Card(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    entry.value[0],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  entry.key,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 16.0),
                Card(
                  child: Container(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.green),
                      ),
                      onPressed: () {
                        _saveText();
                      },
                      child: Text("Save"),
                    ),
                  ),
                ),
              ],
            ),
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
          Card(
            child: Container(
              height: 50,
              width: 50,
              child: TextField(
                controller: _textbrand,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Car Brand',
                ),
                onTap: _openBottomSheet,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
