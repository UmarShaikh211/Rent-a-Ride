import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class BankListScreen extends StatefulWidget {
  @override
  _BankListScreenState createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  List<dynamic> bankList = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('$globalapiUrl/bank/'));

    if (response.statusCode == 200) {
      setState(() {
        bankList = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load banks');
    }
  }

  Future<String> fetchUsername(String userId) async {
    final response = await http.get(Uri.parse('$globalapiUrl/users/$userId'));

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      final username = userData['name'];
      return username;
    } else {
      throw Exception('Failed to fetch username');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank List'),
      ),
      body: bankList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: bankList.length,
              itemBuilder: (context, index) {
                final bank = bankList[index];
                final userId = bank['user'];

                return FutureBuilder<String>(
                  future: fetchUsername(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading indicator while fetching data
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Handle errors here
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Display the retrieved username
                      final bankUsername = snapshot.data;
                      return Card(
                        elevation: 3,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(
                            'Account Holder: $bankUsername',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account Number: ${bank['acc_no']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'IFSC Code: ${bank['ifsc']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'PAN Number: ${bank['pan']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Handle bank item tap, if needed
                          },
                        ),
                      );
                    }
                  },
                );
              },
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BankListScreen(),
  ));
}
