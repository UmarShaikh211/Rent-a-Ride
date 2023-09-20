import 'package:flutter/material.dart';

class FastTag extends StatefulWidget {
  const FastTag({super.key});

  @override
  State<FastTag> createState() => _FastTagState();
}

class _FastTagState extends State<FastTag> {
  bool light = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FastTag Setting"),
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
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Confirm FastTag availability on your Car",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      "Hosts own their FastTag,and settle all FastTag related transactions with guests separately,"
                      "FastTag enabled Cars get"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.directions_bike),
                            Text("3x more Bookings"),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.directions_bike),
                            Text("3x more Bookings"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        child: Column(
                          children: [
                            Text("Rolls Royce Phantom"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("MH023SA3244"),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text("Switch ON if Car has FastTag"),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Switch(
                                    // This bool value toggles the switch.
                                    value: light,
                                    activeColor: Colors.blueAccent,
                                    onChanged: (bool value) {
                                      // This is called when the user toggles the switch.
                                      setState(() {
                                        light = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
