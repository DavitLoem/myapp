import 'package:flutter/material.dart';

class RadioButtonEx extends StatefulWidget {
  const RadioButtonEx({super.key});

  @override
  State<RadioButtonEx> createState() => _RadioButtonExState();
}

class _RadioButtonExState extends State<RadioButtonEx> {
  var selectedValue = "option1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Radio Button'), centerTitle: true),
      body: Column(
        children: [
          ListTile(
            title: Text('Option 1'),
            leading: Radio(
              value: "option1",
              activeColor: Colors.amber,
              // fillColor: WidgetStateProperty.all(Colors.lightGreenAccent),
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = "option1";
                });
              },
            ),
          ),
          ListTile(
            title: Text('Option 2'),
            leading: Radio(
              value: "option2",
              activeColor: Colors.amber,

              groupValue: selectedValue,
              onChanged: (value) {
                setState(() { 
                  selectedValue = "option2";
                });
              },
            ),
          ),
          ListTile(
            title: Text('Option 3'),
            leading: Radio(
              value: "option3",
              activeColor: Colors.amber,

              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = "option3";
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
