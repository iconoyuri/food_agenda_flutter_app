// ignore_for_file: non_constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Food {
  final int id;
  final String name;

  const Food({
    required this.id,
    required this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  Future<Database> insertDatabase() async {
    // Get a reference to the database.
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    // In this case, replace any previous data.
    await db.insert(
      'Food',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return db;
  }
}

class HealthPB {
  final int id;
  final String name;

  const HealthPB({
    required this.id,
    required this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  Future<void> insertDog() async {
    // Get a reference to the database.
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    // In this case, replace any previous data.
    await db.insert(
      'Health_Problem',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }
}

class Day {
  final int id;
  final String name;

  const Day({
    required this.id,
    required this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  Future<void> insertDog() async {
    // Get a reference to the database.
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    // In this case, replace any previous data.
    await db.insert(
      '_Day',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }
}

class Meal {
  final int id_food;
  final int id_healthPB;
  final int id_day;
  final int water_quantity;
  final int fruits_eaten;
  final int nb_towel_mvt;

  const Meal({
    required this.id_food,
    required this.id_healthPB,
    required this.id_day,
    required this.water_quantity,
    required this.fruits_eaten,
    required this.nb_towel_mvt,
  });
  Map<String, dynamic> toMap() {
    return {
      "id_food": id_food,
      "id_healthPB": id_healthPB,
      "id_day": id_day,
      "water_quantity": water_quantity,
      "fruits_eaten": fruits_eaten,
      "nb_towel_mvt": nb_towel_mvt
    };
  }

  Future<void> insertDog() async {
    // Get a reference to the database.
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    // In this case, replace any previous data.
    await db.insert(
      'Meal',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }
}
