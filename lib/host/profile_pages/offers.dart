import 'package:flutter/material.dart';
import 'package:rentcartest/host/profile_pages/offersettings.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Host Offers"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text("Introducing Offers"),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
                "Now you can create offers on your car to attract more bookings & earnings "),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.remove_red_eye_outlined),
                        Text("More Views from Guests"),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.satellite_alt),
                        Text("More Booking & Earnings"),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.search_outlined),
                        Text("Higher Search Ranking"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Your Cars"),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.deepPurpleAccent,
                            height: 80,
                            width: 80,
                          ),
                          Column(
                            children: [
                              Text("Rolls Royce Phantom"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("MH023SA3244"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Offer_settings()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Offers Settings",
                              style: TextStyle(color: Colors.green),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.green,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
