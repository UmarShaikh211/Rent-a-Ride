import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentcartest/user/calender_page.dart';
import 'package:rentcartest/user/car_detail.dart';

import 'car_list.dart';
import 'home.dart';

class Search extends StatefulWidget {
  final List<dynamic> sharedCars;

  const Search({
    Key? key,
    required this.sharedCars,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? pickupTime;
  TimeOfDay? dropOffTime;

  Future<void> _openCalendarPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CalendarPage()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        startDate = result['startDate'] as DateTime?;
        endDate = result['endDate'] as DateTime?;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Search Cars",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.width * 0.06),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
        ),
        body: Column(children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    child: Container(
                      width: size.width * 0.82,
                      height: size.height * 0.13,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.015,
                              ),
                              Icon(Icons.edit_location),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.045),
                              )
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Mumbai",
                                  style:
                                      TextStyle(fontSize: size.width * 0.035),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color.fromRGBO(254, 205, 59,
                                            1.0), // Set the background color
                                        onPrimary: Colors.black,
                                        side: BorderSide(
                                            color: Colors.deepPurple)),
                                    onPressed: () {},
                                    child: Text(
                                      "EDIT",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.04),
                                    ),
                                  ),
                                ),
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    child: Container(
                      width: size.width * 0.82,
                      height: size.height * 0.13,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.015,
                              ),
                              Icon(Icons.calendar_month_sharp),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Text(
                                "SET DATE",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.045,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'Start Date: ${startDate != null ? DateFormat('EEEE, d MMMM yyyy').format(startDate!) : 'Not Selected'}',
                                  style:
                                      TextStyle(fontSize: size.width * 0.035),
                                ),
                                SizedBox(height: size.height * 0.02),
                                Text(
                                  'End Date: ${endDate != null ? DateFormat('EEEE, d MMMM yyyy').format(endDate!) : 'Not Selected'}',
                                  style:
                                      TextStyle(fontSize: size.width * 0.035),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(
                            254, 205, 59, 1.0), // Set the background color
                        onPrimary: Colors.black,
                        side: BorderSide(color: Colors.deepPurple)),
                    onPressed: _openCalendarPage,
                    child: Text(
                      "EDIT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.04),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Container(
                      width: size.width * 0.82,
                      height: size.height * 0.225,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.015,
                              ),
                              Icon(Icons.calendar_month_sharp),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Text(
                                "SET TIME",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.045),
                              )
                            ],
                          ),
                          Row(children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    'Pickup Time: ${pickupTime != null ? formatTime(pickupTime!) : 'Not Selected'}',
                                    style:
                                        TextStyle(fontSize: size.width * 0.035),
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  Text(
                                    'Drop-off Time: ${dropOffTime != null ? formatTime(dropOffTime!) : 'Not Selected'}',
                                    style:
                                        TextStyle(fontSize: size.width * 0.035),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color.fromRGBO(254, 205, 59,
                                            1.0), // Set the background color
                                        onPrimary: Colors.black,
                                        side: BorderSide(
                                            color: Colors.deepPurple)),
                                    onPressed: () async {
                                      final TimeOfDay? selectedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );

                                      if (selectedTime != null) {
                                        setState(() {
                                          pickupTime = selectedTime;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'EDIT',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.04),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color.fromRGBO(254, 205, 59,
                                            1.0), // Set the background color
                                        onPrimary: Colors.black,
                                        side: BorderSide(
                                            color: Colors.deepPurple)),
                                    onPressed: () async {
                                      final TimeOfDay? selectedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );

                                      if (selectedTime != null) {
                                        setState(() {
                                          dropOffTime = selectedTime;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'EDIT',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.04),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          ),
          Center(
            child: BottomAppBar(
              child: Container(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(
                            254, 205, 59, 1.0), // Set the background color
                        onPrimary: Colors.black,
                        side: BorderSide(color: Colors.deepPurple)),
                    onPressed: () {
                      if (startDate == null ||
                          endDate == null ||
                          pickupTime == null ||
                          dropOffTime == null) {
                        // Show an error dialog
                        _showErrorDialog('Please select all required fields.');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Car_List(
                                      startdate: startDate,
                                      enddate: endDate,
                                      stime: pickupTime!,
                                      etime: pickupTime!,
                                      sharedCars: widget.sharedCars,
                                    )));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "CONFIRM",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.06),
                      ),
                    )),
              ),
            ),
          )
        ]));
  }
}

String formatTime(TimeOfDay timeOfDay) {
  final format = DateFormat.jm();
  final time = DateTime(0, 1, 1, timeOfDay.hour, timeOfDay.minute);
  return format.format(time);
}
