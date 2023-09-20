import 'package:flutter/material.dart';

class SaveBanlk extends StatefulWidget {
  final String Acc;
  final String Ifsc;
  final String Pan;

  const SaveBanlk(
      {super.key, required this.Acc, required this.Ifsc, required this.Pan});

  @override
  State<SaveBanlk> createState() => _SaveBanlkState();
}

class _SaveBanlkState extends State<SaveBanlk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Account Details"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Column(
                    children: [
                      Text("Account Number:" + widget.Acc),
                      SizedBox(
                        height: 10,
                      ),
                      Text("IFSC Code: " + widget.Ifsc),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Pan Card Number:" + widget.Pan)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
