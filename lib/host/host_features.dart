// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../user/global.dart';
// import '../user/widget.dart';
// import 'package:rentcartest/user/some.dart' as someApi;
//
// class HostFet extends StatefulWidget {
//   const HostFet({super.key});
//
//   @override
//   State<HostFet> createState() => _HostFetState();
// }
//
// class _HostFetState extends State<HostFet> {
//   String? carval;
//   bool isChecked = false;
//   int index = 0;
//   TextEditingController _textEditingController = TextEditingController();
//   String _hintText =
//       'The Bugatti Chiron is an extraordinary hypercar that epitomizes engineering excellence and '
//       'automotive artistry. This masterpiece of automotive engineering is powered by an '
//       '8.0-liter quad-turbocharged W16 engine, producing a mind-boggling 1,479 horsepower '
//       'and 1,600 Newton-meters of torque. The Chiron accelerates from 0 to 60 mph '
//       'in just under 2.5 seconds, making it one of the fastest production cars ever created.'
//       'However, exclusivity comes at a high price, as the Bugatti Chiron is'
//       ' one of the most expensive and rarest hypercars in the world, reserved '
//       'for a fortunate few who can afford its breathtaking capabilities and opulent luxury.';
//   int _currentValue = 0;
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
//   void _incrementValue() {
//     setState(() {
//       if (_currentValue < 6) {
//         _currentValue++;
//       }
//     });
//   }
//
//   void _decrementValue() {
//     setState(() {
//       if (_currentValue > 0) {
//         _currentValue--;
//       }
//     });
//   }
//
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Add Car Features"),
//         ),
//         body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Expanded(
//             child: ListView(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Container(
//                       width: 320,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20)),
//                       child: DropdownButtonFormField<String>(
//                         value: selectedCarId, // Use selectedCarId here
//                         onChanged: (newValue) {
//                           setState(() {
//                             selectedCarId = newValue;
//                           });
//                         },
//                         items: userCars.map((car) {
//                           final carId = car['id'].toString();
//                           return DropdownMenuItem<String>(
//                             value: carId,
//                             child: Text('Car ID: $carId'),
//                           );
//                         }).toList(),
//                         decoration: InputDecoration(
//                           labelText: 'Select a car',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     "Add Car Features",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: "Roboto",
//                         color: Colors.black),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 //Add Airbags
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Row(
//                     children: [
//                       Text("My Car has"),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30.0),
//                             gradient: LinearGradient(
//                               colors: [Colors.blue[500]!, Colors.pink[500]!],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.blueGrey.withOpacity(0.5),
//                                 spreadRadius: 2,
//                                 blurRadius: 4,
//                                 offset:
//                                     Offset(0, 2), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 highlightColor: Colors.transparent,
//                                 hoverColor: Colors.transparent,
//                                 onPressed: _decrementValue,
//                                 icon: Icon(
//                                   Icons.remove,
//                                   size: 13,
//                                 ),
//                                 color: Colors.white,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 3),
//                                 child: Text(
//                                   '$_currentValue',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 highlightColor: Colors.transparent,
//                                 hoverColor: Colors.transparent,
//                                 onPressed: _incrementValue,
//                                 icon: Icon(
//                                   Icons.add,
//                                   size: 13,
//                                 ),
//                                 color: _currentValue < 6
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Text("Airbags")
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     "Please select your available car features",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: "Roboto",
//                         color: Colors.black),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//
//                 Container(
//                   height: 500,
//                   width: 280,
//                   child: ListView.builder(
//                     itemCount: items.length,
//                     itemBuilder: (context, index) {
//                       return CheckboxListTile(
//                         title: Text(items[index]),
//                         value: checkedItems[index],
//                         onChanged: (value) {
//                           setState(() {
//                             checkedItems[index] = value ?? false;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     "Describe Your Car",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: "Roboto",
//                         color: Colors.black),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Container(
//                     width: 200,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.deepPurple),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Text(
//                         "Tell Your Guest about Your Car and it's Uniqueness! This will help the guests to "
//                         "choose your Car.",
//                         style: TextStyle(color: Colors.white, fontSize: 12),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(
//                   height: 20,
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Container(
//                     height: 300,
//                     alignment: Alignment.center,
//                     child: Column(children: [
//                       TextField(
//                         style: TextStyle(fontSize: 12),
//                         controller: _textEditingController,
//                         keyboardType: TextInputType.multiline,
//                         maxLines: 9,
//                         decoration: InputDecoration(
//                             hintText: _hintText,
//                             hintStyle: TextStyle(fontSize: 12),
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     width: 1, color: Colors.redAccent))),
//                       ),
//                       SizedBox(
//                         height: 50,
//                       )
//                     ]),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: 80,
//             width: 400,
//             child: BottomAppBar(
//               child: Container(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Card(
//                       child: Container(
//                           width: 320,
//                           height: 45,
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStatePropertyAll<Color>(
//                                         Colors.green)),
//                             onPressed: () {},
//                             child: Text("Save"),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ]));
//   }
// }
//
// List<String> items = [
//   "Airbags",
//   "Spare tire",
//   "Power windows",
//   "Power locks",
//   "Power mirrors",
//   "Cruise control",
//   "Bluetooth connectivity",
//   "USB ports",
//   "Keyless entry",
//   "Remote start",
//   "Adaptive cruise control",
//   "Automatic emergency braking",
//   "Panoramic sunroof",
//   "Pet-friendly"
// ];
