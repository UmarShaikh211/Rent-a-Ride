import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferralPage extends StatelessWidget {
  final String referralCode =
      "RENT-A-RIDE"; // Replace with your actual referral code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referral Page'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Referral Code:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              referralCode,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(
                      254, 205, 59, 1.0), // Set the background color
                  onPrimary: Colors.black,
                  side: BorderSide(color: Colors.deepPurple)),
              onPressed: () {
                // Copy the referral code to the clipboard
                Clipboard.setData(ClipboardData(text: referralCode));
                final snackBar = SnackBar(
                  content: Text('Referral code copied to clipboard!'),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Copy Referral Code'),
            ),
          ],
        ),
      ),
    );
  }
}
