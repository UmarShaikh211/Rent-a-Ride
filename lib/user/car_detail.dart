import 'dart:convert';

import 'package:action_slider/action_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentcartest/main.dart';
import 'package:rentcartest/user/image.dart';
import 'package:rentcartest/user/usertc.dart';
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
  String selectedPackage = "0";
  List<Review> reviews = [];
  double? totalRating = 0.0;
  List<Location> locations = [];
  @override
  void initState() {
    super.initState();
    fetchReviews();
    fetchTotalRating();
    fetchLocation(widget.id);

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
  Future<String> fetchUserName(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$globalapiUrl/users/$userId/'), // Replace with your API endpoint to fetch user details
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        final userName = userData['name'] ??
            'Anonymous'; // Assuming 'name' is the field for the user's name
        return userName;
      } else {
        // Handle error response
        return 'Anonymous'; // Default to 'Anonymous' if user details can't be fetched
      }
    } catch (e) {
      // Handle network or other errors
      return 'Anonymous'; // Default to 'Anonymous' in case of errors
    }
  }

  Future<void> fetchReviews() async {
    try {
      final response = await http.get(
        Uri.parse('$globalapiUrl/get_reviews_by_car_id/${widget.id}/'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<Review> fetchedReviews = [];
        print(fetchedReviews);

        for (final jsonReview in responseData) {
          final userId =
              jsonReview['user']; // Assuming this field contains the user ID
          final userName = await fetchUserName(userId.toString());
          print(userId);
          print(userName);

          fetchedReviews.add(
            Review(
              text: jsonReview['text'] ?? 'No review text available',
              userName: userId,
            ),
          );
        }

        setState(() {
          reviews = fetchedReviews;
        });
      } else {
        // Handle error response
        // You can display an error message or take appropriate action here.
      }
    } catch (e) {
      // Handle network or other errors
      // You can display an error message or take appropriate action here.
    }
  }

  Future<void> fetchTotalRating() async {
    final response = await http.get(
      Uri.parse('$globalapiUrl/cars/${widget.id}/total_rating/'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response: $data'); // Add this line for debugging
      final total = data['total_rating'] ?? 0.0;
      setState(() {
        totalRating = total.toDouble();
      });
    } else {
      print('API Error: ${response.statusCode} - ${response.body}');
      // Handle error
    }
  }

  Future<void> fetchLocation(int carId) async {
    final response = await http.get(Uri.parse(
        '$globalapiUrl/get_locations/${widget.id}/' // Replace with your Django API URL
        ));
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        locations = jsonData.map((item) => Location.fromJson(item)).toList();
      });
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load data');
    }
  }

  void _openFullScreenMap(
      BuildContext context, double latitude, double longitude) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Location'),
              foregroundColor: Colors.black,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: FlutterMap(
              options: MapOptions(
                center: LatLng(latitude, longitude),
                zoom: 15, // Adjust the zoom level as needed
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('Total Rating: $totalRating'); // Add this line for debugging

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Car Details"),
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(children: [
          Expanded(
            child: ListView(
              children: [
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 24.0, // Adjust the size as needed
                                  ),
                                  SizedBox(
                                      width:
                                          8.0), // Add some spacing between the star and rating
                                  Text(
                                    totalRating!.toStringAsFixed(
                                        1), // Format rating to one decimal place
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
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
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(20), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                20), // Rounded corners for child
                            child: Image.network(
                              imageUrls[
                                  selectedImageIndex], // Display the selected image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepPurple),
                            color: Color.fromRGBO(254, 205, 59, 1.0),
                          ),
                          height: 100,
                          width: 500,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageUrls.length,
                            itemBuilder: (context, index) {
                              final imageUrl = imageUrls[index];

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedImageIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                    color: selectedImageIndex == index
                                        ? Colors.deepPurple
                                        : Colors
                                            .white, // Highlight the selected image
                                    border: Border.all(
                                      color: Colors
                                          .deepPurple, // Border color for unselected images
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners for child
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 15, left: 10, right: 10, bottom: 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "Specifications",
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: size.width * 0.05),
                      //       ),
                      //       InkWell(
                      //         onTap: () {},
                      //         child: Text(
                      //           "View All",
                      //           style: TextStyle(
                      //               fontSize: size.width * 0.032,
                      //               color: Colors.blue),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     padding: EdgeInsets.all(10),
                      //     child: Row(
                      //       children: [
                      //         brand_card(
                      //           Title: 'Petrol',
                      //           image: 'assets/tesla.png',
                      //           press: () {},
                      //         ),
                      //         SizedBox(width: 25),
                      //         brand_card(
                      //           Title: 'Airbags',
                      //           image: 'assets/tesla.png',
                      //           press: () {},
                      //         ),
                      //         SizedBox(width: 25),
                      //         brand_card(
                      //           Title: 'Airbags',
                      //           image: 'assets/tesla.png',
                      //           press: () {},
                      //         ),
                      //         SizedBox(width: 25),
                      //         brand_card(
                      //           Title: 'Bluetooth',
                      //           image: 'assets/tesla.png',
                      //           press: () {},
                      //         ),
                      //         SizedBox(width: 25),
                      //         brand_card(
                      //           Title: 'Spare Tyre',
                      //           image: 'assets/tesla.png',
                      //           press: () {},
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      //
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
                              color: Colors.deepPurple),
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
                                                  fontSize:
                                                      size.width * 0.035)),
                                        ],
                                      ),
                                      Icon(Icons.arrow_forward_sharp),
                                      Column(
                                        children: [
                                          Text(widget.edate,
                                              style: TextStyle(
                                                  fontSize:
                                                      size.width * 0.035)),
                                          Text(widget.etime,
                                              style: TextStyle(
                                                  fontSize:
                                                      size.width * 0.035)),
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
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(254, 205, 59,
                                          1.0), // Set the background color
                                      onPrimary: Colors.black,
                                      side:
                                          BorderSide(color: Colors.deepPurple)),
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
                          elevation: 2,
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
                                            'Host',
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
                                    height: 5,
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
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     setState(() {
                                        //       isExpanded = !isExpanded;
                                        //     });
                                        //   },
                                        //   child: Visibility(
                                        //     visible: !isExpanded,
                                        //     child: Padding(
                                        //       padding: EdgeInsets.symmetric(
                                        //           horizontal: 16),
                                        //       child: Text(
                                        //         'Click to Expand',
                                        //         style: TextStyle(
                                        //             color: Colors.blue,
                                        //             fontSize:
                                        //                 size.width * 0.035),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        // Visibility(
                                        //   visible: isExpanded,
                                        //   child: Padding(
                                        //     padding: EdgeInsets.only(left: 16),
                                        //     child: Text(
                                        //       "With a strong background in computer science, he excels at problem-solving and thrives in collaborative environments.",
                                        //       style: TextStyle(
                                        //           fontSize: size.width * 0.035),
                                        //     ),
                                        //   ),
                                        // ),
                                        // Visibility(
                                        //   visible: isExpanded,
                                        //   child: GestureDetector(
                                        //     onTap: () {
                                        //       setState(() {
                                        //         isExpanded = !isExpanded;
                                        //       });
                                        //     },
                                        //     child: Padding(
                                        //       padding: EdgeInsets.symmetric(
                                        //           horizontal: 16),
                                        //       child: Text(
                                        //         'Click to Collapse',
                                        //         style: TextStyle(
                                        //             color: Colors.blue,
                                        //             fontSize:
                                        //                 size.width * 0.035),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
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

                      Container(
                        height: size.height * 0.22,
                        child: ListView.builder(
                          itemCount: locations.length,
                          itemBuilder: (context, index) {
                            final location = locations[index];
                            double latitude =
                                double.tryParse(location.lat) ?? 0.0;
                            double longitude =
                                double.tryParse(location.long) ?? 0.0;

                            return Center(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              location.address,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.width * 0.035),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _openFullScreenMap(
                                              context, latitude, longitude);
                                        },
                                        child: Container(
                                          height: size.height * 0.2,
                                          width: size.width * 0.45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15)),
                                            child: FlutterMap(
                                              options: MapOptions(
                                                center:
                                                    LatLng(latitude, longitude),
                                                zoom: 6,
                                              ),
                                              nonRotatedChildren: [
                                                RichAttributionWidget(
                                                  attributions: [
                                                    TextSourceAttribution(
                                                        'OpenStreetMap contributors',
                                                        onTap: () {
                                                      _openFullScreenMap(
                                                          context,
                                                          latitude,
                                                          longitude);
                                                    }),
                                                  ],
                                                ),
                                              ],
                                              children: [
                                                TileLayer(
                                                  urlTemplate:
                                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                  userAgentPackageName:
                                                      'com.example.app',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
                      //   Card(
                      //     elevation: 0,
                      //     child: Container(
                      //       height: size.height * 0.24,
                      //       width: size.width * 0.9,
                      //       child: Column(
                      //         children: [
                      //           SingleChildScrollView(
                      //             scrollDirection: Axis.horizontal,
                      //             child: Row(
                      //               children: [
                      //                 Reviewcon(
                      //                     Review:
                      //                         "Inception: Mind-blowing plot, stunning visuals, top-notch performances. Gripping story, breathtaking cinematography. A must-see for sci-fi enthusiasts. An unforgettable and immersive experience, leaving you pondering its intricacies and questioning reality.",
                      //                     Name: "-User56578"),
                      //                 //211 characters allowed including white spaces
                      //                 Reviewcon(
                      //                     Review:
                      //                         "Inception: Mind-blowing plot, stunning visuals, top-notch performances. Gripping story, breathtaking cinematography. A must-see for sci-fi enthusiasts. An unforgettable and immersive experience, leaving you pondering its intricacies and questioning reality.",
                      //                     Name: "-User56578"),
                      //                 Reviewcon(
                      //                     Review:
                      //                         "Inception: Mind-blowing plot, stunning visuals, top-notch performances. Gripping story, breathtaking cinematography. A must-see for sci-fi enthusiasts. An unforgettable and immersive experience, leaving you pondering its intricacies and questioning reality.",
                      //                     Name: "-User56578"),
                      //                 Reviewcon(
                      //                     Review:
                      //                         "Inception: Mind-blowing plot, stunning visuals, top-notch performances. Gripping story, breathtaking cinematography. A must-see for sci-fi enthusiasts. An unforgettable and immersive experience, leaving you pondering its intricacies and questioning reality.",
                      //                     Name: "-User56578"),
                      //                 Reviewcon(
                      //                     Review:
                      //                         "Inception: Mind-blowing plot, stunning visuals, top-notch performances. Gripping story, breathtaking cinematography. A must-see for sci-fi enthusiasts. An unforgettable and immersive experience, leaving you pondering its intricacies and questioning reality.",
                      //                     Name: "-User56578"),
                      //               ],
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   )

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 115,
                          width: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: reviews.length,
                            itemBuilder: (context, index) {
                              final review = reviews[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Reviewcon(
                                    Review: review.text,
                                    Name: '${review.userName}'),
                              );
                            },
                          ),
                        ),
                      ),
                    ]))),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.deepPurpleAccent,
                      )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            Text(
                              "Trip Protection Package",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            buildRadioListTile(
                              title: "Basic @499",
                              subtitle:
                                  "You Pay upto INR 4000 in \ncase of any damage",
                              value: "499",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            buildRadioListTile(
                              title: "Standard @999",
                              subtitle:
                                  "You Pay upto INR 1500 in \ncase of any damage",
                              value: "999",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            buildRadioListTile(
                              title: "Premium @1500",
                              subtitle:
                                  "You Pay upto INR 500 in \ncase of any damage",
                              value: "1500",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(children: [
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "The Host will have the car filled with minimum fuel to get to the nearest fuel station.",
                                    style:
                                        TextStyle(fontSize: size.width * 0.033),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 200.0,
                                    bottom: 0,
                                    top: 6,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UserTerms(),
                                          ));
                                    },
                                    child: Text(
                                      "View Policy",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: size.width * 0.032),
                                    ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                                      width: size.width * 0.19,
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
                                  style:
                                      TextStyle(fontSize: size.width * 0.035),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          Container(
            height: size.height * 0.1,
            width: size.width,
            child: BottomAppBar(
              child: Container(
                child: Column(
                  children: [
                    // Text(
                    //   widget.cprice.toString(),
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black,
                    //       fontSize: 15),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(254, 205, 59, 1.0),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ActionSlider.standard(
                        rolling: true,
                        height: 55,
                        width: size.width * 0.95,
                        child: const Text('Book Now',
                            style: TextStyle(
                                color: Color.fromRGBO(254, 205, 59, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: 19)),
                        backgroundColor: Colors.black87,
                        reverseSlideAnimationCurve: Curves.easeInOut,
                        reverseSlideAnimationDuration:
                            const Duration(milliseconds: 500),
                        toggleColor: Color.fromRGBO(254, 205, 59, 1.0),
                        icon: Image.asset(
                          "assets/wheel.png",
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
                                      dmgi: selectedPackage,
                                    )),
                          ); //starts success animation
                          await Future.delayed(const Duration(seconds: 1));
                          controller.reset(); //resets the slider
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]));
  }

  Widget buildRadioListTile({
    required String title,
    required String subtitle,
    required String value,
  }) {
    return RadioListTile<String>(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
      value: value,
      groupValue: selectedPackage,
      onChanged: (newValue) {
        setState(() {
          selectedPackage = newValue!;
        });
      },
    );
  }
}

class Review {
  final String text;
  final String userName;

  Review({required this.text, required this.userName});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      text: json['text'] ?? 'No review text available',
      userName:
          'Anonymous', // Default to 'Anonymous' in case user details are not fetched
    );
  }
}

class Location {
  final int id;
  final String lat;
  final String long;
  final String address;
  final bool isFilled;

  Location({
    required this.id,
    required this.lat,
    required this.long,
    required this.address,
    required this.isFilled,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      lat: json['lat'],
      long: json['long'],
      address: json['address'],
      isFilled: json['isFilled'],
    );
  }
}
