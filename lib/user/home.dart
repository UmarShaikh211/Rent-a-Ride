import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/user/car_detail.dart';
import 'package:rentcartest/user/car_list.dart';
import 'package:rentcartest/user/cart_model.dart';
import 'package:rentcartest/user/list.dart';
import 'package:rentcartest/user/navbar.dart';
import 'package:rentcartest/user/range.dart';
import 'package:rentcartest/user/searchdate.dart';
import 'package:rentcartest/user/widget.dart';
import 'dart:convert';

import '../backend.dart';
import 'date.dart';
import 'package:http/http.dart' as http;

import 'global.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> sharedCars = [];
  late Box<FavoriteCar> favoriteBox;
  String userId = "";
  //static const String apiUrl = 'http://172.20.10.3:8000/'; //Umar
  static const String apiUrl = 'http://192.168.0.120:8000/'; //Home
  // Create a Hive box to store favorite cars
  bool isCarFavorite = false;
  // Reference to the favorites box
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId!;
    openHiveBox(); // Ensure that openHiveBox is called
    fetchData();
  }

  Future<void> openHiveBox() async {
    try {
      favoriteBox = await Hive.openBox<FavoriteCar>('favorite_cars_$userId');
      setState(() {});
    } catch (e) {
      print('Error opening Hive box: $e');
    }
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

  Widget build(BuildContext context) {
    Key iconButtonKey = GlobalKey();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
                width: size.width * 0.9,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.red),
                child: Row(
                  children: [
                    Container(
                      width: size.width / 1.4,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Row(
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(
                              "assets/search.svg",
                              color: Colors.black,
                              height: 20,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Search()));
                            },
                          ),
                          Text("Search Location")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.001,
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/filter.svg",
                        color: Colors.black,
                        height: 30,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: CarouselSlider(
                  items: carouselItems,
                  options: CarouselOptions(
                    height: size.height * 0.29,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.decelerate,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Brands",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.045),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "View All",
                        style: TextStyle(
                            fontSize: size.width * 0.035, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      car_widget(
                        title: 'Toyota',
                        image: 'assets/tesla.png',
                      ),
                      SizedBox(width: 15),
                      car_widget(
                        title: 'Tesla',
                        image: 'assets/tesla.png',
                      ),
                      SizedBox(width: 15),
                      car_widget(
                        title: 'Tesla',
                        image: 'assets/tesla.png',
                      ),
                      SizedBox(width: 15),
                      car_widget(
                        title: 'Tesla',
                        image: 'assets/tesla.png',
                      ),
                      SizedBox(width: 15),
                      car_widget(
                        title: 'Tesla',
                        image: 'assets/tesla.png',
                      ),
                      SizedBox(width: 15),
                      car_widget(
                        title: 'Tesla',
                        image: 'assets/tesla.png',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Cars",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.045),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "View All",
                        style: TextStyle(
                            fontSize: size.width * 0.035, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
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
                        final hostBio = car['host_bio'];
                        final cprice = car['car_price'];

                        if (addedCars != null &&
                            addedCars.isNotEmpty &&
                            carImage != null &&
                            carImage.isNotEmpty) {
                          final brandName = addedCars[0]['CarBrand'];
                          final modelName = addedCars[0]['CarModel'];
                          final yearName = addedCars[0]['CarYear'];
                          final cityName = addedCars[0]['CarCity'];
                          final transName = addedCars[0]['CarTrans'];
/////////////////////////////////////////////////////////////////////////////////////
                          final carimg1 = carImage[0]['Image1'];

                          final price = cprice[0]['amount'];
                          final carId =
                              car['id']; // Add this line to get the car ID
                          print(carId);
                          // Check if the car is in favorites
////////////////////////////////////////////////////////////////////////////////////

                          return Center(
                            child: InkWell(
                              onTap: () {
                                print('Selected Car ID: $car');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Date(
                                      carn: brandName + ' ' + modelName,
                                      id: car['id'],
                                      sharedCars: sharedCars,
                                      cprice: price.toDouble(),
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    height: size.height * 0.35,
                                    width: size.width * 0.9,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: size.height * 0.25,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                carimg1,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(12),
                                              topLeft: Radius.circular(12),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                isCarFavorite
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_outline_sharp,
                                                color: isCarFavorite
                                                    ? Colors.red
                                                    : null,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isCarFavorite =
                                                      !isCarFavorite; // Toggle the favorite state

                                                  if (isCarFavorite) {
                                                    // Add the car to favorites
                                                    favoriteBox.put(
                                                      carId.toString(),
                                                      FavoriteCar(
                                                        name: brandName +
                                                            ' ' +
                                                            modelName,
                                                        image: carimg1,
                                                        location: cityName,
                                                        price: price.toDouble(),
                                                      ),
                                                    );
                                                  } else {
                                                    // Remove the car from favorites
                                                    favoriteBox.delete(
                                                        carId.toString());
                                                  }
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 20,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.53,
                                          ),
                                          child: Text(
                                            brandName + ' ' + modelName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.05,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.57,
                                          ),
                                          child: Divider(
                                            thickness: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.60,
                                            left: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_sharp,
                                                size: size.width * 0.05,
                                              ),
                                              Text(
                                                cityName,
                                                style: TextStyle(
                                                  fontSize: size.width * 0.035,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.04,
                                              ),
                                              Icon(
                                                Icons.gamepad,
                                                size: size.width * 0.05,
                                              ),
                                              Text(
                                                transName,
                                                style: TextStyle(
                                                  fontSize: size.width * 0.035,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                              ),
                                              Text(
                                                "\$" + price.toString() + "/Hr",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.width * 0.045,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteIconButton extends StatefulWidget {
  final bool isFavorite;
  final Function onPressed;

  FavoriteIconButton({required this.isFavorite, required this.onPressed});

  @override
  _FavoriteIconButtonState createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isFavorite ? Icons.favorite : Icons.favorite_outline_sharp,
        color: widget.isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        widget.onPressed();
        setState(() {}); // Force rebuild of the widget
      },
    );
  }
}
