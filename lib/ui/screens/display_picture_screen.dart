import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen({super.key, required this.image});

  final File image;

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late String imagePath;

  @override
  Widget build(BuildContext context) {
    imagePath = widget.image.path;
    sendImageForPrediction(widget.image);
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(widget.image),
    );
  }

  void sendImageForPrediction(File image) async {
    String urlInsertImage = 'http://192.168.147.127:5000/detection';
    var request = MultipartRequest("POST", Uri.parse(urlInsertImage));
    // request.fields["imageWidth"] = productId.toString();
    // request.fields["imageHeight"] = productId.toString();
    request.files.add(MultipartFile.fromBytes(
        "image", File(image.path).readAsBytesSync(),
        filename: image.path));
    // print(request);
    var res = await request.send();
    print(res);
  }
}
