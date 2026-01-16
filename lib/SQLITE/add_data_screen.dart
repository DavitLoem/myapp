import 'package:exercise/SQLITE/db_helper/db_helper.dart';
import 'package:flutter/material.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key, this.data});

  final Map<String, dynamic>? data;

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      titleController.text = widget.data!['title'] ?? '';
      subtitleController.text = widget.data!['subtitle'] ?? '';
    } else {
      titleController.clear();
      subtitleController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data == null ? 'Add Data' : 'Update Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          spacing: 15,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter title',
              ),
            ),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter subtitle',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                DbHelper dbHelper = DbHelper();
                if (widget.data != null) {
                  await dbHelper.updateData(
                    widget.data!['id'],
                    titleController.text,
                    subtitleController.text,
                  );
                } else {
                  await dbHelper.insertData(
                    titleController.text,
                    subtitleController.text,
                  );
                }
                Navigator.pop(context);
              },
              child: Text(widget.data != null ? 'Update Data' : 'Save Data'),
            ),
          ],
        ),
      ),
    );
  }
}
