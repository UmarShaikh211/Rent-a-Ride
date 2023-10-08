import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class HostListScreen extends StatefulWidget {
  @override
  _HostListScreenState createState() => _HostListScreenState();
}

class _HostListScreenState extends State<HostListScreen> {
  List<dynamic> hostList = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('$globalapiUrl/hostbios/'));

    if (response.statusCode == 200) {
      setState(() {
        hostList = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load users');
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
        title: Text('User List'),
      ),
      body: hostList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: hostList.length,
              itemBuilder: (context, index) {
                final host = hostList[index];
                final userId = host['user'];
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
                      final hostUsername = snapshot.data;
                      return Card(
                        elevation: 3,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            // You can load user avatars here if available
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            hostUsername!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Guest Support Phone Number: ${host['Gphone']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Handle user item tap, if needed
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
