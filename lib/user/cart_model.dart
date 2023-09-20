import 'package:flutter/cupertino.dart';

class House {
  final List<String> images;
  final String Title, mode, location, rent;

  House(
      {required this.images,
      required this.Title,
      required this.location,
      required this.rent,
      required this.mode});
}

// Our demo Products

List<House> demoProducts = [
  House(
      images: [
        "assets/rolls.png",
        "assets/tesla.png",
        "assets/rolls.png",
        "assets/rolls.png",
      ],
      Title: 'Rolls Royce',
      mode: 'Automatic',
      location: 'Mumbai',
      rent: '\$300/Day'),
];
