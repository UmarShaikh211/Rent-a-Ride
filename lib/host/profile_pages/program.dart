import 'package:flutter/material.dart';
import 'package:rentcartest/host/host_features.dart';

import '../../user/widget.dart';

class ProgramDet extends StatefulWidget {
  const ProgramDet({super.key});

  @override
  State<ProgramDet> createState() => _ProgramDetState();
}

class _ProgramDetState extends State<ProgramDet> {
  String? carval;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 50,
          width: 320,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: DropdownButtonFormField<String>(
            borderRadius: BorderRadius.circular(20),
            value: carval,
            onChanged: (String? newValue) {
              setState(() {
                carval = newValue;
              });
            },
            items: carlist.map((String carit) {
              return DropdownMenuItem<String>(
                value: carit,
                child: Text(carit),
              );
            }).toList(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Image.asset(
              "assets/rolls.png",
              fit: BoxFit.fill,
              height: 100,
              width: 100,
            ),
            title: Text("Rolls Royce Phantom"),
            subtitle: Text("5 Seats"),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: Column(children: [
                  ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        child: Icon(Icons.home)),
                    title: Text("WhiteBoard Tenure"),
                    subtitle: Text("23rd June '23 to 24th June '26 "),
                  ),
                  Divider(),
                  ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Icon(
                          Icons.battery_6_bar_outlined,
                          color: Colors.white,
                        )),
                    title: Text("Fuel Type"),
                    subtitle: Text("Petrol"),
                  ),
                  Divider(),
                  ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Icon(Icons.gamepad_outlined)),
                    title: Text("Transmission"),
                    subtitle: Text("Automatic"),
                  ),
                  Divider(),
                  ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.location_on)),
                    title: Text("Location"),
                    subtitle: Text("Mumbai"),
                  ),
                ]),
              ))
        ],
      ),
    );
  }
}
