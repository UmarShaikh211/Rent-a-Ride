// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<XFile>? _mediaFileList;
//
//   Future<void> _onImageButtonPressed(ImageSource source) async {
//     try {
//       final pickedFile = await ImagePicker().pickImage(source: source);
//       if (pickedFile != null) {
//         setState(() {
//           _mediaFileList = [pickedFile];
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _mediaFileList = null;
//       });
//     }
//   }
//
//   Widget _buildImagePreview() {
//     if (_mediaFileList != null && _mediaFileList!.isNotEmpty) {
//       return ListView.builder(
//         itemCount: _mediaFileList!.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Image.file(File(_mediaFileList![index].path));
//         },
//       );
//     } else {
//       return const Text(
//         'You have not yet picked an image.',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title ?? ''),
//       ),
//       body: Center(
//         child: _buildImagePreview(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _onImageButtonPressed(ImageSource.gallery);
//         },
//         tooltip: 'Pick Image from gallery',
//         child: const Icon(Icons.photo),
//       ),
//     );
//   }
// }
