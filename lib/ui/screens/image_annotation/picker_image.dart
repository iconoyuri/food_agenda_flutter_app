import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itadakimasu/ui/screens/image_recognition/display_picture_screen.dart';
import 'dart:io';

class RecognitionMainScreen extends StatefulWidget {
  const RecognitionMainScreen({super.key});

  @override
  State<RecognitionMainScreen> createState() => _RecognitionMainScreenState();
}

class _RecognitionMainScreenState extends State<RecognitionMainScreen> {
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageFinal = File(image.path);
      print("tesd");
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(image: imageFinal)));
      });
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Hey wtf !");
    return Scaffold(
      appBar: AppBar(title: const Text("Food recognition")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 100, right: 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                  ),
                  onPressed: () => pickImage(ImageSource.camera),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.camera_alt),
                      SizedBox(width: 10),
                      Text('Camera'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 100, right: 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                  ),
                  onPressed: () => pickImage(ImageSource.gallery),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.storage),
                      SizedBox(width: 10),
                      Text('Storage'),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
