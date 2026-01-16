import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:lottie/lottie.dart';

class DialogExample extends StatefulWidget {
  const DialogExample({super.key});

  @override
  State<DialogExample> createState() => _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {
  final TextEditingController _nameController = TextEditingController();
  String _currentName = 'Dr. John Doe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      icon: Icon(Icons.warning_amber_rounded),
                      iconColor: Colors.red,
                      // elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,

                      // insetPadding: EdgeInsets.symmetric(horizontal: 20),
                      // actionsPadding: EdgeInsets.symmetric(horizontal: 20),
                      // actionsAlignment: MainAxisAlignment.center,
                      title: Text('Dialog Title'),
                      content: Text('Dialog Content'),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Show Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset('assets/Doctor illustration.json'),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'What happen?',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  spacing: 15,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'),
                                    ),

                                    ElevatedButton(
                                      onPressed: () {
                                        IconSnackBar.show(
                                          context,
                                          snackBarType: SnackBarType.success,
                                          label: 'Save successfully',
                                        );
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text('Show Dialog custom'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         // duration: Duration(seconds: 2),
            //         content: Center(
            //           child: Text(
            //             'Successfully',
            //             style: TextStyle(color: Colors.white, fontSize: 25),
            //           ),
            //         ),
            //         action: SnackBarAction(label: 'Undo', onPressed: () {}),
            //         behavior: SnackBarBehavior.floating,

            //         backgroundColor: Colors.red,
            //       ),
            //     );
            //   },
            //   child: Text('Snack bar'),
            // ),
            ElevatedButton(
              onPressed: () {
                IconSnackBar.show(
                  context,
                  snackBarType: SnackBarType.success,
                  label: 'Save successfully',
                );
              },
              child: const Text('Snack bar'),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/image_5.jpg'),
                          ),
                          SizedBox(height: 10),
                          Text(_currentName),
                          Text('JohnDoe@gmail.com'),
                          // Lottie.asset(
                          //   'assets/Doctor illustration.json',
                          //   height: 200,
                          // ),
                          SizedBox(height: 10),
                          Container(
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _nameController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: Colors.blue[400]!,
                                    width: 2,
                                  ),
                                ),
                                hintText: 'Change your name',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 13,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromARGB(
                                          255,
                                          230,
                                          35,
                                          1,
                                        ),
                                      ),

                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_nameController.text.isNotEmpty) {
                                        setState(() {
                                          _currentName = _nameController.text;
                                        });
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromARGB(
                                          255,
                                          11,
                                          79,
                                          112,
                                        ),
                                      ),

                                      child: Center(
                                        child: Text(
                                          'Change Name',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text('ButtonSheet'),
            ),
          ],
        ),
      ),
    );
  }
}
