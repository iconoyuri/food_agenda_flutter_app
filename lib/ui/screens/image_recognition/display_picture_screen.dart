// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:math' as math;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Food recognition')),
      body: Stack(
        children: [Image.file(widget.image), ...boxes],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {sendImageForPrediction(widget.image, context)},
        child: const Icon(Icons.rounded_corner_sharp),
      ),
    );
  }
  // body: Image.file(widget.image),

  void sendImageForPrediction(File image, BuildContext context) async {
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    int width = decodedImage.width;
    int height = decodedImage.height;
    String urlInsertImage = 'http://192.168.133.127:5000/detection';
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
              width,
              height,
              prediction["bbox"][0],
              prediction["bbox"][1],
              prediction["bbox"][2],
              prediction["bbox"][3],
              prediction["label"],
              context),
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
  late double xOffset;
  late double yOffset;
  late double width;
  late double height;
  late String label;

  // OpenPainter(this.xOffset, this.yOffset, this.width, this.height, this.label);
  OpenPainter(int imgWidth, int imgHeight, double xOffset, double yOffset,
      double width, double height, this.label, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double xRatio = screenWidth / imgWidth;
    double yRatio = screenHeight / imgHeight;
    this.xOffset = xOffset * xRatio;
    this.yOffset = yOffset * yRatio;
    this.width = width * xRatio;
    this.height = width * yRatio;
  }

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
