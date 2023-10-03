import 'package:flutter/material.dart';
import 'package:rentcartest/host/profile_pages/seupmessage.dart';

class GuestWelcome extends StatefulWidget {
  const GuestWelcome({super.key});

  @override
  State<GuestWelcome> createState() => _GuestWelcomeState();
}

class _GuestWelcomeState extends State<GuestWelcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Message "),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.white,
                    height: 420,
                    width: 350,
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "What is a Welcome Message?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Greet your Guests with a well written meassage that"
                                "makes them feel welcome & excited about their trip"
                                "This meassge will be sent to your guest after they book your Car.",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("What is it important to personalise?"),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "A well crafted welcome-messsage for each of your car can create a positive first impression"
                                "& help prevent problems",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("How to Setup?"),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Click on Setup Message Button and type ininformation for each of the sections"
                                "we have Provided for your car",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomAppBar(
            child: Card(
              child: Container(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.green)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetupMessage()));
                    },
                    child: Text("Setup Message"),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
