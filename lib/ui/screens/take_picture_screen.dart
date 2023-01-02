import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Take a picture')),
      backgroundColor: Colors.black,
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            CameraView(
                initializeControllerFuture: _initializeControllerFuture,
                controller: _controller),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: 50,
                height: 50,
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: TakePhotoButton(
                    initializeControllerFuture: _initializeControllerFuture,
                    controller: _controller,
                    mounted: mounted))
          ],
        ),
      ),
    );
  }
}

class TakePhotoButton extends StatelessWidget {
  const TakePhotoButton({
    Key? key,
    required Future<void> initializeControllerFuture,
    required CameraController controller,
    required this.mounted,
  })  : _initializeControllerFuture = initializeControllerFuture,
        _controller = controller,
        super(key: key);

  final Future<void> _initializeControllerFuture;
  final CameraController _controller;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            if (!mounted) return;

            Navigator.pushNamed(context, '/display/picture',
                arguments: {'image': image});
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        icon: const Icon(
          Icons.camera_alt,
          color: Colors.black,
        ));
  }
}

class CameraView extends StatelessWidget {
  const CameraView({
    Key? key,
    required Future<void> initializeControllerFuture,
    required CameraController controller,
  })  : _initializeControllerFuture = initializeControllerFuture,
        _controller = controller,
        super(key: key);

  final Future<void> _initializeControllerFuture;
  final CameraController _controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return CameraPreview(_controller);
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
