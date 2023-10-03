import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';

class ApiService {
  // static const String apiUrl = 'http://172.20.10.3:8000/'; // Umar
  // //static const String apiUrl = 'http://192.168.0.120:8000'; //Home

  static Future<void> createUser(
      String name, String email, String phone) async {
    final usersResponse = await http.get(Uri.parse('$globalapiUrl/users/'));
    if (usersResponse.statusCode == 200) {
      final users = jsonDecode(usersResponse.body);
      if (users is List) {
        final existingUser = users.firstWhere(
          (user) =>
              user['name'] == name &&
              user['email'] == email &&
              user['phone'] == phone,
          orElse: () => null,
        );

        if (existingUser != null) {
          // User already exists, fetch the existing user's ID and proceed to car creation
          final existingUserId = existingUser['id'];
          await createCar(existingUserId);
          return;
        }
      }
    } else {
      throw Exception('Failed to fetch users');
    }

    // If the existing user wasn't found, create a new user
    final userResponse = await http.post(
      Uri.parse('$globalapiUrl/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'phone': phone,
      }),
    );

    if (userResponse.statusCode != 201) {
      throw Exception('Failed to create user');
    }
  }

  static Future<String> createCar(String userId) async {
    final carResponse = await http.post(
      Uri.parse('$globalapiUrl/cars/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user': userId,
      }),
    );

    if (carResponse.statusCode == 201) {
      final carData = jsonDecode(carResponse.body);
      final carId = carData['id'];
      return carId.toString(); // Convert the car ID to string
    } else {
      throw Exception('Failed to create car');
    }
  }

// In your ApiService class
  static Future<void> createNotification(
    String carId,
    String notification1,
    String notification2,
    String notification3,
    String notification4,
    String notification5,

// Add parameters for other notifications
  ) async {
    final notificationResponse = await http.post(
      Uri.parse('$globalapiUrl/notifications/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'car': carId,
        'N1': notification1,
        'N2': notification2,
        'N3': notification3,
        'N4': notification4,
        'N5': notification5,

// Add other notifications to the request body
      }),
    );

    if (notificationResponse.statusCode != 201) {
      throw Exception('Failed to add notifications');
    }
  }

  static Future<void> createbank(
    String userid,
    String accountno,
    String ifsccode,
    String panno,

// Add parameters for other notifications
  ) async {
    final bankResponse = await http.post(
      Uri.parse('$globalapiUrl/bank/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user': userid,
        'acc_no': accountno,
        'ifsc': ifsccode,
        'pan': panno,
      }),
    );

    if (bankResponse.statusCode != 201) {
      throw Exception('Failed to add Bank Account');
    }
  }

// In your ApiService class

  static Future<String> getLastCarId(String userId) async {
    final carsResponse =
        await http.get(Uri.parse('$globalapiUrl/cars/?user=$userId'));
    if (carsResponse.statusCode == 200) {
      final cars = jsonDecode(carsResponse.body);
      if (cars is List && cars.isNotEmpty) {
        final userCars = cars.where((car) => car['user'] == userId).toList();
        if (userCars.isNotEmpty) {
          final lastCar = userCars.last;
          final lastCarId = lastCar['id'].toString();
          return lastCarId;
        }
      }
    }
    throw Exception('Failed to fetch cars');
  }

  static Future<String> getLastUserId() async {
    final usersResponse = await http.get(Uri.parse('$globalapiUrl/users/'));
    if (usersResponse.statusCode == 200) {
      final users = jsonDecode(usersResponse.body);
      if (users is List && users.isNotEmpty) {
        final lastUser = users.last;
        final lastUserId = lastUser['id'];
        return lastUserId;
      }
    }
    throw Exception('Failed to fetch users');
  }

  static Future<bool> doesUserExist(
      String name, String email, String phone) async {
    final usersResponse = await http.get(Uri.parse('$globalapiUrl/users/'));
    if (usersResponse.statusCode == 200) {
      final users = jsonDecode(usersResponse.body);
      if (users is List) {
        return users.any((user) =>
            user['name'] == name &&
            user['email'] == email &&
            user['phone'] == phone);
      }
    }
    throw Exception('Failed to fetch users');
  }

  static Future<Map<String, dynamic>> getUserByNameEmailPhone(
      String name, String email, String phone) async {
    final usersResponse = await http.get(Uri.parse('$globalapiUrl/users/'));
    if (usersResponse.statusCode == 200) {
      final users = jsonDecode(usersResponse.body);
      if (users is List) {
        return users.firstWhere(
            (user) =>
                user['name'] == name &&
                user['email'] == email &&
                user['phone'] == phone,
            orElse: () => null);
      }
    }
    throw Exception('Failed to fetch users');
  }

  // Your existing methods and properties

  static Future<void> addnewcarData(
    String carId,
    String license,
    String carBrand,
    String carModel,
    String carCity,
    String carYear,
    String carFuel,
    String carTrans,
    String carSeat,
    int carKm,
    String carChassisNo,
  ) async {
    final notificationResponse = await http.post(
      Uri.parse('$globalapiUrl/addcars/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'car': carId,
        'License': license,
        'CarBrand': carBrand,
        'CarModel': carModel,
        'CarCity': carCity,
        'CarYear': carYear,
        'CarFuel': carFuel,
        'CarTrans': carTrans,
        'CarSeat': carSeat,
        'CarKm': carKm,
        'CarChassisNo': carChassisNo
      }),
    );

    if (notificationResponse.statusCode != 201) {
      throw Exception('Failed to add notifications');
    }
  }

  static Future<void> createCarForUser(String userId) async {
    final carResponse = await http.post(
      Uri.parse('$globalapiUrl/cars/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user': userId,
        // Other car fields
      }),
    );

    if (carResponse.statusCode != 201) {
      throw Exception('Failed to create car');
    }
  }

  static Future<List<Map<String, dynamic>>> getUserCars(String userId) async {
    final carsResponse =
        await http.get(Uri.parse('$globalapiUrl/cars/?user=$userId'));
    if (carsResponse.statusCode == 200) {
      final cars = jsonDecode(carsResponse.body);
      if (cars is List) {
        final userCars = cars.where((car) => car['user'] == userId).toList();
        return List<Map<String, dynamic>>.from(
            userCars); // Return the list of user's car objects
      }
    }
    throw Exception('Failed to fetch user\'s cars');
  }

  static Future<void> updateIsShared(String carId, bool isShared) async {
    try {
      final response = await http.put(
        Uri.parse('$globalapiUrl/updatesharecar/$carId/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'isshared': isShared,
        }),
      );

      if (response.statusCode == 200) {
        print('isshared updated successfully.');
      } else {
        print('Failed to update isshared. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating isshared: $e');
    }
  }

  static Future<bool> checkAddCarFilled(int carId) async {
    try {
      // Debug: Print the selectedCarId to verify it's correct
      print("Selected Car ID: $carId");

      // Query your backend to check if AddCar data is filled for the specified carId
      // Return true if it's filled, otherwise return false
      // Example:
      final response = await http.get(Uri.parse('$globalapiUrl/cars/$carId/'));
      print("API URL: $globalapiUrl/cars/$carId");
      // Debug: Print the API response status code
      print("API Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Debug: Print the API response data
        print("API Response Data: $data");

        // Debug: Print the isFilled value extracted from the API response
        final isFilled = data['added_cars'][0]['isFilled'] ?? false;
        print("isFilled Value: $isFilled");

        return isFilled;
      }

      // Debug: Print an error message if the API call fails
      print("API Call Failed with Status Code: ${response.statusCode}");

      return false; // Handle error cases appropriately
    } catch (e) {
      // Debug: Print any exception that occurs during the API call
      print("Error checking AddCar data: $e");
      return false;
    }
  }

  static Future<bool> checkHostBioFilled(int carId) async {
    try {
      final response = await http.get(Uri.parse('$globalapiUrl/cars/$carId/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final isFilled = data['host_bio'][0]['isFilled'] ?? false;

        return isFilled;
      }

      print("API Call Failed with Status Code: ${response.statusCode}");

      return false; // Handle error cases appropriately
    } catch (e) {
      print("Error checking AddCar data: $e");
      return false;
    }
  }

  static Future<bool> checkCarImageFilled(int carId) async {
    try {
      final response = await http.get(Uri.parse('$globalapiUrl/cars/$carId/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final isFilled = data['car_image'][0]['isFilled'] ?? false;

        return isFilled;
      }

      print("API Call Failed with Status Code: ${response.statusCode}");

      return false; // Handle error cases appropriately
    } catch (e) {
      print("Error checking AddCar data: $e");
      return false;
    }
  }

  static Future<bool> checkPriceFilled(int carId) async {
    try {
      final response = await http.get(Uri.parse('$globalapiUrl/cars/$carId/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final isFilled = data['car_price'][0]['isFilled'] ?? false;

        return isFilled;
      }

      print("API Call Failed with Status Code: ${response.statusCode}");

      return false; // Handle error cases appropriately
    } catch (e) {
      print("Error checking AddCar data: $e");
      return false;
    }
  }
}
