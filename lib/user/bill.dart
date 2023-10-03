import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rentcartest/user/navbar.dart';
import 'package:rentcartest/user/trips.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'global.dart';
import 'home.dart';

class Bill extends StatefulWidget {
  final String carname;
  final String cimage;
  final String carid;
  final double tfare;
  final String sdate;
  final String edate;
  final String dmgi;
  const Bill({
    super.key,
    required this.carname,
    required this.cimage,
    required this.carid,
    required this.tfare,
    required this.sdate,
    required this.edate,
    required this.dmgi,
  });

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
  // int trip = 8000;
  // int dmg = 500;
  int cf = 500;
  bool paymentSuccessful = false; // Track payment status
  late var _razorpay;
  List<dynamic> sharedCars = [];
  // static const String apiUrl = 'http://172.20.10.3:8000/'; //Umar
  // //static const String apiUrl = 'http://192.168.0.120:8000/';

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final bookingStatusProvider =
        Provider.of<BookingStatusProvider>(context, listen: false);

    DateFormat dateFormat = DateFormat('dd MMMM yyyy, hh:mm a');
    DateTime now = DateTime.now();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);

    //
    // final newBookingStatus = {
    //   'bookingStatus': 'Successful',
    //   'name': widget.carname,
    //   'image': widget.cimage,
    //   'datetime': dateFormat.format(now),
    // };
    //
    // bookingStatusProvider.addBookingStatus(newBookingStatus);
    //
    // setState(() {
    //   paymentSuccessful = true;
    // });
// Open the Hive box where you want to store booking status data
    final box = await Hive.openBox<BookingStatus>(
        'booking_status_${userProvider.userId}');

// Save booking status data when it's updated (e.g., in _handlePaymentSuccess and _handlePaymentError methods)
    final newBookingStatus = BookingStatus(
      carid: widget.carid,
      name: widget.carname,
      image: widget.cimage,
      datetime: dateFormat.format(now),
      bookingStatus: 'Successful',
    );
    setState(() {
      paymentSuccessful = true;
    });
    await box.add(newBookingStatus);

// Retrieve booking status data (e.g., in the build method of Trip widget)

    // Send data to Django backend
    // DateFormat dateFormatt = DateFormat('yyyy-MM-ddTHH:mm:ss');
    // String formattedTimestamp = dateFormatt.format(now);

    final response = await http.post(
      Uri.parse('$globalapiUrl/trips/'), // Replace with your Django backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'car': widget.carid,
          'cname': widget.carname,
          'sdate': widget.sdate,
          'edate': widget.edate,
        },
      ),
    );

    if (response.statusCode == 201) {
      print('Success: ${response.body}');
    } else {
      print('Error ${response.statusCode}: ${response.body}');
    }

    final incresponse = await http.post(
      Uri.parse(
          '$globalapiUrl/income/'), // Replace with your Django backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'car': widget.carid,
          'cname': widget.carname,
          'cinc': (widget.tfare + widget.tfare + cf).toString(),
          'sdate': widget.sdate,
          'edate': widget.edate
        },
      ),
    );

    if (incresponse.statusCode == 201) {
      print('Success: ${incresponse.body}');
    } else {
      print('Error ${incresponse.statusCode}: ${incresponse.body}');
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => bottomnav(),
        ));

    print("Payment Done");
  }

  Future<void> _handlePaymentError(PaymentFailureResponse response) async {
    final bookingStatusProvider =
        Provider.of<BookingStatusProvider>(context, listen: false);
    DateFormat dateFormat = DateFormat('dd MMMM yyyy, hh:mm a');
    DateTime now = DateTime.now();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);

    // final newBookingStatus = {
    //   'bookingStatus': 'Failed',
    //   'name': widget.carname,
    //   'image': widget.cimage,
    //   'datetime': dateFormat.format(now),
    // };
    //
    // bookingStatusProvider.addBookingStatus(newBookingStatus);
// Open the Hive box where you want to store booking status data
    final box = await Hive.openBox<BookingStatus>(
        'booking_status_${userProvider.userId}');

    // Save booking status data for failed payment

    final newBookingStatus = BookingStatus(
      carid: widget.carid,
      name: widget.carname,
      image: widget.cimage,
      datetime: dateFormat.format(now),
      bookingStatus: 'Failed',
    );
    setState(() {
      paymentSuccessful = false;
    });
    await box.add(newBookingStatus);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => bottomnav(),
        ));
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  @override
  Widget build(BuildContext context) {
    num tf = widget.tfare.toInt() + int.parse(widget.dmgi) + cf;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Bill"),
      //   backgroundColor: Colors.teal,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Card(
              elevation: 8,
              child: Container(
                height: 350,
                width: 500,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      Text(
                        "Fare Summary",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        leading: Container(
                            width: 150,
                            child:
                                Text("Trip Fare (Unimited Kms without Fuel)")),
                        trailing: Text("\$" + widget.tfare.toString()),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        leading: Text("Damage Protection Fee"),
                        trailing: Text("+\$" + widget.dmgi.toString()),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        leading: Text("Convenience Fees"),
                        trailing: Text("+\$" + cf.toString()),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        leading: Text(
                          "Total Fare",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        trailing: Text(tf.toString()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              child: Text("Pay Amount"),
              onPressed: () {
                ///Make payment
                var options = {
                  'key': "rzp_test_9jW4xgG8YJh7qS",
                  // amount will be multiple of 100
                  'amount': (tf * 100).toString(), //So its pay 500
                  'name': 'Rent-a-Ride',
                  'description': 'Demo',
                  'timeout': 500, // in seconds
                  'prefill': {
                    'contact': '7208392355',
                    'email': 'rent-a-ride@gmail.com'
                  }
                };
                _razorpay.open(options);
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Close the Hive box to release resources
    final box = Hive.box<BookingStatus>('booking_status');
    box.close();

    // Clear the Razorpay instance
    _razorpay.clear();

    super.dispose();
  }
}
