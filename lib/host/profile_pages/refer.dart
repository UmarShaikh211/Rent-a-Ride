import 'package:flutter/material.dart';

class Refer extends StatefulWidget {
  const Refer({super.key});

  @override
  State<Refer> createState() => _ReferState();
}

class _ReferState extends State<Refer> {
  TextEditingController link = TextEditingController();
  String? _link = "www.google.com";

  void initState() {
    super.initState();
    // Set the text fields with recommended values initially
    link.text = _link!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer App"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text("Refer our App"),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: link,
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
}
