import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen({super.key});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late String imagePath;

  @override
  Widget build(BuildContext context) {
    XFile image = (ModalRoute.of(context)?.settings.arguments as Map)['image'];
    imagePath = image.path;
    // print('image');
    // print(image);
    sendImageForPrediction(image);
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }

  void sendImageForPrediction(XFile image) async {
    // String urlInsertImage = 'http://10.0.2.2:5000/detection';
    String urlInsertImage = 'http://192.168.147.127:5000/detection';
    var request = MultipartRequest("POST", Uri.parse(urlInsertImage));
    // request.fields["imageWidth"] = productId.toString();
    // request.fields["imageHeight"] = productId.toString();
    request.files.add(MultipartFile.fromBytes(
        "picture", File(image.path).readAsBytesSync(),
        filename: image.path));
    print(request);
    var res = await request.send();
    // print(res);
  }
}
