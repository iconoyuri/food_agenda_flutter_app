import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Storage {
  Storage({required this.fileName, required this.data});

  String fileName; //the name of the file
  String data; // data that we to save in this file

  Future<String> get _localPath async { // get directory path
    final directory = await getExternalStorageDirectory();
    // print(directory!.path);
      return directory!.path;
    }

    Future<File> get _localFile async {
      final path = await _localPath;
      return File('$path/$fileName'); //create a local file the choosen directory with our filename
    }

    Future<File> write() async {
      final file = await _localFile;
      return file.writeAsString(data); // write in the file
  }
}
