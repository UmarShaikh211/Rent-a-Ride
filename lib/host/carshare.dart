import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/host/profile_pages/carshare2.dart';
import 'package:rentcartest/user/some.dart' as someApi;

import '../user/global.dart';
import '../user/some.dart';

class ShareCar extends StatefulWidget {
  const ShareCar({super.key});

  @override
  State<ShareCar> createState() => _ShareCarState();
}

class _ShareCarState extends State<ShareCar> {
  List<Map<String, dynamic>> userCars = []; // List to store user's car objects
  String? selectedCarId; // ID of the selected car object

  @override
  void initState() {
    super.initState();

    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    final userId = userProvider.userId;

    if (userId != null) {
      fetchUserCars(userId);
    }
  }

  Future<void> fetchUserCars(String userId) async {
    try {
      print("Fetching user's car objects...");

      if (userId != null) {
        print("User ID: $userId");

        userCars = await someApi.ApiService.getUserCars(userId);

        print("User's car objects fetched: $userCars");

        if (userCars.isNotEmpty) {
          selectedCarId = userCars[0]['id'].toString();
          print("Selected car ID set: $selectedCarId");
        }

        setState(() {});
      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error fetching user's car objects: $e");
    }
  }

  Future<void> checkAndDisplayAllModelsFilled(int carId) async {
    try {
      final isAddCarFilled = await ApiService.checkAddCarFilled(carId);
      final isHostBioFilled = await ApiService.checkHostBioFilled(carId);
      final isCarImageFilled = await ApiService.checkCarImageFilled(carId);
      final isPriceFilled = await ApiService.checkPriceFilled(carId);

      if (isAddCarFilled &&
          isHostBioFilled &&
          isCarImageFilled &&
          isPriceFilled) {
        // All models are filled, navigate to the next page
        // Replace 'NextPage()' with the actual next page widget
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => CarShare2(
                  Carid: carId,
                )));
      } else {
        // Display individual error popup messages for unfilled models
        if (!isAddCarFilled) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("AddCar data is not filled.")));
        }
        if (!isHostBioFilled) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("HostBio is not filled.")));
        }
        if (!isCarImageFilled) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("CarImages are not uploaded.")));
        }
        if (!isPriceFilled) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Price is not given.")));
        }

        print("Not all required data is filled.");
      }
    } catch (e) {
      print("Error checking models data: $e");
    }
  }

  //
  // Future<void> updateIsShared() async {
  //   try {
  //     if (selectedCarId != null) {
  //       final isAddCarFilled =
  //           await someApi.ApiService.checkAddCarFilled(selectedCarId!);
  //       final isHostBioFilled =
  //           await someApi.ApiService.checkHostBioFilled(selectedCarId!);
  //       final isCarImageFilled =
  //           await someApi.ApiService.checkCarImageFilled(selectedCarId!);
  //       final isPriceFilled =
  //           await someApi.ApiService.checkPriceFilled(selectedCarId!);
  //
  //       print(isAddCarFilled);
  //       print(isHostBioFilled);
  //       print(isCarImageFilled);
  //       print(isPriceFilled);
  //
  //       if (isAddCarFilled &&
  //           isHostBioFilled &&
  //           isCarImageFilled &&
  //           isPriceFilled) {
  //         // All required data is filled, navigate to the next page
  //         Navigator.of(context).pushReplacement(CarShare2() as Route<Object?>);
  //       } else {
  //         // Display individual error popup messages for unfilled data
  //         if (!isAddCarFilled) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content:
  //                   Text("AddCar data is not filled for the selected car."),
  //             ),
  //           );
  //         }
  //         if (!isHostBioFilled) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text("HostBio is not filled for the selected car."),
  //             ),
  //           );
  //         }
  //         if (!isCarImageFilled) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text("CarImages not uploaded for the selected car."),
  //             ),
  //           );
  //         }
  //         if (!isPriceFilled) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text("Price not given for the selected car."),
  //             ),
  //           );
  //         }
  //
  //         print("Not all required data is filled.");
  //       }
  //     } else {
  //       print("Selected car ID is null.");
  //     }
  //   } catch (e) {
  //     print("Error updating isshared: $e");
  //   }
  // }
  String getCarNameById(String carId) {
    final car = userCars.firstWhere(
      (car) => car['id'].toString() == carId,
      orElse: () => {},
    );

    if (car != null) {
      final addedCars = car['added_cars'] as List<dynamic>;
      if (addedCars.isNotEmpty) {
        final carBrand = addedCars[0]['CarBrand'];
        final carModel = addedCars[0]['CarModel'];

        if (carBrand != null && carModel != null) {
          return '$carBrand $carModel';
        }
      }
    }

    return 'Unknown Car';
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: customInputDecorationTheme(),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.black,
            title: Text("Share Car"),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    width: 320,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: DropdownButtonFormField<String>(
                      value: selectedCarId,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCarId = newValue;
                        });
                      },
                      items: userCars.map((car) {
                        final carId = car['id'].toString();
                        final carName = getCarNameById(carId);

                        return DropdownMenuItem<String>(
                          value: carId,
                          child: Text('$carName'),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Select a car',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  checkAndDisplayAllModelsFilled(int.parse(selectedCarId!));
                },
                child: Text("Confirm"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.deepPurple)),
              )
            ],
          ),
        ));
  }
}

InputDecorationTheme customInputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // Customize the border radius as needed
    borderSide: BorderSide(
        color: Colors.deepPurple), // Customize the border color as needed
    gapPadding: 5,
  );
  return InputDecorationTheme(
    floatingLabelBehavior:
        FloatingLabelBehavior.auto, // Customize the label behavior if needed
    contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10), // Customize the content padding if needed
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
