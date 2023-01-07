// ignore_for_file: non_constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Food {
  // final int id;
  final String name;

  const Food({
    // required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
    };
  }

  Future<int> insertDatabase() async {
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
    final List<Map<String, dynamic>> list =
        await db.query("Food", where: 'name = "$name"');
    return list[0]["id"];
  }
}

class User {
  final String name;
  final int age;
  final int height;
  final int weight;

  const User({
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'age': age,
      'height': height,
      'weight': weight,
    };
  }

  Future<void> insertDatabase() async {
    // Get a reference to the database.
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    // In this case, replace any previous data.
    await db.insert(
      'User',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  static Future<bool> existsUser() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    return (await db.query('user')).isNotEmpty;
  }


}

class HealthPB {
  // final int id;
  final String name;

  const HealthPB({
    // required this.id,
    required this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
    };
  }

  Future<int> insertDatabase() async {
    // Get a reference to the database.
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    // In this case, replace any previous data.
    await db.insert(
      'HealthProblem',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    final List<Map<String, dynamic>> list =
        await db.query("HealthProblem", where: 'name = "$name"');
    return list[0]["id"];
  }
}

class Day {
  // final int id;
  final String name;

  const Day({
    // required this.id,
    required this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
    };
  }

  Future<int> insertDatabase() async {
    // Get a reference to the database.
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    // In this case, replace any previous data.
    await db.insert(
      '_Day',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    final List<Map<String, dynamic>> list =
        await db.query("_Day", where: 'name = "$name"');
    return list[0]["id"];
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

  Future<Database> insertDatabase() async {
    // Get a reference to the database.
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    // In this case, replace any previous data.
    await db.insert(
      'Meal',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return db;
  }
}
