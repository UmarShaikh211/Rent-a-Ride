import 'package:flutter/material.dart';
import 'package:rentcartest/user/size_config.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  void _submitSelectedDates() {
    Navigator.pop(context, {
      'startDate': _rangeStart,
      'endDate': _rangeEnd,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Dates'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
      ),
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
                  _rangeStart = null;
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
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
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.deepPurple)),
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
