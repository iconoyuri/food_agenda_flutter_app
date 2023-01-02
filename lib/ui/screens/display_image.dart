import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itadakimasu/src/image_painter.dart';

import '../../services/storage.dart';

class DisplayImage extends StatefulWidget {
  DisplayImage({Key? key, required this.image}) : super(key: key);

  File? image;

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  final _imageKey = GlobalKey<ImagePainterState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _label = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String a = _label.value as String;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ImagePainter.file(
            widget.image!,
            key: _imageKey,
            scalable: true,
            initialStrokeWidth: 2,
            textDelegate: TextDelegate(),
            initialColor: Colors.green,
            initialPaintMode: PaintMode.freeStyle,
            onDrawingEnd: _registerDialog(),
          ),
        ),
      ),
    );
  }

  AlertDialog _registerDialog() {
    return AlertDialog(
      title: const Text(
        "Name the selection",
      ),
      content: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _label,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ],
        ),
      ), // a widget with return your form for register a food
      actions: [
        TextButton(
          onPressed: () {
            final state = _imageKey.currentState!;
            //remove last
            state.paintHistory = state.paintHistory;
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
          ),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final state = _imageKey.currentState!;
              _formKey.currentState!
                  .save(); //_formkey is the key of your register form
              String label = _label.value as String;
              PaintInfo paintInfo = state.paintHistory.last;
              String data =
                  '{  "label" : $label,  "coordinate": ${paintInfo.toJson()}, }';

              Storage storage = Storage(fileName: label, data: data);
              storage.write();
              Navigator.pop(context);
            }
          },
          child: const Text(
            "Done",
          ),
        ),
      ],
    );
  }
}
