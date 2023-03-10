import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:itadakimasu/ui/screens/home.dart';
import 'package:itadakimasu/ui/screens/first_screens/loading.dart';
import 'package:itadakimasu/ui/screens/image_recognition/food_recognition_main_screen.dart';
import 'package:itadakimasu/ui/screens/image_annotation/picker_image.dart';
import 'package:itadakimasu/ui/screens/register_food.dart';
import 'package:itadakimasu/ui/screens/first_screens/registration_screen.dart';
import 'package:itadakimasu/ui/screens/first_screens/welcome_screen.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  await createDatabase();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': ((context) => const LoadingScreen()),
      '/welcome': ((context) => const WelcomeScreen()),
      '/registration': ((context) => const RegistrationScreen()),
      '/home': ((context) => const HomeScreen()),
      '/recognition': ((context) => const RecognitionMainScreen()),
      '/annotation': ((context) => const PickerImage()),
      '/save/meal': ((context) => const RegisterFood()),
    },
  ));
}

Future<void> createDatabase() async {
  // Get a reference to the database.
  await openDatabase(
    join(await getDatabasesPath(), 'food_recommendation.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      db.execute(
        '''
          CREATE TABLE User(
            name TEXT NOT NULL UNIQUE,
            age INTEGER NOT NULL,
            height INTEGER NOT NULL,
            weight INTEGER NOT NULL
          ); ''',
      );
      db.execute(
        '''
           CREATE TABLE HealthProblem(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE
          ); ''',
      );
      db.execute(
        '''
          CREATE TABLE Food(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE
          );''',
      );
      db.execute(
        '''
          CREATE TABLE _Day(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE
          );
        ''',
      );
      db.execute(
        '''
          CREATE TABLE Meal(
            id_food INT,
            id_healthPB INT,
            id_day INT,
            water_quantity INT,
            fruits_eaten INT,
            nb_towel_mvt INT,
            FOREIGN KEY(id_food) REFERENCES Food(id),
            FOREIGN KEY(id_healthPB) REFERENCES Health_Problem(id),
            FOREIGN KEY(id_day) REFERENCES _Day(id)
          );
        ''',
      );
      return null;
    },
    version: 1,
  );
}
