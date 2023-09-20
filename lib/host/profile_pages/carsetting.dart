import 'package:flutter/material.dart';
import 'package:rentcartest/host/profile_pages/fastagset.dart';

class CarSettings extends StatefulWidget {
  const CarSettings({super.key});

  @override
  State<CarSettings> createState() => _CarSettingsState();
}

class _CarSettingsState extends State<CarSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Car Settings"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text("Choose Your Car Settings"),
          SizedBox(
            height: 10,
          ),
          Text("Introducing Fast Tag Settings for Your Cars"),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FastTag()));
            },
            child: ListTile(
              leading: Icon(Icons.credit_card_off_outlined),
              title: Text("FastTag Settings"),
              subtitleTextStyle: TextStyle(fontSize: 10),
              subtitle: Text(
                  "Let Your Guests Know if you provide Fast Tag for your Cars"),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
          )
        ],
      ),
    );
  }
}
