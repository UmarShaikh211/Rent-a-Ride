import 'package:flutter/material.dart';
import 'package:rentcartest/host/profile_pages/savebank.dart';

class Bank extends StatefulWidget {
  const Bank({super.key});

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  TextEditingController _account = TextEditingController();
  TextEditingController _ifsc = TextEditingController();
  TextEditingController _pan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Information"),
        backgroundColor: Colors.teal,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: customInputDecorationTheme(),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      height: 105,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/Profile Image.png"),
                              radius: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                "Share Your Bank account \ndetails,we"
                                "will transfer your \nearnings,in your account",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: TextStyle(fontSize: 12),
                      controller: _account,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Account Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: TextStyle(fontSize: 12),
                      controller: _ifsc,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "IFSC Code",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: TextStyle(fontSize: 12),
                      controller: _pan,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Pan Card Number",
                        border: OutlineInputBorder(),
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
                        String Acc = _account.text;
                        String Ifsc = _ifsc.text;
                        String pan = _pan.text;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SaveBanlk(
                                    Acc: _account.text,
                                    Ifsc: _ifsc.text,
                                    Pan: _pan.text)));
                      },
                      child: Text("Save Bank Account"),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

InputDecorationTheme customInputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius:
        BorderRadius.circular(2), // Customize the border radius as needed
    borderSide: BorderSide(
        color: Colors.blueAccent), // Customize the border color as needed
    gapPadding: 0,
  );
  return InputDecorationTheme(
    labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
