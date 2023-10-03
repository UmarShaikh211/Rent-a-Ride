// import 'package:flutter/material.dart';
// import 'some.dart';
//
// class NotificationPage extends StatefulWidget {
//   final Map<String, String?>
//       arguments; // Ensure the type here is Map<String, String>
//
//   NotificationPage({super.key, required this.arguments});
//
//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//   late String userId;
//   late String carId;
//
//   @override
//   void initState() {
//     super.initState();
//     userId = widget.arguments['userId']!;
//     carId = widget.arguments['carId']!;
//   }
//
//   TextEditingController notification1Controller = TextEditingController();
//   TextEditingController notification2Controller = TextEditingController();
//   TextEditingController notification3Controller = TextEditingController();
//   TextEditingController notification4Controller = TextEditingController();
//   TextEditingController notification5Controller = TextEditingController();
//
//   // Add more controllers for other notifications
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Notifications')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: notification1Controller,
//               decoration: InputDecoration(labelText: 'Notification 1'),
//             ),
//             TextField(
//               controller: notification2Controller,
//               decoration: InputDecoration(labelText: 'Notification 2'),
//             ),
//             TextField(
//               controller: notification3Controller,
//               decoration: InputDecoration(labelText: 'Notification 3'),
//             ),
//             TextField(
//               controller: notification4Controller,
//               decoration: InputDecoration(labelText: 'Notification 4'),
//             ),
//             TextField(
//               controller: notification5Controller,
//               decoration: InputDecoration(labelText: 'Notification 5'),
//             ),
//             // Add more TextFields for other notifications
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   final notification1 = notification1Controller.text;
//                   final notification2 = notification2Controller.text;
//                   final notification3 = notification3Controller.text;
//                   final notification4 = notification4Controller.text;
//                   final notification5 = notification5Controller.text;
//
//                   // You can similarly get other notification values from controllers
//
//                   await ApiService.createNotification(carId, notification1,
//                       notification2, notification3, notification4, notification5
//                       // Add other notifications
//                       );
//
//                   // Show success message or navigate to next page
//                 } catch (e) {
//                   // Show error message or handle errors
//                 }
//               },
//               child: Text('Add Notifications'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
