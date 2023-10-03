import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentcartest/user/calender_page.dart';
import 'package:rentcartest/user/car_detail.dart';

import 'car_list.dart';
import 'home.dart';

class Date extends StatefulWidget {
  final String carn;
  final int id;
  final List<dynamic> sharedCars;
  final double cprice;
  const Date(
      {Key? key,
      required this.carn,
      required this.id,
      required this.sharedCars,
      required this.cprice})
      : super(key: key);

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? pickupTime;
  TimeOfDay? dropOffTime;
  // Function to display an error dialog
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

  double calculateTotalPrice(DateTime? startDate, DateTime? endDate,
      TimeOfDay? pickupTime, TimeOfDay? dropOffTime) {
    if (startDate == null ||
        endDate == null ||
        pickupTime == null ||
        dropOffTime == null) {
      // Return 0 if any of the required fields is not selected
      return 0.0;
    }

    // Calculate the total hours between start and end date
    final duration = endDate.difference(startDate);
    final totalHours = duration.inHours.toDouble();

    // Convert pickup time and drop-off time to hours and minutes
    final pickupHour = pickupTime.hour.toDouble();
    final pickupMinute = pickupTime.minute.toDouble() / 60.0;
    final dropOffHour = dropOffTime.hour.toDouble();
    final dropOffMinute = dropOffTime.minute.toDouble() / 60.0;

    // Calculate the fractional hours for pickup and drop-off
    final pickupFractionalHour = pickupHour + pickupMinute;
    final dropOffFractionalHour = dropOffHour + dropOffMinute;

    // Calculate the total time in hours, including fractional hours
    final totalTimeInHours =
        totalHours + (dropOffFractionalHour - pickupFractionalHour);

    // Calculate the total price
    final totalPrice = totalTimeInHours * widget.cprice;

    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Set Date & Time"),
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
                        Row(children: [
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
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(
                        254, 205, 59, 1.0), // Set the background color
                    onPrimary: Colors.black,
                    side: BorderSide(color: Colors.deepPurple)),
                onPressed: _openCalendarPage,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
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
                    height: size.height * 0.2,
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
                                      side:
                                          BorderSide(color: Colors.deepPurple)),
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
                                      side:
                                          BorderSide(color: Colors.deepPurple)),
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
              // SizedBox(
              //   height: size.height * 0.02,
              // ),
              // Text(
              //   'Total Price: \$${calculateTotalPrice(startDate, endDate, pickupTime, dropOffTime).toStringAsFixed(2)}',
              //   style: TextStyle(fontSize: size.width * 0.035),
              // ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
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
                              builder: (context) => Car_detail(
                                    carn: widget.carn,
                                    id: widget.id,
                                    sharedCars: widget.sharedCars,
                                    cprice: calculateTotalPrice(startDate,
                                        endDate, pickupTime, dropOffTime),
                                    hprice: widget.cprice,
                                    sdate: DateFormat('d MMMM')
                                        .format(startDate!)
                                        .toString(),
                                    edate: DateFormat('d MMMM')
                                        .format(endDate!)
                                        .toString(),
                                    stime: formatTime(pickupTime!).toString(),
                                    etime: formatTime(pickupTime!).toString(),
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
                  ))
            ]),
          ),
        ));
  }
}

String formatTime(TimeOfDay timeOfDay) {
  final format = DateFormat.jm();
  final time = DateTime(0, 1, 1, timeOfDay.hour, timeOfDay.minute);
  return format.format(time);
}
