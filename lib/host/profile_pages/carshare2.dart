import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../user/size_config.dart';
import 'carshare3.dart';

class CarShare2 extends StatefulWidget {
  final int Carid;
  CarShare2({super.key, required this.Carid});

  @override
  State<CarShare2> createState() => _CarShare2State();
}

class _CarShare2State extends State<CarShare2> {
  DateTime? startDate;
  DateTime? endDate;
  void updateSelectedDates(DateTime? start, DateTime? end) {
    setState(() {
      startDate = start;
      endDate = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("ShareCar"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 409,
              width: 350,
              child: ShareCalendarPage(
                  updateSelectedDates: updateSelectedDates,
                  carid: widget.Carid),
            ),
          ),
        ],
      ),
    );
  }
}

class ShareCalendarPage extends StatefulWidget {
  final void Function(DateTime?, DateTime?) updateSelectedDates;
  final int carid; // Add this field

  ShareCalendarPage({required this.updateSelectedDates, required this.carid});
  @override
  _ShareCalendarPageState createState() => _ShareCalendarPageState();
}

class _ShareCalendarPageState extends State<ShareCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  void _submitSelectedDates() {
    if (_rangeStart == null || _rangeEnd == null) {
      // Show AlertDialog with custom styling if start or end date is not selected
      showDialog(
        context: context,
        builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: Colors.white,
              // Customize the background color
              dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(10.0),
                  // Customize the border radius
                ),
              ),
            ),
            child: AlertDialog(
              title: Text("Date Selection Error"),
              content: Text("Please select both start and end dates."),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.deepPurple)),
                  child: Text("OK"),
                ),
              ],
            ),
          );
        },
      );
    } else {
      widget.updateSelectedDates(_rangeStart, _rangeEnd);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarShare3(
            carid: widget.carid,
            startdate: _rangeStart.toString(),
            enddate: _rangeEnd.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              rangeHighlightColor: Color.fromRGBO(254, 205, 59, 1.0),
              selectedTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenHeight(14)),
              selectedDecoration: BoxDecoration(
                  color: Colors.deepPurpleAccent, shape: BoxShape.circle),
              rangeStartDecoration: BoxDecoration(
                  color: Colors.deepPurpleAccent, shape: BoxShape.circle),
              rangeEndDecoration: BoxDecoration(
                  color: Colors.deepPurpleAccent, shape: BoxShape.circle),
              withinRangeTextStyle: TextStyle(color: Colors.black),
              outsideTextStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: getProportionateScreenHeight(14)),
              defaultTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenHeight(14)),
              weekendTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenHeight(14)),
              todayDecoration:
                  BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              todayTextStyle: TextStyle(color: Theme.of(context).primaryColor),
              disabledTextStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: getProportionateScreenHeight(14)),
              markersAutoAligned: true,
            ),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _rangeStart = selectedDay;
                  _rangeEnd = selectedDay;
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                });
              }
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _selectedDay = null;
                _focusedDay = focusedDay;
                _rangeStart = start;
                _rangeEnd = end;
                _rangeSelectionMode = RangeSelectionMode.toggledOn;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            enabledDayPredicate: (DateTime day) {
              // Enable dates that are equal to or after the current day
              final now = DateTime.now();
              return !day.isBefore(DateTime(now.year, now.month, now.day));
            },
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: _submitSelectedDates,
            child: Text('Submit'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.deepPurple)),
          ),
        ],
      ),
    );
  }

  bool isSameDay(DateTime? dayA, DateTime dayB) {
    return dayA?.year == dayB.year &&
        dayA?.month == dayB.month &&
        dayA?.day == dayB.day;
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
