import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/host/host_features.dart';
import 'package:rentcartest/host/host_image.dart';
import 'package:rentcartest/host/host_rating.dart';
import 'package:rentcartest/user/widget.dart';
import 'host_bio.dart';
import 'host_drawer.dart';
import 'package:rentcartest/user/some.dart' as someApi;
import 'package:rentcartest/user/global.dart';

import 'host_home.dart'; // Make sure to import the UserData class

class HostAnl extends StatefulWidget {
  HostAnl({super.key});

  @override
  State<HostAnl> createState() => _HostAnlState();
}

class _HostAnlState extends State<HostAnl> {
  String? carval;
  List<Map<String, dynamic>> userCars = []; // List to store user's car objects
  String? selectedCarId; // ID of the selected car object

  @override
  void initState() {
    super.initState();

    // final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    // final userId = userProvider.userId;
    //
    // if (userId != null) {
    //   fetchUserCars(userId);
    // }
  }
  //
  // // Inside your _HostAnlState class
  // Future<void> fetchUserCars(String userId) async {
  //   try {
  //     print("Fetching user's car objects...");
  //
  //     if (userId != null) {
  //       print("User ID: $userId");
  //
  //       userCars = await someApi.ApiService.getUserCars(userId);
  //
  //       print("User's car objects fetched: $userCars");
  //
  //       if (userCars.isNotEmpty) {
  //         selectedCarId = userCars[0]['id'].toString();
  //         print("Selected car ID set: $selectedCarId");
  //       }
  //
  //       setState(() {});
  //     } else {
  //       print("User ID is null");
  //     }
  //   } catch (e) {
  //     print("Error fetching user's car objects: $e");
  //   }
  // }

  // void navigateToNotificationPage() {
  //   if (selectedCarId != null) {
  //     final userProvider =
  //         Provider.of<UserDataProvider>(context, listen: false);
  //     final userId = userProvider.userId;
  //
  //     Navigator.pushNamed(context, '/notification', arguments: {
  //       'userId': userId,
  //       'carId': selectedCarId!,
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please select a car')),
  //     );
  //   }
  // }

  void navigateToImagePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Hostimg(),
        ));
  }

  void navigateToBioPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HostBio(),
        ));
  }

  // String getCarNameById(String carId) {
  //   final car = userCars.firstWhere(
  //     (car) => car['id'].toString() == carId,
  //     orElse: () => {},
  //   );
  //
  //   if (car != null) {
  //     final addedCars = car['added_cars'] as List<dynamic>;
  //     if (addedCars.isNotEmpty) {
  //       final carBrand = addedCars[0]['CarBrand'];
  //       final carModel = addedCars[0]['CarModel'];
  //
  //       if (carBrand != null && carModel != null) {
  //         return '$carBrand $carModel';
  //       }
  //     }
  //   }
  //
  //   return 'Unknown Car';
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HostDraw(),
      appBar: AppBar(
        backgroundColor:
            Color.fromRGBO(254, 205, 59, 1.0), // Define your primary color
        foregroundColor: Colors.black,
        title: Text("DashBoard"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 320,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.teal,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Tips for Host",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      Text(
                        "Great Images + Great Price = Better Bookings",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20),
            //     child: Container(
            //       width: 320,
            //       decoration:
            //           BoxDecoration(borderRadius: BorderRadius.circular(20)),
            //       child: DropdownButtonFormField<String>(
            //         value: selectedCarId, // Use selectedCarId here
            //         onChanged: (newValue) {
            //           setState(() {
            //             selectedCarId = newValue;
            //           });
            //         },
            //         items: userCars.map((car) {
            //           final carId = car['id'].toString();
            //           final carName = getCarNameById(carId);
            //
            //           return DropdownMenuItem<String>(
            //             value: carId,
            //             child: Text('$carName'),
            //           );
            //         }).toList(),
            //         decoration: InputDecoration(
            //           labelText: 'Select a car',
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 250,
                    width: 320,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        InkWell(
                          onTap: navigateToImagePage,
                          child: ListTile(
                            horizontalTitleGap: 0,
                            leading: Icon(Icons.camera_enhance_sharp),
                            title: Text(
                              "Upload High Quality Car Images",
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(
                              "Get Car Images get upto 2 times more earnings. Click to Upload ",
                              style: TextStyle(fontSize: 10),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_sharp)),
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: // navigateToNotificationPage,
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HostRating()));
                          },
                          child: ListTile(
                            horizontalTitleGap: 0,
                            leading: Icon(Icons.star_half_sharp),
                            title: Text(
                              "Improve your Car Rating",
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(
                              "Ratings are a major factor for guests to choose your Car.",
                              style: TextStyle(fontSize: 10),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_sharp)),
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: navigateToBioPage,
                          child: ListTile(
                            horizontalTitleGap: 0,
                            leading: Icon(Icons.verified_user_outlined),
                            title: Text(
                              "Update your Host Bio",
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(
                              "Updated Profile Bio tells guest about youself and helps build trust.",
                              style: TextStyle(fontSize: 10),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_sharp)),
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
            // earn(),
            // SizedBox(
            //   height: 20,
            // ),
            // rate(),
          ],
        ),
      ),
    );
  }
}
