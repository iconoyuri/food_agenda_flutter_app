// ignore_for_file: avoid_print
import 'dart:math' as math;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen({super.key, required this.image});

  final File image;

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  List boxes = [];
  @override
  Widget build(BuildContext context) {
    print("building");
    sendImageForPrediction(widget.image);
    return Scaffold(
        appBar: AppBar(title: const Text('Food recognition')),
        body: Stack(
          children: [Image.file(widget.image), ...boxes],
        ));
  }
  // body: Image.file(widget.image),

  void sendImageForPrediction(File image) async {
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    int width = decodedImage.width;
    int height = decodedImage.height;
    String urlInsertImage = 'http://192.168.104.127:5000/detection';
    var request = MultipartRequest("POST", Uri.parse(urlInsertImage));
    request.fields["imageWidth"] = width.toString();
    request.fields["imageHeight"] = height.toString();
    request.files.add(MultipartFile.fromBytes(
        "image", File(image.path).readAsBytesSync(),
        filename: image.path));
    try {
      var response = await request.send();
      Map data = jsonDecode(await response.stream.bytesToString());
      print(data["predictions"]);

      List _boxes = [];
      for (var prediction in data["predictions"]) {
        _boxes.add(Positioned.fill(
            child: CustomPaint(
          painter: OpenPainter(
              prediction["bbox"][0],
              prediction["bbox"][1],
              prediction["bbox"][2],
              prediction["bbox"][3],
              prediction["label"]),
        )));
      }
      setState(() {
        boxes = _boxes;
      });
    } on Exception {
      print("request failed");
    }
  }
}

class OpenPainter extends CustomPainter {
  final double xOffset;
  final double yOffset;
  final double width;
  final double height;
  final String label;

  OpenPainter(this.xOffset, this.yOffset, this.width, this.height, this.label);

  @override
  void paint(Canvas canvas, Size size) {
    Color coll =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    var paint1 = Paint()
      ..color = coll
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Offset(xOffset, yOffset) & Size(width, height), paint1);

    TextSpan span = TextSpan(
        style:
            TextStyle(color: Colors.black, fontSize: 15, backgroundColor: coll),
        text: label);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(xOffset - 10, yOffset - 10));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
