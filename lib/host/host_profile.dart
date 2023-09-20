import 'package:flutter/material.dart';
import 'package:rentcartest/host/profile_pages/addbank.dart';
import 'package:rentcartest/host/profile_pages/carsetting.dart';
import 'package:rentcartest/host/profile_pages/guestwelcome.dart';
import 'package:rentcartest/host/profile_pages/offers.dart';
import 'package:rentcartest/host/profile_pages/pricing.dart';
import 'package:rentcartest/host/profile_pages/program.dart';
import 'package:rentcartest/host/carbrandsheet.dart';
import 'package:rentcartest/host/profile_pages/refer.dart';

import 'host_drawer.dart';

class HostPro extends StatefulWidget {
  const HostPro({super.key});

  @override
  State<HostPro> createState() => _HostProState();
}

class _HostProState extends State<HostPro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HostDraw(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Account"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  color: Colors.black,
                ),
                height: 105,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/Profile Image.png"),
                        radius: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Umar Shaikh",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyanAccent,
                                  fontSize: 17),
                            ),
                            Text(
                              "xyz@gmail.com",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "9833427514",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.location_on_sharp),
                  title: Text("Listing Location Details"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProgramDet()));
                },
                child: ListTile(
                  leading: Icon(Icons.my_library_books_sharp),
                  title: Text("Program Details"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Bank()));
                },
                child: ListTile(
                  leading: Icon(Icons.credit_card_sharp),
                  title: Text("View Bank Details"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Refer()));
                },
                child: ListTile(
                  leading: Icon(Icons.satellite_alt_sharp),
                  title: Text("Refer App"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Pricing()));
                },
                child: ListTile(
                  leading: Icon(Icons.currency_rupee_outlined),
                  title: Text("Pricing Control"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GuestWelcome()));
                },
                child: ListTile(
                  leading: Icon(Icons.message_outlined),
                  title: Text("Guest Welcome Message"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Offers()));
                },
                child: ListTile(
                  leading: Icon(Icons.discount_outlined),
                  title: Text("Host Offers"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CarSettings()));
                },
                child: ListTile(
                  leading: Icon(Icons.local_gas_station_outlined),
                  title: Text("Car Settings"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
