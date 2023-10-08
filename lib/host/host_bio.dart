import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/host/host_analytics.dart';
import 'package:rentcartest/host/host_navbar.dart';
import 'package:rentcartest/main.dart';

import '../user/global.dart';
import '../user/some.dart';
import 'package:http/http.dart' as http;
import 'package:rentcartest/user/some.dart' as someApi;

class HostBio extends StatefulWidget {
  const HostBio({Key? key}) : super(key: key);

  @override
  State<HostBio> createState() => _HostBioState();
}

class _HostBioState extends State<HostBio> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController gphone = TextEditingController();
  TextEditingController himage = TextEditingController();
  List<Map<String, dynamic>> userCars = [];
  String? selectedCarId = '';
  String? userId;
  XFile? _pickedImage; // Declare _pickedImage here as an instance variable
  Widget? _displayedImage;
  final _phoneFormatter = FilteringTextInputFormatter.digitsOnly;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  bool _isReadOnly = true;
  FocusNode _focusNode = FocusNode();
  TextEditingController _bio = TextEditingController();
  String? _biohint =
      "John is a 32-year-old software engineer based in San Francisco. He is passionate about coding and enjoys working on various projects, from web development to mobile apps. In his free time, John loves exploring new technologies and contributing to open-source projects."
      "He is also an avid traveler and enjoys hiking in the nearby mountains. John's friendly and approachable nature makes him a great team player, and he values collaboration in his professional and personal life. ";

  void initState() {
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId;

    if (userId != null) {
      fetchUserCars(userId!);
    }
    _name = TextEditingController(text: 'Umar Shaikh');
    _email = TextEditingController(text: "xyz@gmail.com");

    _phone = TextEditingController(text: "+91 9833427514");
    super.initState();
  }

  Future<void> fetchUserCars(String userId) async {
    try {
      print("Fetching user's car objects...");

      if (userId != null) {
        print("User ID: $userId");

        userCars = await someApi.ApiService.getUserCars(userId);

        print("User's car objects fetched: $userCars");

        if (userCars.isNotEmpty) {
          setState(() {
            selectedCarId = userCars[0]['id'].toString();
          });
        }
      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error fetching user's car objects: $e");
    }
  }

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

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
        _displayedImage = Container(
          width: 120, // Adjust the width and height as needed
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: FileImage(File(pickedImage.path)),
              fit: BoxFit.cover,
            ),
          ),
        ); // Display the picked image in a rounded container with BoxFit.cover
      });
    }
  }

  void _toggleEditable() {
    setState(() {
      _isReadOnly = !_isReadOnly;
      if (!_isReadOnly) {
        // Request focus for the TextField's label when "Edit" button is pressed.
        _focusNode.requestFocus();
      }
    });
  }

  String? _validateGuestPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Guest phone number is required.';
    }
    if (value.length != 10) {
      return 'Guest phone number must be 10 digits.';
    }
    if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
      return 'Guest phone number must contain only digits.';
    }
    return null;
  }

  String? _validateBio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Guest phone number is required.';
    }
    return null;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> addhostbio(
    String carId,
    String userId,
    String guestphone,
    String himgPath,
    String hbio,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$globalapiUrl/hostbios/'),
      );

      request.fields.addAll({
        'car': carId,
        'user': userId,
        'Gphone': guestphone,
        'Hbio': hbio,
        // Add othe fields as needed
      });

      if (_pickedImage != null) {
        var pickedImageBytes = await _pickedImage!.readAsBytes();

        request.files.add(http.MultipartFile.fromBytes(
          'Himage',
          pickedImageBytes,
          filename: 'picked_image.jpg', // Provide a filename
          contentType:
              MediaType('image', 'jpeg'), // Adjust content type if needed
        ));
      }

      var bioResponse = await request.send();

      if (bioResponse.statusCode != 201) {
        throw Exception('Failed to add hostbio');
      }
    } catch (e) {
      print('Error in addhostbio function: $e');
      rethrow;
    }
  }

  Future<void> _saveBio() async {
    try {
      final guestphone = gphone.text;
      final himg = _pickedImage?.path ?? ''; // Use the picked image path
      final hbio = _bio.text;

      print('Guest Phone: $guestphone');
      print('Host Image: $himg');
      print('Host Bio: $hbio');

      await addhostbio(selectedCarId!, userId!, guestphone, himg, hbio);

      print('Bio saved successfully'); // Print success message
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HostNav(),
          ));
      // Show success message or navigate to the next page
    } catch (e) {
      print('Error saving bio: $e'); // Print error message
      // Show error message or handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: customInputDecorationTheme(),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Host Bio"),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.black,
          ),
          body: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Container(
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: selectedCarId,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCarId = newValue;
                                print("My problem" + selectedCarId!);
                              });
                            },
                            items: userCars.map((car) {
                              final carId = car['id'].toString();
                              final carName = getCarNameById(carId);
                              return DropdownMenuItem<String>(
                                  value: carId, child: Text('$carName'));
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: gphone,
                        inputFormatters: [_phoneFormatter],
                        decoration: InputDecoration(
                          labelText: 'Guest Support Phone Number',
                          hintText:
                              'Guest will contact this number for queries',
                          hintStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: _validateGuestPhone,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // Display picked image if available

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          if (_displayedImage != null) _displayedImage!,
                          if (_pickedImage == null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Insert Host Image"),
                            ),
                          SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(254, 205, 59, 1.0),
                              onPrimary: Colors.black,
                              side: BorderSide(color: Colors.deepPurple),
                            ),
                            onPressed: _pickImage,
                            child: Text("Gallery"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(fontSize: 12),
                              controller: _bio,
                              keyboardType: TextInputType.multiline,
                              maxLines: 9,
                              decoration: InputDecoration(
                                  label: Text(
                                    "Host Bio",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: _biohint,
                                  hintStyle: TextStyle(fontSize: 12),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.redAccent))),
                              validator: _validateBio, // Add validation here
                            ),
                          ],
                        ),
                      ),
                    ),
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
                              width: 300,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(254, 205, 59,
                                        1.0), // Set the background color
                                    onPrimary: Colors.black,
                                    side: BorderSide(color: Colors.deepPurple)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _saveBio();
                                  } else {
                                    setState(() {
                                      _autoValidate = true;
                                    });
                                  }
                                },
                                child: Text("SAVE",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * 0.06)),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          )),
    );
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

//EXTRA
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 30),
// child: TextField(
// readOnly: true,
// controller: _name,
// decoration: InputDecoration(
// labelText: 'Name',
// border: OutlineInputBorder(),
// ),
// ),
// ),
// SizedBox(
// height: 30,
// ),
// Stack(
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 30),
// child: TextField(
// readOnly: _isReadOnly,
// controller: _email,
// focusNode:
// _focusNode, // Assigning the focus node to the TextField
// decoration: InputDecoration(
// labelText: 'Email Id',
// border: OutlineInputBorder(),
// ),
// ),
// ),
// Positioned(
// top: 0,
// right: 0,
// child: IconButton(
// icon: Icon(_isReadOnly ? Icons.edit : Icons.save),
// onPressed: _toggleEditable,
// ),
// ),
// ],
// ),
// SizedBox(
// height: 30,
// ),
// Stack(
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 30),
// child: TextField(
// readOnly: _isReadOnly,
// controller: _phone,
// focusNode:
// _focusNode, // Assigning the focus node to the TextField
// decoration: InputDecoration(
// labelText: 'Phone Number',
// border: OutlineInputBorder(),
// ),
// ),
// ),
// Positioned(
// top: 0,
// right: 0,
// child: IconButton(
// icon: Icon(_isReadOnly ? Icons.edit : Icons.save),
// onPressed: _toggleEditable,
// ),
// ),
// ],
// ),
// SizedBox(
// height: 30,
// ),
