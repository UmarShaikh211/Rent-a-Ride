// import 'package:flutter/material.dart';
//
// import 'package:table_calendar/table_calendar.dart';
//
// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }
//
// class _CalendarPageState extends State<CalendarPage> {
//
//   List<DateTime> bookedDates = [
//     DateTime(2023, 8, 26),
//     DateTime(2023, 8, 30),
//     // Add more booked dates here
//   ];
//
//
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   DateTime? _rangeStart;
//   DateTime? _rangeEnd;
//
//   void _submitSelectedDates() {
//     Navigator.pop(context, {
//       'startDate': _rangeStart,
//       'endDate': _rangeEnd,
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 460,
//       child: Column(
//           children: [
//             TableCalendar(
//               availableCalendarFormats: {CalendarFormat.month:'Month'},
//               pageJumpingEnabled: true,
//               availableGestures: AvailableGestures.none,
//               headerStyle: HeaderStyle(
//                 titleCentered: true,
//                 titleTextStyle: TextStyle(
//                   color: Colors.black,
//                   fontSize: 18
//                 )
//               ),
//               daysOfWeekStyle: DaysOfWeekStyle(
//                 weekdayStyle: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16
//                 ),
//                 weekendStyle: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 16
//                 ),
//               ),
//               daysOfWeekHeight: 20,
//               calendarStyle: CalendarStyle(
//                 outsideDaysVisible: false,
//                 rangeHighlightColor: kPrimaryLightColor,
//                 selectedTextStyle: TextStyle(color: kblackcolor,fontSize: getProportionateScreenHeight(14)),
//                 selectedDecoration: BoxDecoration(color: kPrimaryColor,shape: BoxShape.circle),
//                 rangeStartDecoration: BoxDecoration(color: kPrimaryColor,shape: BoxShape.circle),
//                 rangeEndDecoration: BoxDecoration(color: kPrimaryColor,shape: BoxShape.circle),
//                 withinRangeTextStyle: TextStyle(color: Colors.white),
//                 outsideTextStyle: TextStyle(color: Colors.grey,fontSize: getProportionateScreenHeight(14)),
//                 defaultTextStyle: TextStyle(color: kblackcolor,fontSize: getProportionateScreenHeight(14)),
//                 weekendTextStyle: TextStyle(color: kblackcolor,fontSize: getProportionateScreenHeight(14)),
//                 todayDecoration: BoxDecoration(color: kPrimaryExtremeLightColor,shape: BoxShape.circle),
//                 disabledTextStyle: TextStyle(color: kTextColor,fontSize: getProportionateScreenHeight(14)),
//                 markersAutoAligned: true,
//               ),
//               firstDay: DateTime.now(),
//               lastDay: DateTime.utc(2030, 12, 31),
//               focusedDay: _focusedDay,
//               selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//               rangeStartDay: _rangeStart,
//               rangeEndDay: _rangeEnd,
//               calendarBuilders: CalendarBuilders(
//                 defaultBuilder: (context, day, focusedDay) {
//                   for (DateTime d in bookedDates) {
//                     if (day.day == d.day &&
//                         day.month == d.month &&
//                         day.year == d.year) {
//                       return  Padding(
//                         padding: EdgeInsets.only(bottom: 13),
//                         child: Icon(Icons.clear, color: kPrimaryColor), // Customize the slashed appearance
//                       );
//                     }
//                   }
//                   return null;
//                 },
//               ),
//               calendarFormat: _calendarFormat,
//               rangeSelectionMode: _rangeSelectionMode,
//               onDaySelected: (selectedDay, focusedDay) {
//                 if (!isSameDay(_selectedDay, selectedDay)) {
//                   setState(() {
//                     _selectedDay = selectedDay;
//                     _focusedDay = focusedDay;
//                     _rangeStart = null;
//                     _rangeEnd = null;
//                     _rangeSelectionMode = RangeSelectionMode.toggledOff;
//                   });
//                 }
//               },
//               enabledDayPredicate: (day) {
//                 for (DateTime bookedDate in bookedDates) {
//                   if (isSameDay(day, bookedDate)) {
//                     return false; // Disable the day if it's in the bookedDates list
//                   }
//                 }
//                 return true; // Enable the day if it's not in the bookedDates list
//               },
//               onRangeSelected: (start, end, focusedDay) {
//                 bool hasDisabledDateInRange = false;
//                 for (DateTime bookedDate in bookedDates) {
//                   if (bookedDate.isAfter(start!) && bookedDate.isBefore(end!)) {
//                     hasDisabledDateInRange = true;
//                     break;
//                   }
//                 }
//
//                 if (!hasDisabledDateInRange) {
//                   setState(() {
//                     _selectedDay = null;
//                     _focusedDay = start!; // Set _focusedDay to the start of the selected range
//                     _rangeStart = start;
//                     _rangeEnd = end;
//                     _rangeSelectionMode = RangeSelectionMode.toggledOn;
//                   });
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)
//                       ),
//                       content: Text(
//                         'Looks like you have selected an already booked date!!!!',
//                         style: TextStyle(
//                           color: kblackcolor,
//                           fontSize: getProportionateScreenHeight(18),
//                           fontWeight: FontWeight.bold
//                         ),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text(
//                             'OK',
//                             style: TextStyle(
//                                 color: kPrimaryColor,
//                                 fontSize: getProportionateScreenHeight(16),
//                                 fontWeight: FontWeight.bold
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//
//
//               onFormatChanged: (format) {
//                 if (_calendarFormat != format) {
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 }
//               },
//               onPageChanged: (focusedDay) {
//                 _focusedDay = focusedDay;
//               },
//             ),
//             SizedBox(height: getProportionateScreenHeight(15),),
//             ElevatedButton(
//               onPressed: _submitSelectedDates,
//               child: Text(
//                 'Confirm Date',
//                 style: TextStyle(
//                   fontSize: getProportionateScreenHeight(16)
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: kPrimaryColor,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.all(10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)
//                 )
//               ),
//             ),
//           ],
//         ),
//     );
//   }
//
//   bool isSameDay(DateTime? dayA, DateTime dayB) {
//     return dayA?.year == dayB.year &&
//         dayA?.month == dayB.month &&
//         dayA?.day == dayB.day;
//   }
//
// }
