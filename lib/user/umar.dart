import 'package:flutter/material.dart';
import 'package:rentcartest/host/host_features.dart';
import 'package:rentcartest/user/car_detail.dart';

import '../backend.dart';

class Umar extends StatefulWidget {
  const Umar({Key? key}) : super(key: key);

  @override
  State<Umar> createState() => _UmarState();
}

class _UmarState extends State<Umar> {
  PopCar pCarPop = PopCar();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: pCarPop.postPopCar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Map<String, dynamic> item = data[index];
                if (item is Map<String, dynamic>) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Car_detail(carn: item['Name'])));
                        },
                        child: Card(
                          child: Container(
                            height: size.height * 0.40,
                            width: size.width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: size.height * 0.25,
                                  width: size.width * 0.9,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          item['Photo'],
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        topLeft: Radius.circular(12)),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon:
                                            Icon(Icons.favorite_outline_sharp),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    item['Name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * 0.05),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    item['Transmission'] +
                                        ' '
                                            '*' +
                                        ' ' +
                                        item['Fuel'] +
                                        ' '
                                            '*' +
                                        ' ' +
                                        item['Seat'],
                                    style: TextStyle(
                                        fontSize: size.width * 0.025,
                                        color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          } else {
            return const Center(
              child: Text('Invalid data format'),
            );
          }
        },
      ),
    );
  }
}
