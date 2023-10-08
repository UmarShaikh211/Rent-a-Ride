import 'package:flutter/material.dart';

class CarDetailAdminScreen extends StatelessWidget {
  final Map<String, dynamic> carDetails; // Receive car details as a parameter

  CarDetailAdminScreen(this.carDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${carDetails['CarBrand']}' + '${carDetails['CarModel']}'),
            Text('City: ${carDetails['CarCity']}'),
            Text('License: ${carDetails['License']}'),
            Text('Car Year: ${carDetails['CarYear']}'),
            Text('Car Fuel: ${carDetails['CarFuel']}'),
            Text('Car Transmission: ${carDetails['CarTrans']}'),
            Text('Car Seats: ${carDetails['CarSeat']}'),
            Text('Car Kilometers: ${carDetails['CarKm']}'),
            Text('Car Chassis Number: ${carDetails['CarChassisNo']}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
