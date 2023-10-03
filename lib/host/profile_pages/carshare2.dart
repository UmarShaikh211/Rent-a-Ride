import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 400,
              width: 350,
              child: ShareCalendarPage(
                  updateSelectedDates: updateSelectedDates,
                  carid: widget.Carid),
            ),
          ),
          Text(
            'Start Date: ${startDate != null ? DateFormat('EEEE, d-MMMM-yyyy').format(startDate!) : 'Not Selected'}',
            style: TextStyle(fontSize: size.width * 0.035),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            'End Date: ${endDate != null ? DateFormat('EEEE, d-MMMM-yyyy').format(endDate!) : 'Not Selected'}',
            style: TextStyle(fontSize: size.width * 0.035),
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
    widget.updateSelectedDates(_rangeStart, _rangeEnd);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarShare3(
            carid: widget.carid,
            startdate: _rangeStart.toString(),
            enddate: _rangeEnd.toString(),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
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
              // Disable dates before the current day
              return !day.isBefore(DateTime.now());
            },
          ),
          ElevatedButton(
            onPressed: _submitSelectedDates,
            child: Text('Submit'),
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
