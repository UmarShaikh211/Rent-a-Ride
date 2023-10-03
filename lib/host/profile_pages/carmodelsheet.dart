import 'package:flutter/material.dart';

class CarModelSheet extends StatefulWidget {
  final Function(String) onCarModelSelected;

  CarModelSheet({required this.onCarModelSelected});

  @override
  _CarModelSheetState createState() => _CarModelSheetState();
}

class _CarModelSheetState extends State<CarModelSheet> {
  TextEditingController _readOnlyController = TextEditingController();
  TextEditingController _textInputController = TextEditingController();

  Map<String, List<String>> carModels = {
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
      isScrollControlled: true, // Set this to true to increase the height
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textInputController,
                decoration: InputDecoration(labelText: 'Car Brand'),
              ),
              SizedBox(height: 16.0),
              SingleChildScrollView(
                child: GridView.count(
                  crossAxisCount: 3, // Number of columns in each row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  shrinkWrap: true,
                  physics:
                      AlwaysScrollableScrollPhysics(), // Added physics here
                  children: carModels.entries
                      .map(
                        (entry) => GestureDetector(
                          onTap: () => _selectCarModel(entry.key),
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
              ),
              SizedBox(height: 16.0),
              Card(
                child: Container(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.green)),
                      onPressed: () {
                        _saveText();
                      },
                      child: Text("Save"),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectCarModel(String model) {
    setState(() {
      _textInputController.text = model;
    });
  }

  void _saveText() {
    String selectedCarModel = _textInputController.text;
    widget.onCarModelSelected(selectedCarModel);
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
                controller: _readOnlyController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Car Model',
                ),
                onTap: _openBottomSheet,
              ),
            ),
          )
        ],
      ),
    );
  }
}
