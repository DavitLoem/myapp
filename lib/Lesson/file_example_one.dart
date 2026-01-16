import 'package:exercise/file_helper/file_helper.dart';
import 'package:flutter/material.dart';

class FileExampleOne extends StatefulWidget {
  const FileExampleOne({super.key});

  @override
  State<FileExampleOne> createState() => _FileExampleOneState();
}

class _FileExampleOneState extends State<FileExampleOne> {
  String data = "";
  void loadData() async {
    var dataFromFile = await FileHelper().readFromFile();

    setState(() {
      data = dataFromFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data),
            ElevatedButton(
              onPressed: () {
                FileHelper().writeToFile();
              },
              child: Text('Write'),
            ),
            ElevatedButton(
              onPressed: () async {
                loadData();
              },
              child: Text('read'),
            ),
          ],
        ),
      ),
    );
  }
}
