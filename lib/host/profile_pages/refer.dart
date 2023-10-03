// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class Refer extends StatefulWidget {
//   const Refer({Key? key});
//
//   @override
//   State<Refer> createState() => _ReferState();
// }
//
// class _ReferState extends State<Refer> {
//   TextEditingController link = TextEditingController();
//   String _link = "https://github.com/UmarShaikh211/Rent-a-Ride";
//
//   @override
//   void initState() {
//     super.initState();
//     // Set the text fields with recommended values initially
//     link.text = _link;
//   }
//
//   void _shareLink() async {
//     final String url = "https://github.com/UmarShaikh211/Rent-a-Ride";
//
//     try {
//       if (await canLaunch(url)) {
//         await launch(url);
//       } else {
//         throw 'Could not launch $url';
//       }
//     } catch (e) {
//       print('Error: $e');
//       // Handle the error as needed
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Refer App"),
//         backgroundColor: Colors.teal,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: _shareLink,
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             "Refer our App",
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: TextField(
//               controller: link,
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: "App Link",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//             onPressed: _shareLink,
//             child: Text("Share Link"),
//           ),
//         ],
//       ),
//     );
//   }
// }
