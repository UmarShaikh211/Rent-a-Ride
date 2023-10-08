import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'booking_detail.dart';
import 'global.dart';

class Trip extends StatefulWidget {
  const Trip({Key? key});

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  final ValueNotifier<String> selectedFilter = ValueNotifier<String>('ALL');
  List<BookingStatus> bookingStatusList = [];

  @override
  void initState() {
    super.initState();
    retrieveBookingStatusList().then((List<BookingStatus> list) {
      setState(() {
        list.sort((a, b) => b.datetime.compareTo(a.datetime));
        bookingStatusList = list;
      });
    });
  }

  List<BookingStatus> filteredBookingStatusList(String filter) {
    if (filter == 'ALL') {
      return bookingStatusList;
    } else {
      return bookingStatusList
          .where((status) => status.bookingStatus == filter)
          .toList();
    }
  }

  Future<List<BookingStatus>> retrieveBookingStatusList() async {
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    final box = await Hive.openBox<BookingStatus>(
        'booking_status_${userProvider.userId}');
    final List<BookingStatus> list = box.values.toList().cast<BookingStatus>();
    await box.close();
    return list;
  }

  @override
  void dispose() {
    selectedFilter
        .dispose(); // Dispose the ValueNotifier to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: customInputDecorationTheme(),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Trips"),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedFilter.value,
                  items: ['ALL', 'Successful', 'Failed'].map((filter) {
                    return DropdownMenuItem<String>(
                      value: filter,
                      child: Text(filter),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFilter.value = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        filteredBookingStatusList(selectedFilter.value).length,
                    itemBuilder: (context, index) {
                      final bookingStatusData = filteredBookingStatusList(
                          selectedFilter.value)[index];
                      final isSuccessful =
                          bookingStatusData.bookingStatus == 'Successful';

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Bookindetail(
                                    carId: "${bookingStatusData.carid}"),
                              ));
                        },
                        child: Card(
                          elevation: 2,
                          child: Container(
                            height: 180,
                            width: 300,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          "${bookingStatusData.image}" ??
                                              'Image not available',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "${bookingStatusData.name}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${bookingStatusData.datetime ?? ''}",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "${bookingStatusData.bookingStatus}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: isSuccessful
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputDecorationTheme customInputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // Customize the border radius as needed
    borderSide: BorderSide(
        color: Colors.deepPurple), // Customize the border color as needed
    gapPadding: 5,
  );
  return InputDecorationTheme(
    floatingLabelBehavior:
        FloatingLabelBehavior.auto, // Customize the label behavior if needed
    contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10), // Customize the content padding if needed
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
