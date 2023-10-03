import 'package:flutter/material.dart';

class HostPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Host Policies'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '1. Host Agreement',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'By becoming a host on our car rental platform, you agree to the following terms and conditions:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Listing Requirements',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Hosts must provide accurate and up-to-date information about their vehicles, including make, model, year, mileage, and condition.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Photos of the vehicle must accurately represent its current condition and any existing damage.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Pricing and Payment',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Hosts are responsible for setting their rental prices and additional fees (e.g., cleaning, delivery).',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Payment for each rental is processed through the platform, and hosts will receive their earnings within a specified time frame.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Insurance',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Hosts must maintain valid and appropriate insurance coverage for their vehicles.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- In the event of an accident, hosts should follow the platform\'s instructions for reporting the incident and providing necessary documentation.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Vehicle Maintenance',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Hosts are responsible for keeping their vehicles in good working condition, ensuring safety features are functional, and addressing any mechanical issues promptly.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Regular maintenance, including oil changes and tire rotations, should be performed as recommended by the vehicle\'s manufacturer.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Cleanliness and Hygiene',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Hosts must clean and sanitize their vehicles before and after each rental.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Clear guidelines on cleaning standards should be followed to maintain a clean and safe environment for renters.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Availability and Booking',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Hosts should keep their availability calendar up to date, indicating when their vehicles are available for rent.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Reservations made by renters should be honored unless there are extenuating circumstances.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '8. Communication',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Hosts are encouraged to maintain open and responsive communication with renters.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Timely responses to rental requests, questions, and issues are expected.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '9. Cancellations',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Hosts should avoid cancellations whenever possible, as they can inconvenience renters.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Clear cancellation policies, including penalties and refund procedures, should be outlined in advance.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '10. Damages and Repairs',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Hosts must promptly report any damage to their vehicles caused during a rental.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- The platform may assist in the resolution of damage claims and repair costs.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
