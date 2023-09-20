import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Set<int> _selectedButtonIndices = {};

  void _changeButtonColor(int index) {
    setState(() {
      if (_selectedButtonIndices.contains(index)) {
        _selectedButtonIndices.remove(index); // Deselect the button
      } else {
        _selectedButtonIndices.add(index); // Select the button
      }
    });
  }

  Widget buildButton(int index, String text) {
    return ElevatedButton(
        onPressed: () => _changeButtonColor(index),
        style: ElevatedButton.styleFrom(
          primary: _selectedButtonIndices.contains(index)
              ? Colors.green
              : Colors.grey,
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Expanded(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Container(
                        width: 42,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.home_sharp,
                                size: 20,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "FastTag",
                                style: TextStyle(fontSize: 10),
                              ),
                            ]))))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Sort and Filter"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 20),
                buildButton(1, "Button 1"),
                buildButton(2, "Button 2"),
                buildButton(3, "Button 3"),
                // ... other widgets ...
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
                    SizedBox(height: 10),
                    Card(
                      child: Container(
                        width: 320,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: Text("Save"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
