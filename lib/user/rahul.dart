// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:rentcartest/host/host_features.dart';
//
// import '../backend.dart';
// import 'car_detail.dart';
//
// class Rahul extends StatefulWidget {
//   const Rahul({super.key});
//
//   @override
//   State<Rahul> createState() => _RahulState();
// }
//
// class _RahulState extends State<Rahul> {
//   PopCar pCarPop = PopCar();
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         child: FutureBuilder<dynamic>(
//           future: pCarPop.postPopCar(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             } else if (snapshot.hasData) {
//               var data = snapshot.data;
//               return ListView.builder(
//                 itemCount: data.length,
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 itemBuilder: (context, index) {
//                   Map<String, dynamic> item = data[index];
//                   if (item is Map<String, dynamic>) {
//                     return Center(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Car_detail()));
//                         },
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(15)),
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             height: size.height * 0.33,
//                             width: size.width * 0.9,
//                             child: Stack(
//                               children: [
//                                 Image.network(
//                                   item['Photo'],
//                                   fit: BoxFit.fill,
//                                   height: size.height * 0.25,
//                                   width: size.width,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           IconButton(
//                                             onPressed: () {},
//                                             icon: Icon(
//                                               Icons.star_border_purple500_sharp,
//                                               size: 20,
//                                             ),
//                                           ),
//                                           Text("5.0"),
//                                         ],
//                                       ),
//                                     ),
//                                     IconButton(
//                                       onPressed: () {},
//                                       icon: Icon(Icons.favorite_outline_sharp),
//                                     ),
//                                   ],
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 20,
//                                       top: MediaQuery.of(context).size.width *
//                                           0.45),
//                                   child: Text(
//                                     item['Name'],
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: size.width * 0.05),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       top: MediaQuery.of(context).size.width *
//                                           0.52),
//                                   child: Divider(
//                                     thickness: 1,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       top: MediaQuery.of(context).size.width *
//                                           0.57,
//                                       left: 10),
//                                   child: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.location_on_sharp,
//                                         size: size.width * 0.05,
//                                       ),
//                                       Text(
//                                         item['City'],
//                                         style: TextStyle(
//                                             fontSize: size.width * 0.035),
//                                       ),
//                                       SizedBox(
//                                         width: size.width * 0.04,
//                                       ),
//                                       Icon(
//                                         Icons.gamepad,
//                                         size: size.width * 0.05,
//                                       ),
//                                       Text(
//                                         item['Transmission'],
//                                         style: TextStyle(
//                                             fontSize: size.width * 0.035),
//                                       ),
//                                       SizedBox(
//                                         width: size.width * 0.15,
//                                       ),
//                                       Text(
//                                         item['Price'].toString(),
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: size.width * 0.045),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               );
//             } else {
//               return const Center(
//                 child: Text('Invalid data format'),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
