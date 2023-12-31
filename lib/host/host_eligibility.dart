import 'package:action_slider/action_slider.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:rentcartest/host/host_home.dart';
import 'package:rentcartest/host/host_navbar.dart';
import 'package:rentcartest/host/carbrandsheet.dart';
import 'package:rentcartest/host/profile_pages/carmodelsheet.dart';
import 'package:rentcartest/host/profile_pages/carvariantsheet.dart';

import '../user/some.dart';
import '../user/widget.dart';
import 'package:http/http.dart' as http;

class HostEli extends StatefulWidget {
  final Map<String, String> arguments; // Change the argument type

  const HostEli({super.key, required this.arguments});

  @override
  State<HostEli> createState() => _HostEliState();
}

class _HostEliState extends State<HostEli> {
  late String userId;
  late String carId;
  late String licenses;
// Normal Code
  TextEditingController _license = TextEditingController();
  String? selectedBrand;
  TextEditingController _carmodel = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _textEditingController = TextEditingController();
  String? selectedCity;
  String? selectedYear;
  int selectedButtonIndex = 0;
  bool isPressedManual = false;
  bool isPressedAutomatic = false;
  bool isPressed5 = false;
  bool isPressed7 = false;
  double _currentSliderValue = 20;
  int daysButtonIndex = 0;
  bool isChecked = false;
  TextEditingController _carchassis = TextEditingController();

  void _onCarBrandSelected(String selectedCarBrand) {
    setState(() {
      // Update your selectedCarBrand variable with the selected value
      selectedBrand = selectedCarBrand;
      // Set the selected brand to the _readbrand TextField
    });
  }

  //
  // void submitForm() async {
  //   String License = widget.data ?? 'MH034TZ3243';
  //   String CarBrand =
  //       selectedBrand ?? ''; // Update with the actual selected brand
  //   String CarModel = selectedModel ?? '';
  //   String CarVariant = selectedVariant ?? '';
  //   String CarCity = selectedCity ?? ''; // Update with the actual selected city
  //   String CarYear = selectedYear ?? ''; // Update with the actual selected year
  //   String CarFuel = selectedButtonIndex == 0
  //       ? 'Petrol'
  //       : selectedButtonIndex == 1
  //           ? 'Diesel'
  //           : selectedButtonIndex == 2
  //               ? 'Electric'
  //               : '';
  //   String CarTrans = isPressedManual
  //       ? 'Manual'
  //       : isPressedAutomatic
  //           ? 'Automatic'
  //           : '';
  //   int CarKm = _currentSliderValue.toInt();
  //   String CarChassisNo = _carchassis.text;
  //   String CarShare = daysButtonIndex == 0
  //       ? '0-10'
  //       : daysButtonIndex == 1
  //           ? '10-20'
  //           : daysButtonIndex == 2
  //               ? '20-25'
  //               : daysButtonIndex == 3
  //                   ? '25+'
  //                   : '';
  //
  //   // Check if terms and conditions are accepted
  //   if (!isChecked) {
  //     print('Please accept the Terms & Conditions.');
  //     return;
  //   }
  //
  //   String apiUrl = "http://192.168.0.120:8000/AddCar/";
  //
  //   try {
  //     var response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: {
  //         'License': License,
  //         'CarBrand': CarBrand,
  //         'CarModel': CarModel,
  //         'CarVariant': CarVariant,
  //         'CarCity': CarCity,
  //         'CarYear': CarYear,
  //         'CarFuel': CarFuel,
  //         'CarTrans': CarTrans,
  //         'CarKm': CarKm.toString(),
  //         'CarChassisNo': CarChassisNo,
  //         'CarShare': CarShare,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print("Data Saved successfully");
  //
  //       // Clear fields and update data list if needed
  //       setState(() {
  //         _textEditingController.clear();
  //         _carchassis.clear();
  //         selectedBrand = null;
  //         selectedModel = null;
  //         selectedVariant = null;
  //         selectedCity = null;
  //         selectedYear = null;
  //         selectedButtonIndex = 0;
  //         isPressedManual = false;
  //         isPressedAutomatic = false;
  //         _currentSliderValue = 20;
  //         daysButtonIndex = 0;
  //         isChecked = false;
  //
  //         // Update your userDataList if required
  //         // userDataList.add({
  //         //   'license': licenses,
  //         //   'carbrand': carBrand,
  //         //   'carmodel': carModel,
  //         //   'carcity': carCity,
  //         //   // ... add other fields here
  //         // });
  //       });
  //     } else {
  //       print('Error saving data');
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    userId = widget.arguments['userId']!;
    carId = widget.arguments['carId']!;
  }

  void submitform() async {
    try {
      final license = widget.arguments['licenses'] ?? 'MH034TZ3243';
      final carBrand =
          selectedBrand ?? ''; // Update with the actual selected brand
      String carModel = _carmodel.text ?? " ";
      String carCity =
          selectedCity ?? ''; // Update with the actual selected city
      String carYear =
          selectedYear ?? ''; // Update with the actual selected year
      String carFuel = selectedButtonIndex == 0
          ? 'Petrol'
          : selectedButtonIndex == 1
              ? 'Diesel'
              : selectedButtonIndex == 2
                  ? 'Electric'
                  : '';
      String carTrans = isPressedManual
          ? 'Manual'
          : isPressedAutomatic
              ? 'Automatic'
              : '';
      String carSeat = isPressed5
          ? '5 Seater'
          : isPressedAutomatic
              ? '7 Seater'
              : '';
      int carKm = _currentSliderValue.toInt();
      String carChassisNo = _carchassis.text;

      // Check if terms and conditions are accepted
      if (!isChecked) {
        print('Please accept the Terms & Conditions.');
        return;
      }
      await ApiService.addnewcarData(carId, license, carBrand, carModel,
          carCity, carYear, carFuel, carTrans, carSeat, carKm, carChassisNo);

      // Show success message or navigate to next page
    } catch (e) {
      // Show error message or handle errors
    }
  }

  Widget build(BuildContext context) {
    List<String> yearsList = generateYearsList();
    Size size = MediaQuery.of(context).size;

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: customInputDecorationTheme(),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Add Car"),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        height: 230,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: widget.arguments['licenses'],
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.black),
                                  labelText: 'License',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid license';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CarBrandSheet(
                              onCarBrandSelected: _onCarBrandSelected,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: _carmodel,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.black),
                                  labelText: 'Car Model',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a car model';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: DropdownButtonFormField(
                        focusColor: Colors.white,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: 'City',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a city';
                          }
                          return null;
                        },
                        value: selectedCity,
                        items: cities.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCity = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: DropdownButtonFormField(
                        focusColor: Colors.white,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: 'Year of Registration',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a year';
                          }
                          return null;
                        },
                        value: selectedYear,
                        items: yearsList.map((year) {
                          return DropdownMenuItem(
                            value: year,
                            child: Text(year),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedYear = value as String?;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Fuel Type",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FuelBut(
                          label: "Petrol",
                          isSelected: selectedButtonIndex == 0,
                          onPressed: () {
                            setState(() {
                              selectedButtonIndex = 0;
                            });
                          },
                        ),
                        SizedBox(width: 18),
                        FuelBut(
                          label: "Diesel",
                          isSelected: selectedButtonIndex == 1,
                          onPressed: () {
                            setState(() {
                              selectedButtonIndex = 1;
                            });
                          },
                        ),
                        SizedBox(width: 18),
                        FuelBut(
                          label: "Electric",
                          isSelected: selectedButtonIndex == 2,
                          onPressed: () {
                            setState(() {
                              selectedButtonIndex = 2;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Transmission Type",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isPressedManual = !isPressedManual;
                              if (isPressedManual) {
                                isPressedAutomatic =
                                    false; // Set other button state to false
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: isPressedManual
                                ? Colors.deepPurple
                                : Theme.of(context).primaryColor,
                            backgroundColor: isPressedManual
                                ? Theme.of(context).primaryColor
                                : Colors.deepPurple,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, left: 18, right: 18),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.home_sharp),
                                SizedBox(height: 8),
                                Text("Manual"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 18),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isPressedAutomatic = !isPressedAutomatic;
                              if (isPressedAutomatic) {
                                isPressedManual =
                                    false; // Set other button state to false
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: isPressedAutomatic
                                ? Colors.deepPurple
                                : Theme.of(context).primaryColor,
                            backgroundColor: isPressedAutomatic
                                ? Theme.of(context).primaryColor
                                : Colors.deepPurple,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, left: 15, right: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.home_sharp),
                                SizedBox(height: 8),
                                Text("Automatic"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Seats",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isPressed5 = !isPressed5;
                              if (isPressed5) {
                                isPressed7 =
                                    false; // Set other button state to false
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: isPressed5
                                ? Colors.deepPurple
                                : Theme.of(context).primaryColor,
                            backgroundColor: isPressed5
                                ? Theme.of(context).primaryColor
                                : Colors.deepPurple,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, left: 18, right: 18),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.home_sharp),
                                SizedBox(height: 8),
                                Text("5 Seats"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 18),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isPressed7 = !isPressed7;
                              if (isPressed7) {
                                isPressed5 =
                                    false; // Set other button state to false
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: isPressed7
                                ? Colors.deepPurple
                                : Theme.of(context).primaryColor,
                            backgroundColor: isPressed7
                                ? Theme.of(context).primaryColor
                                : Colors.deepPurple,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, left: 15, right: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.home_sharp),
                                SizedBox(height: 8),
                                Text("7 Seater"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Car Km Driven",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Slider(
                      value: _currentSliderValue,
                      max: 100000,
                      divisions: 100,
                      activeColor: Colors.deepPurpleAccent,
                      inactiveColor: Theme.of(context).primaryColor,
                      label: _currentSliderValue.round().toString() + " Km",
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Approx Km Driven",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: _carchassis,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: 'Chassis Number',
                          hintText: 'Enter Chassis Number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Car Chassis No';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "You can find the chassis number\n(17 digit number) on your RC Card.",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "I accept Terms & Conditions",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.10,
                width: size.width,
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
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(254, 205, 59,
                                        1.0), // Set the background color
                                    onPrimary: Colors.black,
                                    side: BorderSide(color: Colors.deepPurple)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                      isChecked) {
                                    // Form is valid and checkbox is checked, proceed with form submission
                                    submitform();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HostNav()));
                                  } else {
                                    // Display an error message if checkbox is not checked
                                    if (!isChecked) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please accept the Terms & Conditions.'),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text("SUBMIT",
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
            ],
          ),
        ),
      ),
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
