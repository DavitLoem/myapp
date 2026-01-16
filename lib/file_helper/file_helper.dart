import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  Future<String> get getLocaPath async {
    var directory = await getApplicationCacheDirectory();
    return directory.path;
  }

  Future<File> get getLocalFile async {
    var path = await getLocaPath;
    var file = File("$path/test.txt");
    if (!file.existsSync()) {
      file.create();
    }
    return file;
  }

  void writeToFile() async {
    var file = await getLocalFile;

    file.writeAsString('Hello from file\n', mode: FileMode.append);
  }

  Future<String> readFromFile() async {
    var file = await getLocalFile;
    var data = await file.readAsString();

    debugPrint("Data from file: $data");
    return data;
  }
}
