// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// import 'global.dart';
// import 'package:rentcartest/user/some.dart' as someApi;
//
// class CarFeature {
//   String name;
//   String imageUrl;
//   bool isSelected;
//
//   CarFeature(
//       {required this.name, required this.imageUrl, this.isSelected = false});
// }
//
// class CarFeatureForm extends StatefulWidget {
//   const CarFeatureForm({Key? key}) : super(key: key);
//
//   @override
//   _CarFeatureFormState createState() => _CarFeatureFormState();
// }
//
// class _CarFeatureFormState extends State<CarFeatureForm> {
//   List<Map<String, dynamic>> userCars = []; // List to store user's car objects
//   String? selectedCarId; // ID of the selected car object
//
//   @override
//   void initState() {
//     super.initState();
//
//     final userProvider = Provider.of<UserDataProvider>(context, listen: false);
//     final userId = userProvider.userId;
//
//     if (userId != null) {
//       fetchUserCars(userId);
//     }
//   }
//
//   // Inside your _HostAnlState class
//   Future<void> fetchUserCars(String userId) async {
//     try {
//       print("Fetching user's car objects...");
//
//       if (userId != null) {
//         print("User ID: $userId");
//
//         userCars = await someApi.ApiService.getUserCars(userId);
//
//         print("User's car objects fetched: $userCars");
//
//         if (userCars.isNotEmpty) {
//           selectedCarId = userCars[0]['id'].toString();
//           print("Selected car ID set: $selectedCarId");
//         }
//
//         setState(() {});
//       } else {
//         print("User ID is null");
//       }
//     } catch (e) {
//       print("Error fetching user's car objects: $e");
//     }
//   }
//
//   List<CarFeature> features = [
//     CarFeature(name: 'Airbag', imageUrl: 'assets/bar.png'),
//     CarFeature(name: 'Bluetooth', imageUrl: 'assets/tesla.png'),
//     // Add more features as needed
//   ];
//
//   Future<void> _submitForm() async {
//     final selectedFeatures =
//         features.where((feature) => feature.isSelected).toList();
//
//     for (final feature in selectedFeatures) {
//       final url =
//           Uri.parse('http://172.20.10.3:8000/car_features/create_car_feature/');
//       final response = await http.post(
//         url,
//         body: {
//           'car': selectedCarId.toString(),
//           'name': feature.name,
//           'image': feature.imageUrl,
//         },
//       );
//
//       if (response.statusCode == 201) {
//         // Feature created successfully
//         // You can handle the response data as needed
//       } else {
//         // Handle error
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Car Features'),
//       ),
//       body: ListView.builder(
//         itemCount: features.length,
//         itemBuilder: (context, index) {
//           final feature = features[index];
//           return ListTile(
//             leading: Image.asset(
//                 feature.imageUrl), // Replace with your image loading logic
//             title: Text(feature.name),
//             trailing: Checkbox(
//               value: feature.isSelected,
//               onChanged: (value) {
//                 setState(() {
//                   feature.isSelected = value ?? false;
//                 });
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: ElevatedButton(
//         onPressed: () {
//           _submitForm();
//         },
//         child: Text('Save'),
//       ),
//     );
//   }
// }
