import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:itadakimasu/ui/screens/home.dart';
import 'package:itadakimasu/ui/screens/loading.dart';
import 'package:itadakimasu/ui/screens/take_picture_screen.dart';
import 'package:itadakimasu/ui/screens/display_picture_screen.dart';
import 'package:itadakimasu/ui/screens/picker_image.dart';
import 'package:itadakimasu/ui/screens/register_food.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // O_incrementCounterbtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': ((context) => const LoadingScreen()),
      '/home': ((context) => const HomeScreen()),
      '/take/picture': ((context) => TakePictureScreen(
            camera: firstCamera,
          )),
      '/display/picture': ((context) => const DisplayPictureScreen()),
      '/annotation': ((context) => const PickerImage()),
      '/save/meal': ((context) => const RegisterFood()),
    },
  ));
}
