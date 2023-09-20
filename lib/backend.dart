import 'dart:convert';
import 'package:http/http.dart' as http;

class CarPic {
  String baseUrl = "http://192.168.0.120:8000/Pic/";

  Future postCarPic() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        try {
          return jsonDecode(response.body);
        } catch (_) {
          return response.body; // Return plain text response if not JSON
        }
      } else {
        throw Exception('Server Error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

class PopCar {
  String baseUrl = "http://192.168.0.120:8000/PopCarDetails/";

  Future postPopCar() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        try {
          return jsonDecode(response.body);
        } catch (_) {
          return response.body; // Return plain text response if not JSON
        }
      } else {
        throw Exception('Server Error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

class CarInfo {
  String baseUrl = "http://192.168.0.120:8000/InfoPage/"; //Umar

  Future Postinfopage() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        try {
          return jsonDecode(response.body);
        } catch (_) {
          return response.body; // Return plain text response if not JSON
        }
      } else {
        throw Exception('Server Error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
