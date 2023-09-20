import 'package:flutter/material.dart';
import 'package:rentcartest/user/widget.dart';

class Offer_settings extends StatefulWidget {
  const Offer_settings({Key? key}) : super(key: key);

  @override
  State<Offer_settings> createState() => _Offer_settingsState();
}

class _Offer_settingsState extends State<Offer_settings> {
  bool light1 = false;
  bool light2 = false;
  bool light3 = false;

  bool _isContainerVisible = false;
  bool _isContainerVisible2 = false;
  bool _isContainerVisible3 = false;

  double _currentSliderValue = 5;
  String _selectedButton = '';
  double _currentSliderValue2 = 5;
  String _selectedButton2 = '';
  double _currentSliderValue3 = 5;
  String _selectedButton3 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Offers"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.time_to_leave_outlined),
                  title: Text("Long Duration Offers"),
                  subtitle: Text(
                      "Set an offer for guests who are booking for longer duration"),
                  trailing: Switch(
                    value: light1,
                    activeColor: Colors.blueAccent,
                    onChanged: (bool value) {
                      setState(() {
                        light1 = value;
                        _isContainerVisible = value;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: _isContainerVisible,
                  child: Container(
                    width: 300,
                    height: 200,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Choose Minimum Duration"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Slider(
                          value: _currentSliderValue,
                          max: 15,
                          divisions: 15,
                          label:
                              _currentSliderValue.round().toString() + " Days",
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Choose discount percentage"),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton = '5%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton == '5%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton == '5%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('5%'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton = '10%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton == '10%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton == '10%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('10%'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton = '15%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton == '15%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton == '15%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('15%'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton = '20%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton == '20%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton == '20%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('20%'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.watch_later_outlined),
                  title: Text("Early Bird Offer"),
                  subtitle:
                      Text("Set an offer for guests booking well in advance"),
                  trailing: Switch(
                    value: light2,
                    activeColor: Colors.blueAccent,
                    onChanged: (bool value) {
                      setState(() {
                        light2 = value;
                        _isContainerVisible2 = value;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: _isContainerVisible2,
                  child: Container(
                    width: 300,
                    height: 200,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Choose Minimum Lead Time"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Slider(
                          value: _currentSliderValue2,
                          max: 15,
                          divisions: 15,
                          label:
                              _currentSliderValue2.round().toString() + " Days",
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue2 = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Choose discount percentage"),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton2 = '5%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton2 == '5%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton2 == '5%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('5%'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton2 = '10%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton2 == '10%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton2 == '10%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('10%'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton2 = '15%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton2 == '15%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton2 == '15%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('15%'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton2 = '20%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton2 == '20%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton2 == '20%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('20%'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.thumb_up_alt_outlined),
                  title: Text("Raise the Cost"),
                  subtitle: Text(
                      "Increase the price for the guest booking at the last moment"),
                  trailing: Switch(
                    value: light3,
                    activeColor: Colors.blueAccent,
                    onChanged: (bool value) {
                      setState(() {
                        light3 = value;
                        _isContainerVisible3 = value;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: _isContainerVisible3,
                  child: Container(
                    width: 300,
                    height: 200,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Choose Minimum Lead Time"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Slider(
                          value: _currentSliderValue3,
                          max: 15,
                          divisions: 15,
                          label:
                              _currentSliderValue3.round().toString() + " Hr",
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue3 = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Choose discount percentage"),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton3 = '5%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton3 == '5%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton3 == '5%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('5%'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton3 = '10%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton3 == '10%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton3 == '10%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('10%'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton3 = '15%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton3 == '15%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton3 == '15%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('15%'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedButton3 = '20%';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: _selectedButton3 == '20%'
                                      ? Colors.white
                                      : Colors.grey,
                                  onPrimary: _selectedButton3 == '20%'
                                      ? Colors.green
                                      : Colors.white,
                                  side: BorderSide(color: Colors.green),
                                ),
                                child: Text('20%'),
                              ),
                            ],
                          ),
                        )
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
                            onPressed: () {},
                            child: Text("Save"),
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
