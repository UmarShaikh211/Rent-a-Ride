import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'global.dart';

class Bookindetail extends StatefulWidget {
  final String carId;

  const Bookindetail({Key? key, required this.carId}) : super(key: key);

  @override
  State<Bookindetail> createState() => _BookindetailState();
}

class _BookindetailState extends State<Bookindetail> {
  String userId = "";
  // static const String apiUrl = 'http://172.20.10.3:8000/'; //Umar
  // //static const String apiUrl = 'http://192.168.0.120:8000/';
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId!;
  }

  double rating = 0.0; // Store the selected rating
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Rate Car"),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Rate this Car:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                setState(() {
                  rating = newRating;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Write a Review:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: reviewController,
              maxLines: 3, // Adjust the number of lines as needed
              decoration: InputDecoration(
                hintText: 'Enter your review here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(
                        254, 205, 59, 1.0), // Set the background color
                    onPrimary: Colors.black,
                    side: BorderSide(color: Colors.deepPurple)),
                onPressed: () async {
                  // Implement logic to submit the rating and review to the server
                  final double selectedRating = rating;
                  final String reviewText = reviewController.text;

                  final response = await http.post(
                    Uri.parse(
                        '$globalapiUrl/review/'), // Replace with your Django backend URL
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(
                      <String, dynamic>{
                        'car': widget.carId,
                        'user': userId,
                        'text': reviewText,
                      },
                    ),
                  );

                  if (response.statusCode == 201) {
                    print('Success: ${response.body}');
                  } else {
                    print('Error ${response.statusCode}: ${response.body}');
                  }

                  ///Rating
                  final response2 = await http.post(
                    Uri.parse(
                        '$globalapiUrl/rating/'), // Replace with your Django backend URL
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(
                      <String, dynamic>{
                        'car': widget.carId,
                        'user': userId,
                        'rating': rating,
                      },
                    ),
                  );

                  if (response2.statusCode == 201) {
                    print('Success: ${response2.body}');
                  } else {
                    print('Error ${response2.statusCode}: ${response2.body}');
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
