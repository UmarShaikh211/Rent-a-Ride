// import 'package:flutter/material.dart';
// import 'package:rentcartest/user/some.dart' as someApi;
//
// class DD extends StatefulWidget {
//   const DD({super.key});
//
//   @override
//   State<DD> createState() => _DDState();
// }
//
// class _DDState extends State<DD> {
//   List<Map<String, dynamic>> userCars = []; // List to store user's car objects
//   String? selectedCarId; // ID of the selected car object
//   @override
//   void initState() {
//     super.initState();
//     fetchUserCars(); // Fetch user's car objects
//   }
//
//   Future<void> fetchUserCars() async {
//     try {
//       print("Fetching user's car objects...");
//       userCars = await someApi.ApiService.getUserCars(widget.userId);
//       print("User's car objects fetched: $userCars");
//       setState(() {}); // Rebuild the UI to show the userCars
//     } catch (e) {
//       print("Error fetching user's car objects: $e");
//       // Handle errors when fetching user's car objects
//     }
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           DropdownButtonFormField<String>(
//             value: selectedCarId,
//             onChanged: (newValue) {
//               setState(() {
//                 selectedCarId = newValue;
//               });
//             },
//             items: userCars.map((car) {
//               final carId = car['id'].toString();
//               return DropdownMenuItem<String>(
//                 value: carId,
//                 child: Text('Car ID: $carId'),
//               );
//             }).toList(),
//             decoration: InputDecoration(
//               labelText: 'Select a car',
//               border: OutlineInputBorder(),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
