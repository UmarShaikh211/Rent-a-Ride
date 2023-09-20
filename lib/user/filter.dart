import 'package:flutter/material.dart';
import 'package:rentcartest/user/widget.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  int Sortindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Sort and Filter"),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Sort By"),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: FilBut(
                            text: "Relevance",
                            isSelected: Sortindex == 0,
                            onPressed: () {
                              setState(() {
                                Sortindex = 0;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: FilBut(
                          text: "Low-High",
                          isSelected: Sortindex == 1,
                          onPressed: () {
                            setState(() {
                              Sortindex = 1;
                            });
                          },
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: FilBut(
                          text: "High-Low",
                          isSelected: Sortindex == 2,
                          onPressed: () {
                            setState(() {
                              Sortindex = 2;
                            });
                          },
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: FilBut(
                          text: "Best Rated",
                          isSelected: Sortindex == 3,
                          onPressed: () {
                            setState(() {
                              Sortindex = 3;
                            });
                          },
                        )),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: FilBut(
                          text: "Distance",
                          isSelected: Sortindex == 4,
                          onPressed: () {
                            setState(() {
                              Sortindex = 4;
                            });
                          },
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: FilBut(
                          text: "Car Age",
                          isSelected: Sortindex == 5,
                          onPressed: () {
                            setState(() {
                              Sortindex = 5;
                            });
                          },
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: FilBut(
                          text: "Kms Driven",
                          isSelected: Sortindex == 6,
                          onPressed: () {
                            setState(() {
                              Sortindex = 6;
                            });
                          },
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: FilBut(
                          text: "Popularity",
                          isSelected: Sortindex == 7,
                          onPressed: () {
                            setState(() {
                              Sortindex = 7;
                            });
                          },
                        )),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.car_crash_sharp),
                  title: Text("Include Specific Cars"),
                  subtitle: Text("Search for your Favourite Car"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: "Search Your favourite Car"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),

                //CAR TYPE

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Car Type"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CarTypeButton(text: "Sedan"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CarTypeButton(text: "SUV"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CarTypeButton(text: "HatchBack"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CarTypeButton(text: "Luxury"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //SEATS

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Seats"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      SeatButton(text: "4 Seater"),
                      SizedBox(
                        width: 10,
                      ),
                      SeatButton(text: "5 Seater"),
                      SizedBox(
                        width: 10,
                      ),
                      SeatButton(text: "7 Seater"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //FUEL TYPE

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Fuel Type"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: FuelButton(text: "Petrol")),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: FuelButton(text: "Diesel")),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: FuelButton(text: "CNG")),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: FuelButton(text: "Electric")),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),

                // TRANSMISSION

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Transmission Type"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      TransButton(text: "Manual"),
                      SizedBox(
                        width: 30,
                      ),
                      TransButton(text: "Automatic"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Addons"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [AddButton(text: "FastTag")],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                            onPressed: () {},
                            child: Text("Apply"),
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

class CarTypeButton extends StatefulWidget {
  final String text;

  CarTypeButton({required this.text});

  @override
  State<CarTypeButton> createState() => _CarTypeButtonState();
}

class _CarTypeButtonState extends State<CarTypeButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.green : Colors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 42,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.home_sharp,
                size: 18,
              ),
              SizedBox(height: 8),
              Text(
                widget.text,
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeatButton extends StatefulWidget {
  final String text;

  SeatButton({required this.text});

  @override
  State<SeatButton> createState() => _SeatButtonState();
}

class _SeatButtonState extends State<SeatButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.green : Colors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 42,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.home_sharp,
                size: 18,
              ),
              SizedBox(height: 8),
              Text(
                widget.text,
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FuelButton extends StatefulWidget {
  final String text;

  FuelButton({required this.text});

  @override
  State<FuelButton> createState() => _FuelButtonState();
}

class _FuelButtonState extends State<FuelButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.green : Colors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 42,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.home_sharp,
                size: 18,
              ),
              SizedBox(height: 8),
              Text(
                widget.text,
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransButton extends StatefulWidget {
  final String text;

  TransButton({required this.text});

  @override
  State<TransButton> createState() => _TransButtonState();
}

class _TransButtonState extends State<TransButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.green : Colors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 42,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.home_sharp,
                size: 18,
              ),
              SizedBox(height: 8),
              Text(
                widget.text,
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddButton extends StatefulWidget {
  final String text;

  AddButton({required this.text});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.green : Colors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 42,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.home_sharp,
                size: 18,
              ),
              SizedBox(height: 8),
              Text(
                widget.text,
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
