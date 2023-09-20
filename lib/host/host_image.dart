import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class Hostimg extends StatefulWidget {
  final Map<String, String?> arguments;
  Hostimg({super.key, required this.arguments});

  @override
  State<Hostimg> createState() => _HostimgState();
}

class _HostimgState extends State<Hostimg> {
  late String userId;
  late String carId;
  List<File> selectedImages = [];

  @override
  void initState() {
    super.initState();
    userId = widget.arguments['userId']!;
    carId = widget.arguments['carId']!;
  }

  List<XFile> cameraImages = [];

  /// Get from camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      // Save the captured image to the device's photo gallery
      final result = await ImageGallerySaver.saveFile(pickedFile.path);
      print(result); // This will print the result of the save operation

      setState(() {
        cameraImages.add(pickedFile);
      });
    }
  }

  /// Get from gallery
  _getFromGallery() async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
      maxWidth: 1800,
      maxHeight: 1800,
    );

    return pickedFiles ?? [];
  }

  void _openImageSheet() async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 210,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Add Photos",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Select how u would like to add the photo",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context); // Close the bottom sheet
                  List<XFile> pickedFiles = await _getFromGallery();

                  if (pickedFiles.isNotEmpty) {
                    selectedImages.addAll(
                        pickedFiles.map((pickedFile) => File(pickedFile.path)));
                    selectedImages.addAll(cameraImages
                        .map((pickedFile) => File(pickedFile.path)));

                    await Future.delayed(Duration(
                        milliseconds: 500)); // Allow animations to complete

                    if (selectedImages.length == 7) {
                      print('Selected Images Count: ${selectedImages.length}');

                      // Upload images to Django API and associate with carId
                      await uploadImages(selectedImages, carId);
                      selectedImages.clear();
                      cameraImages.clear();
                    } else {
                      print('You need to select exactly 7 images.');
                    }
                  }
                },
                child: ListTile(
                  leading: Icon(
                    Icons.image,
                  ),
                  title: Text(
                    "Gallery",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _getFromCamera();
                },
                child: ListTile(
                  leading: Icon(Icons.camera),
                  title: Text(
                    "Camera",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> uploadImages(List<File> images, String carId) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://172.20.10.3:8000/carimages/'),
    );

    for (int i = 0; i < images.length; i++) {
      var stream = http.ByteStream(images[i].openRead());
      var length = await images[i].length();

      var multipartFile = http.MultipartFile(
        'Image${i + 1}', // image1, image2, ..., image7
        stream,
        length,
        filename: 'Image$i.jpg',
      );

      request.files.add(multipartFile);
    }

    request.fields['car'] = carId;

    var response = await request.send();

    if (response.statusCode == 201) {
      print('Images uploaded successfully');
    } else {
      print('Failed to upload images');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${await response.stream.bytesToString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Images"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "4 Pro Tips:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 260,
                    width: 320,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent),
                    child: ListView(children: [
                      ListTile(
                        horizontalTitleGap: 0,
                        leading: Icon(Icons.brightness_high_outlined,
                            color: Colors.white),
                        title: Text(
                          "Shoot during Daytime",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        subtitle: Text(
                          "Daylight is Great for Pictures ",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        leading: Icon(Icons.camera_enhance_sharp,
                            color: Colors.white),
                        title: Text(
                          "Click a clear Picture",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        subtitle: Text(
                          "Avoid hazy/blur images of your Car",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        leading: Icon(Icons.camera_enhance_sharp,
                            color: Colors.white),
                        title: Text(
                          "Shoot all photos in LandScape mode",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        subtitle: Text(
                          "Guests see photos in LandScape mode only",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        leading: Icon(Icons.favorite, color: Colors.white),
                        title: Text(
                          "Keep backgorund & foreground clean",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        subtitle: Text(
                          "Make sure no objects come in front of the car",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(6)),
                            height: 100,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Make Your Car Stand Out!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(6)),
                            height: 100,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Great Images Get 2x More Views",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(6)),
                            height: 100,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Potential Earnings Uplift By 1.5x ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(6)),
                            height: 100,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Show Off Your Photography Skills",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //Referece Images

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(6)),
                          height: 110,
                          width: 130,
                          child: Column(
                            children: [
                              Container(
                                height: 90,
                                color: Colors.blue,
                              ),
                              Text(
                                "Front Diagonal Side",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(6)),
                          height: 110,
                          width: 130,
                          child: Column(
                            children: [
                              Container(
                                height: 90,
                                color: Colors.blue,
                              ),
                              Text(
                                "Front Diagonal Side",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(6)),
                          height: 110,
                          width: 130,
                          child: Column(
                            children: [
                              Container(
                                height: 90,
                                color: Colors.blue,
                              ),
                              Text(
                                "Front Diagonal Side",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(6)),
                          height: 110,
                          width: 130,
                          child: Column(
                            children: [
                              Container(
                                height: 90,
                                color: Colors.blue,
                              ),
                              Text(
                                "Front Diagonal Side",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "How to click pictures",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 250,
                    width: 330,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 80,
            width: 400,
            child: BottomAppBar(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Container(
                          width: 320,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.green)),
                            onPressed: () {
                              _openImageSheet();
                            },
                            child: Text("Add Photos"),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
