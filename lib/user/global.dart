import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'global.g.dart';

@HiveType(typeId: 0)
class BookingStatus {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final String datetime;

  @HiveField(3)
  final String bookingStatus;

  BookingStatus({
    required this.name,
    required this.image,
    required this.datetime,
    required this.bookingStatus,
  });
}

@HiveType(typeId: 1)
class FavoriteCar {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String image;

  @HiveField(2)
  late String location;

  @HiveField(3)
  late double price;

  FavoriteCar({
    required this.name,
    required this.image,
    required this.location,
    required this.price,
  });
}

class UserDataProvider extends ChangeNotifier {
  String? userId;

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}

class BookingStatusProvider with ChangeNotifier {
  List<BookingStatus> _bookingStatusList = [];

  List<BookingStatus> get bookingStatusList => _bookingStatusList;

  void addBookingStatus(BookingStatus bookingStatusData) {
    _bookingStatusList.add(bookingStatusData);
    notifyListeners();
  }
}
