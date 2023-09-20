import 'dart:convert';

import 'package:action_slider/action_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentcartest/user/image.dart';
import 'package:rentcartest/user/widget.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import '../backend.dart';
import 'bill.dart';
import 'cart_model.dart';
import 'date.dart';
import 'home.dart';

class Car_detail extends StatefulWidget {
  final String carn;
  final int id;
  final List<dynamic> sharedCars; // Add this parameter
  final double cprice;
  final double hprice;
  final String sdate;
  final String edate;
  final String stime;
  final String etime;

  const Car_detail({
    Key? key,
    required this.carn,
    required this.id,
    required this.sharedCars,
    required this.cprice,
    required this.hprice,
    required this.sdate,
    required this.edate,
    required this.stime,
    required this.etime,
  }) : super(key: key);

  @override
  State<Car_detail> createState() => _Car_detailState();
}

class _Car_detailState extends State<Car_detail> {
  bool isChecked = false;
  bool isExpanded = false;
  String carYear = "Year not available"; // Initialize with a default value
  String hbio = "Bio Not available";
  String himg = "Img Not available";
  String selectedImageUrl = ''; // Default image URL
  List<String> imageUrls = []; // Declare imageUrls here
  int selectedImageIndex =
      0; // Add this variable to keep track of the selected image index
  List<String> carFeatures = [];

  @override
  void initState() {
    super.initState();

    // Find the selected car object based on the car ID
    final selectedCar = widget.sharedCars.firstWhere(
      (car) => car['id'] == widget.id,
      orElse: () => null, // Return null if no matching car is found
    );

    // Check if the selectedCar is not null and contains "host_bio" data
    if (selectedCar != null && selectedCar.containsKey('host_bio')) {
      final hostBio = selectedCar['host_bio'];

      // Check if hostBio is not empty
      if (hostBio.isNotEmpty) {
        final himage = selectedCar['host_bio'][0]['Himage'];
        final Hbio = selectedCar['host_bio'][0]['Hbio'];
        print('Himage: $himage');
        print('Hbio: $Hbio');

        if (himage != null && himg.isNotEmpty) {
          himg = himage;
          hbio = Hbio;
        }
      }
    }

    // Check if the selectedCar is not null and contains "carImage" data
    if (selectedCar != null && selectedCar.containsKey('car_image')) {
      final carImage = selectedCar['car_image'];

      // Check if carImage is not empty
      if (carImage.isNotEmpty) {
        // Create a list to store all 7 image URLs
        for (int i = 1; i <= 7; i++) {
          final imageKey = 'Image$i';

          if (carImage[0].containsKey(imageKey)) {
            final imageUrl = carImage[0][imageKey];

            // Check if imageUrl is not null and not empty
            if (imageUrl != null && imageUrl.isNotEmpty) {
              print('Added imageUrl: $imageUrl'); // Debug statement
              imageUrls.add(imageUrl);
            }
          }
        }
      }
    }

    // Debug: Print the populated imageUrls list
    print('Populated imageUrls: $imageUrls');

    // Check if the selectedCar is not null and contains "added_cars" data
    if (selectedCar != null && selectedCar.containsKey('added_cars')) {
      final addedCars = selectedCar['added_cars'];

      // Check if addedCars is not empty
      if (addedCars.isNotEmpty) {
        final carYearFromData = addedCars[0]['CarYear'];

        // Check if carYearFromData is not null or empty
        if (carYearFromData != null && carYearFromData.isNotEmpty) {
          carYear = carYearFromData;
        }
      }
    }
  }

  ///////////////////////////////////////////////////////////////////

//    new

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Car Details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: [
              Container(
                  child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8),
                          child: Text(
                            widget.carn,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.star_border_outlined)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        carYear,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),

                    //////////////IMAGE////////////
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 200,
                        width: 300,
                        color: Colors.blue,
                        child: Image.network(
                          imageUrls[
                              selectedImageIndex], // Display the selected image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 500,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageUrls
                            .length, // Use the length of imageUrls list
                        itemBuilder: (context, index) {
                          final imageUrl = imageUrls[index];

                          // Use the imageUrl to load and display the image
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImageIndex =
                                    index; // Update the selected image index
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.all(8),
                              color: selectedImageIndex == index
                                  ? Colors.teal // Highlight the selected image
                                  : null,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ); // You can customize the image widget as needed
                        },
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 10, right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Specifications",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.05),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  fontSize: size.width * 0.032,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            brand_card(
                              Title: 'Petrol',
                              image: 'assets/tesla.png',
                              press: () {},
                            ),
                            SizedBox(width: 25),
                            brand_card(
                              Title: 'Airbags',
                              image: 'assets/tesla.png',
                              press: () {},
                            ),
                            SizedBox(width: 25),
                            brand_card(
                              Title: 'Airbags',
                              image: 'assets/tesla.png',
                              press: () {},
                            ),
                            SizedBox(width: 25),
                            brand_card(
                              Title: 'Bluetooth',
                              image: 'assets/tesla.png',
                              press: () {},
                            ),
                            SizedBox(width: 25),
                            brand_card(
                              Title: 'Spare Tyre',
                              image: 'assets/tesla.png',
                              press: () {},
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Text(
                          "Booking Time",
                          style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.092,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red),
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.73,
                              height: size.height * 0.092,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 13),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          widget.sdate,
                                          style: TextStyle(
                                              fontSize: size.width * 0.035),
                                        ),
                                        Text(widget.stime,
                                            style: TextStyle(
                                                fontSize: size.width * 0.035)),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_sharp),
                                    Column(
                                      children: [
                                        Text(widget.edate,
                                            style: TextStyle(
                                                fontSize: size.width * 0.035)),
                                        Text(widget.etime,
                                            style: TextStyle(
                                                fontSize: size.width * 0.035)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Date(
                                          carn: widget.carn,
                                          id: widget.id,
                                          sharedCars: widget.sharedCars,
                                          cprice: widget.hprice,
                                        ),
                                      ));
                                },
                                child: Text(
                                  "EDIT",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.035),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Text(
                          "Renter Detail's",
                          style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Card(
                        elevation: 10,
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Container(
                            width: size.width * 0.88,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(himg),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Container(
                                        height: size.height * 0.035,
                                        child: Text(
                                          'hhaj',
                                          style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          hbio,
                                          style: TextStyle(
                                              fontSize: size.width * 0.035),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isExpanded = !isExpanded;
                                          });
                                        },
                                        child: Visibility(
                                          visible: !isExpanded,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              'Click to Expand',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: size.width * 0.035),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: isExpanded,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 16),
                                          child: Text(
                                            "With a strong background in computer science, he excels at problem-solving and thrives in collaborative environments.",
                                            style: TextStyle(
                                                fontSize: size.width * 0.035),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: isExpanded,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              'Click to Collapse',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: size.width * 0.035),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Text(
                          "Car Location",
                          style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Card(
                        elevation: 8,
                        child: Container(
                          height: size.height * 0.2,
                          width: size.width * 0.9,
                          child: Row(
                            children: [
                              Container(
                                width: size.width * 0.45,
                                child: Column(
                                  children: [
                                    Text(
                                      "Bandra West,\n Mumbai",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.035),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: size.height * 0.2,
                                width: size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  child: FlutterMap(
                                    options: MapOptions(
                                      center: LatLng(19.0607, 72.8361),
                                      zoom: 10,
                                    ),
                                    nonRotatedChildren: [
                                      RichAttributionWidget(
                                        attributions: [
                                          TextSourceAttribution(
                                            'OpenStreetMap contributors',
                                            onTap: () => launchUrl(Uri.parse(
                                                'https://openstreetmap.org/copyright')),
                                          ),
                                        ],
                                      ),
                                    ],
                                    children: [
                                      TileLayer(
                                        urlTemplate:
                                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        userAgentPackageName: 'com.example.app',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Text(
                          "Review",
                          style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 0,
                      child: Container(
                        height: size.height * 0.24,
                        width: size.width * 0.9,
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Reviewcon(
                                      Review:
                                          "Inception: Mind-blowing plot, stunning visuals, top-notch performances. Gripping story, breathtaking cinematography. A must-see for sci-fi enthusiasts. An unforgettable and immersive experience, leaving you pondering its intricacies and questioning reality.",
                                      Name: "-User56578"),
                                  //211 characters allowed including white spaces
                                  Reviewcon(
                                      Review:
                                          "Inception: Mind-blowing plot, stunning visuals, top-notch performances. Gripping story, breathtaking cinematography. A must-see for sci-fi enthusiasts. An unforgettable and immersive experience, leaving you pondering its intricacies and questioning reality.",
                                      Name: "-User56578"),
                                  Reviewcon(
                                      Review:
                                          "Inception: Mind-blowing plot, stunning visuals, top-notch performances. Gripping story, breathtaking cinematography. A must-see for sci-fi enthusiasts. An unforgettable and immersive experience, leaving you pondering its intricacies and questioning reality.",
                                      Name: "-User56578"),
                                  Reviewcon(
                                      Review:
                                          "Inception: Mind-blowing plot, stunning visuals, top-notch performances. Gripping story, breathtaking cinematography. A must-see for sci-fi enthusiasts. An unforgettable and immersive experience, leaving you pondering its intricacies and questioning reality.",
                                      Name: "-User56578"),
                                  Reviewcon(
                                      Review:
                                          "Inception: Mind-blowing plot, stunning visuals, top-notch performances. Gripping story, breathtaking cinematography. A must-see for sci-fi enthusiasts. An unforgettable and immersive experience, leaving you pondering its intricacies and questioning reality.",
                                      Name: "-User56578"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ]))),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Trip Protection Package",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "How Does it Work?",
                        style: TextStyle(color: Colors.red),
                      ),
                      Row(
                        children: [
                          Icon(Icons.security_sharp),
                          Text("Basic(Rs 999)")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.security_sharp),
                          Text("Standard(Rs 1999)")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.security_sharp),
                          Text("Premium(Rs 2999)")
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text(
                    "Policies",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.045),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(Icons.car_crash_sharp),
                            Text(
                              "Free Cancellation",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.04),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Zero Cancellation Fee till",
                          style: TextStyle(fontSize: size.width * 0.032),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: Text(
                          "18 July 2023,8:00 AM",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.034),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Quick Refund After Cancellation",
                          style: TextStyle(fontSize: size.width * 0.032),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 220),
                        child: Text(
                          "View Policy",
                          style: TextStyle(
                              color: Colors.blue, fontSize: size.width * 0.032),
                        ),
                      ),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(Icons.local_gas_station_sharp),
                            Text(
                              "Without Fuel",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.04),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20, right: 20),
                        child: Text(
                          "The Host will have the car filled with minimum fuel to get to the nearest fuel station.",
                          style: TextStyle(fontSize: size.width * 0.033),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 200.0, bottom: 0, top: 2),
                        child: Text(
                          "View Policy",
                          style: TextStyle(
                              color: Colors.blue, fontSize: size.width * 0.032),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Icon(Icons.pages_rounded),
                          Text(
                            " Agreement Policy",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.04),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "I hereby agree to the terms and conditions of the Lease agreement with Host",
                        style: TextStyle(fontSize: size.width * 0.035),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 200),
                      child: Text(
                        "See Details",
                        style: TextStyle(
                            color: Colors.blue, fontSize: size.width * 0.032),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
          Container(
            height: size.height * 0.12,
            width: size.width,
            child: BottomAppBar(
              child: Container(
                child: Column(
                  children: [
                    Text(widget.cprice.toString()),
                    ActionSlider.standard(
                      rolling: true,
                      height: 55,
                      width: size.width * 0.95,
                      child: const Text('Book Now!',
                          style: TextStyle(color: Colors.white, fontSize: 19)),
                      backgroundColor: Colors.black,
                      reverseSlideAnimationCurve: Curves.easeInOut,
                      reverseSlideAnimationDuration:
                          const Duration(milliseconds: 500),
                      toggleColor: Colors.purpleAccent,
                      icon: Image.asset(
                        "assets/tesla.png",
                        scale: 4,
                      ),
                      action: (controller) async {
                        controller.loading(); //starts loading animation
                        await Future.delayed(const Duration(seconds: 1));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bill(
                                    carname: widget.carn,
                                    cimage: imageUrls[0],
                                    carid: widget.id.toString(),
                                    tfare: widget.cprice.toDouble(),
                                    sdate: widget.sdate,
                                    edate: widget.edate,
                                  )),
                        ); //starts success animation
                        await Future.delayed(const Duration(seconds: 1));
                        controller.reset(); //resets the slider
                      },
                    )
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
