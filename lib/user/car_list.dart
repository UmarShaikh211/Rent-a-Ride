import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rentcartest/user/test.dart';
import 'package:rentcartest/user/widget.dart';

import '../backend.dart';
import 'car_detail.dart';
import 'filter.dart';
import 'package:http/http.dart' as http;

class Car_List extends StatefulWidget {
  const Car_List({super.key});

  @override
  State<Car_List> createState() => _Car_ListState();
}

class _Car_ListState extends State<Car_List> {
  List<dynamic> sharedCars = [];
  //static const String apiUrl = 'http://172.20.10.3:8000/'; //Umar
  static const String apiUrl = 'http://192.168.0.120:8000/'; //Home

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/sharecar'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          sharedCars = jsonData;
        });
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 23),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Mumbai,Maharashtra",
                          style: TextStyle(fontSize: size.width * 0.03),
                        ),
                        Text("Mon,7 July-Tue,18 July",
                            style: TextStyle(fontSize: size.width * 0.03)),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.17,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.near_me),
                            Text(
                              "Nearest",
                              style: TextStyle(fontSize: size.width * 0.035),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.star),
                            Text(
                              "Top Rated",
                              style: TextStyle(fontSize: size.width * 0.035),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.currency_rupee),
                            Text(
                              "Affordable",
                              style: TextStyle(fontSize: size.width * 0.035),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.stacked_bar_chart_sharp),
                            Text(
                              "Top Rated",
                              style: TextStyle(fontSize: size.width * 0.035),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.remove_red_eye_outlined),
                            Text(
                              "Most Viewed",
                              style: TextStyle(fontSize: size.width * 0.035),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.home_filled),
                            Text(
                              "Home Delivery",
                              style: TextStyle(fontSize: size.width * 0.035),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: sharedCars.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final car = sharedCars[index];

                        // Access the 'CarBrand' field
                        final addedCars = car['added_cars'];
                        final carImage = car['car_image'];

                        if (addedCars != null &&
                            addedCars.isNotEmpty &&
                            carImage != null &&
                            carImage.isNotEmpty) {
                          final brandName = addedCars[0]['CarBrand'];
                          final modelName = addedCars[0]['CarModel'];
                          final transName = addedCars[0]['CarTrans'];
                          final fuelName = addedCars[0]['CarFuel'];
                          final seatName = addedCars[0]['CarSeat'];

/////////////////////////////////////////////////////////////////////////////////////
                          final carimg1 = carImage[0]['Image1'];

////////////////////////////////////////////////////////////////////////////////////

                          return Center(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Car_detail(
                                    //       carn: brandName + ' ' + modelName,
                                    //       id: car['id'],
                                    //       sharedCars: sharedCars,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Card(
                                    child: Container(
                                      height: size.height * 0.40,
                                      width: size.width * 0.9,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: size.height * 0.25,
                                            width: size.width * 0.9,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    carimg1,
                                                  ),
                                                  fit: BoxFit.cover),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  topLeft: Radius.circular(12)),
                                            ),
                                            child: Stack(
                                              alignment: AlignmentDirectional
                                                  .bottomEnd,
                                              children: [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons
                                                      .favorite_outline_sharp),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              brandName + ' ' + modelName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.width * 0.05),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              transName +
                                                  ' '
                                                      '*' +
                                                  ' ' +
                                                  fuelName +
                                                  ' '
                                                      '*' +
                                                  ' ' +
                                                  seatName,
                                              style: TextStyle(
                                                  fontSize: size.width * 0.025,
                                                  color: Colors.red),
                                            ),
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.greenAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .credit_card_outlined,
                                                          size:
                                                              size.width * 0.07,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "FastTag",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  '\$' + 520.toString() + '/Hr',
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.045,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                        } else {
                          return const Center(
                            child: Text('Invalid data format'),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Positioned(
              bottom: 40, // Adjust the bottom offset as needed
              right: 16, // Adjust the right offset as needed
              child: IconButton.filled(
                color: Colors.black,
                style: IconButton.styleFrom(backgroundColor: Colors.black),
                iconSize: 35,
                icon: Icon(Icons.filter_list_alt),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Filter()));
                },
              ))
        ]));
  }
}
