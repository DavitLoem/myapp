import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class DateTimeExample extends StatefulWidget {
  const DateTimeExample({super.key});

  @override
  State<DateTimeExample> createState() => _DateTimeExampleState();
}

class _DateTimeExampleState extends State<DateTimeExample> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Date Time Picker Example'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            ),
            Text(
              'Selected Date: ${DateFormat('EEEE, d, MMMM, yyyy').format(selectedDate)}',
            ),
            Text('Selected Time: ${selectedTime.hour}:${selectedTime.minute}'),

            Text(
              'Selected DateTime: ${DateFormat("hh:mm aaa").format(selectedDate)}',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                ).then((value) {
                  setState(() {
                    selectedDate = value!;
                  });
                });
              },
              child: Text('Show Date Picker'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  setState(() {
                    selectedTime = value!;
                  });
                });
              },
              child: Text('Show Time Picker'),
            ),
          ],
        ),
      ),
    );
  }
}
