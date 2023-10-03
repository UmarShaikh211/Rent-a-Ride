import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rentcartest/main.dart';
import 'package:rentcartest/user/searchcar_detail.dart';

import 'car_detail.dart';
import 'filter.dart';

class Car_List extends StatefulWidget {
  final DateTime? startdate;
  final DateTime? enddate;
  final TimeOfDay stime;
  final TimeOfDay etime;
  final List<dynamic> sharedCars;

  const Car_List(
      {Key? key,
      required this.startdate,
      required this.enddate,
      required this.stime,
      required this.etime,
      required this.sharedCars})
      : super(key: key);

  @override
  _Car_ListState createState() => _Car_ListState();
}

class _Car_ListState extends State<Car_List> {
  List<dynamic> filteredCars = [];
  // static const String apiUrl = 'http://192.168.0.120:8000/';
  double amt = 200;
  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  Future<void> _applyFilters() async {
    if (widget.startdate != null && widget.enddate != null) {
      final startDateStr = widget.startdate!.toLocal().toString().split(' ')[0];
      final endDateStr = widget.enddate!.toLocal().toString().split(' ')[0];

      try {
        final response = await http.post(
          Uri.parse('$globalapiUrl/filter_cars_with_date/'),
          body: jsonEncode({
            'start_date': startDateStr,
            'end_date': endDateStr,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        print('API Response Status Code: ${response.statusCode}');
        print('API Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final List<dynamic> filteredCars = json.decode(response.body)['cars'];
          setState(() {
            this.filteredCars = filteredCars;
          });
        } else {
          print('API request failed with status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error while making API request: $e');
      }
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
    final totalPrice = totalTimeInHours * amt;

    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered Car List'),
        backgroundColor: Color.fromRGBO(254, 205, 59, 1.0),
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
          itemCount: filteredCars.length,
          itemBuilder: (context, index) {
            print(
                'ItemBuilder called. Length of filteredCars: ${filteredCars.length}');

            final car = filteredCars[index];
            final carBrand = car['added_cars'][0]['CarBrand'];
            final carModel = car['added_cars'][0]['CarModel'];
            final carTrans = car['added_cars'][0]['CarTrans'];
            final carFuel = car['added_cars'][0]['CarFuel'];
            final carSeat = car['added_cars'][0]['CarSeat'];
            final carImageUrl = '$globalapiUrl' + car['car_image'][0]['Image1'];
            final amt = car['car_price'][0]['amount'];

            return Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchCar_detail(
                              carn: carBrand + ' ' + carModel,
                              id: car['id'],
                              sharedCars: filteredCars,
                              cprice: calculateTotalPrice(widget.startdate,
                                  widget.enddate, widget.stime, widget.etime),
                              hprice: amt.toDouble(),
                              sdate: DateFormat('d MMMM')
                                  .format(widget.startdate!)
                                  .toString(),
                              edate: DateFormat('d MMMM')
                                  .format(widget.enddate!)
                                  .toString(),
                              stime: formatTime(widget.stime!).toString(),
                              etime: formatTime(widget.etime!).toString()),
                        ),
                      );
                    },
                    child: Card(
                      child: Container(
                        height: size.height * 0.40,
                        width: size.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: size.height * 0.25,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      '$carImageUrl',
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12)),
                              ),
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite_outline_sharp),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                carBrand + ' ' + carModel,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.05),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                carTrans +
                                    ' '
                                        '*' +
                                    ' ' +
                                    carFuel +
                                    ' '
                                        '*' +
                                    ' ' +
                                    carSeat,
                                style: TextStyle(
                                    fontSize: size.width * 0.025,
                                    color: Colors.red),
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.credit_card_outlined,
                                            size: size.width * 0.07,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "FastTag",
                                            style: TextStyle(
                                                fontSize: size.width * 0.035,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    '\$' + amt.toString() + '/Hr',
                                    style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

String formatTime(TimeOfDay timeOfDay) {
  final format = DateFormat.jm();
  final time = DateTime(0, 1, 1, timeOfDay.hour, timeOfDay.minute);
  return format.format(time);
}
