import 'package:flutter/material.dart';

class UserTerms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'By using this car rental app, you agree to the following terms and conditions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. You must be at least 21 years old to rent a car through this app.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '2. You are responsible for returning the car in the same condition as when you rented it.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '3. Any damage to the car during your rental period will be your responsibility and may incur additional charges.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '4. You must follow all local traffic laws and regulations while using the rental car.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '5. Smoking and pets are not allowed in the rental cars.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '6. You must return the car on or before the agreed-upon return date and time.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '7. Late returns may incur additional charges.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '8. You are responsible for refilling the gas tank to the same level as when you rented the car.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '9. Any fines or tickets incurred during your rental period are your responsibility.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '10. The app is not responsible for personal belongings left in the rental car.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '11. Your payment method will be charged for the rental fees and any additional charges.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '12. We reserve the right to refuse service to anyone for any reason.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '13. We may collect and store your personal information as outlined in our privacy policy.',
              style: TextStyle(fontSize: 16),
            ),

            // Add more terms and conditions as needed
            SizedBox(height: 8),
            Text(
              '14. We are not responsible for any personal injury or property damage that occurs during the use of the rental car.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '15. Any disputes or claims related to the rental agreement will be governed by the laws of [Your Jurisdiction].',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '16. You are responsible for adhering to any mileage limits specified in your rental agreement.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '17. We reserve the right to charge additional fees for excessive mileage.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '18. We may use GPS tracking to monitor the location of the rental car during the rental period for security and safety purposes.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '19. By accepting these terms and conditions, you agree to receive email updates and promotional offers from our car rental service.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
