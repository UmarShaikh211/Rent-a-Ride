import 'package:flutter/material.dart';

class CarVariantSheet extends StatefulWidget {
  final Function(String) onCarVariantSelected;

  CarVariantSheet({required this.onCarVariantSelected});

  @override
  _CarVariantSheetState createState() => _CarVariantSheetState();
}

class _CarVariantSheetState extends State<CarVariantSheet> {
  TextEditingController _readOnlyController = TextEditingController();
  TextEditingController _textInputController = TextEditingController();

  Map<String, List<String>> carVariant = {
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
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _textInputController,
                  decoration: InputDecoration(labelText: 'Car Variants'),
                ),
                SizedBox(height: 16.0),
                ListView(
                  shrinkWrap: true,
                  children: carVariant.entries
                      .map(
                        (entry) => GestureDetector(
                          onTap: () => _selectCarVariant(entry.key),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                entry.key,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
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
                                MaterialStatePropertyAll<Color>(Colors.green)),
                        onPressed: () {
                          _saveText();
                        },
                        child: Text("Save"),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectCarVariant(String variant) {
    setState(() {
      _textInputController.text = variant;
    });
  }

  void _saveText() {
    String selectedCarVariant = _textInputController.text;
    widget.onCarVariantSelected(selectedCarVariant);
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
                controller: _textInputController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Car Variant',
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
