import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

import '../user/some.dart';
import 'package:http/http.dart' as http;

class HostBio extends StatefulWidget {
  final Map<String, String?>
      arguments; // Ensure the type here is Map<String, String>

  HostBio({super.key, required this.arguments});

  @override
  State<HostBio> createState() => _HostBioState();
}

class _HostBioState extends State<HostBio> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController gphone = TextEditingController();
  TextEditingController himage = TextEditingController();
  late String userId;
  late String carId;
  XFile? _pickedImage; // Declare _pickedImage here as an instance variable

  @override
  bool _isReadOnly = true;
  FocusNode _focusNode = FocusNode();
  TextEditingController _bio = TextEditingController();
  String? _biohint =
      "John is a 32-year-old software engineer based in San Francisco. He is passionate about coding and enjoys working on various projects, from web development to mobile apps. In his free time, John loves exploring new technologies and contributing to open-source projects."
      "He is also an avid traveler and enjoys hiking in the nearby mountains. John's friendly and approachable nature makes him a great team player, and he values collaboration in his professional and personal life. ";

  void initState() {
    userId = widget.arguments['userId']!;
    carId = widget.arguments['carId']!;
    _name = TextEditingController(text: 'Umar Shaikh');
    _email = TextEditingController(text: "xyz@gmail.com");

    _phone = TextEditingController(text: "+91 9833427514");
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = pickedImage;
    });
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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> addhostbio(
    String carId,
    String guestphone,
    String himgPath,
    String hbio,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://172.20.10.3:8000/hostbios/'),
      );

      request.fields.addAll({
        'car': carId,
        'Gphone': guestphone,
        'Hbio': hbio,
        // Add other fields as needed
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

      await addhostbio(carId, guestphone, himg, hbio);

      print('Bio saved successfully'); // Print success message

      // Show success message or navigate to the next page
    } catch (e) {
      print('Error saving bio: $e'); // Print error message
      // Show error message or handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Host Bio"),
          backgroundColor: Colors.teal,
        ),
        body: Column(children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    readOnly: true,
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        readOnly: _isReadOnly,
                        controller: _email,
                        focusNode:
                            _focusNode, // Assigning the focus node to the TextField
                        decoration: InputDecoration(
                          labelText: 'Email Id',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(_isReadOnly ? Icons.edit : Icons.save),
                        onPressed: _toggleEditable,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        readOnly: _isReadOnly,
                        controller: _phone,
                        focusNode:
                            _focusNode, // Assigning the focus node to the TextField
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(_isReadOnly ? Icons.edit : Icons.save),
                        onPressed: _toggleEditable,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: gphone,
                    decoration: InputDecoration(
                      labelText: 'Guest Supporrt Phone Number',
                      hintText: 'Guest will contact this number for queries',
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text("Insert host image"),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                            onPressed: _pickImage, child: Text("Gallery"))
                      ],
                    )),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextField(
                          style: TextStyle(fontSize: 12),
                          controller: _bio,
                          keyboardType: TextInputType.multiline,
                          maxLines: 9,
                          decoration: InputDecoration(
                              label: Text(
                                "Host Bio",
                                style: TextStyle(fontSize: 15),
                              ),
                              border: OutlineInputBorder(),
                              hintText: _biohint,
                              hintStyle: TextStyle(fontSize: 12),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent))),
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
                          width: 320,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.green)),
                            onPressed: _saveBio,
                            child: Text("Save"),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}

InputDecorationTheme customInputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.zero, // Customize the border radius as needed
    borderSide: BorderSide(
        color: Colors.blueAccent), // Customize the border color as needed
    gapPadding: 0,
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
