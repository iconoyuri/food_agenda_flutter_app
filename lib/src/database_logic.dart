import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class DatabaseLogic {
  static Future<String> predictDayMeal() async {
    String currentDay = DateFormat('EEEE').format(DateTime.now());
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> list = await db.rawQuery('''
          SELECT name 
          FROM Food
          JOIN (
            SELECT COUNT(id_food), id_food 
            FROM Meal 
            JOIN (
              SELECT * 
              FROM _Day 
              WHERE _Day.name=?
            ) AS Today ON Meal.id_day = Today.id 
              GROUP BY id_food
              ORDER BY COUNT(id_food) DESC
              LIMIT 1
          ) AS MostEatenFood ON Food.id = MostEatenFood.id_food
      ''', [currentDay]);
    return list[0]["name"];
  }

  static Future<List<Map<String, dynamic>>> eatingDays() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> list = await db.rawQuery(
      '''
          SELECT name, COUNT(name)
          FROM _Day
          JOIN Meal
          ON id = id_day
          GROUP BY id
          ORDER BY id ASC
      ''',
    );
    return list;
  }

  static Future<List<Map<String, dynamic>>> eatenFoods() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> list = await db.rawQuery(
      '''
          SELECT name, COUNT(name)
          FROM Food
          JOIN Meal
          ON id = id_food
          GROUP BY id
      ''',
    );
    return list;
  }

  static Future<List<Map<String, dynamic>>> descOrderedRawFoods() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> list = await db.rawQuery(
      '''
          SELECT name 
          FROM Food
          JOIN Meal 
          ON id = id_food
          GROUP BY name
          ORDER BY COUNT(name) DESC
      ''',
    );
    return list;
  }

  static Future<List<Map<String, dynamic>>> descOrderedFoods() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> list = await db.rawQuery(
      '''
          SELECT name 
          FROM Food
          JOIN (
            SELECT id_food 
            FROM Meal
            JOIN HealthProblem ON HealthProblem.id = Meal.id_healthPB
            WHERE HealthProblem.name = ''
          )
          ON id = id_food
          GROUP BY name
          ORDER BY COUNT(name) DESC
      ''',
    );
    return list;
  }

  static Future<double> calculateIMC() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    final List<Map<String, dynamic>> list = await db.query('user');
    double userHeight = list[0]["height"] / 100.0;
    double userWeight = list[0]["weight"] * 1.0;
    double imc = userWeight / (userHeight * userHeight);
    return imc;
  }

  static Future<String> getUserName() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );
    final List<Map<String, dynamic>> list = await db.query('user');
    return list[0]["name"];
  }

  static Future<String> userFavoriteFood() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> list = await db.rawQuery(
      '''
          SELECT name 
          FROM Food
          JOIN (
            SELECT * 
            FROM Meal
          )
          ON id = id_food
          GROUP BY name
          ORDER BY COUNT(name) DESC
      ''',
    );

    return list[0]["name"];
  }

  static Future<String> userEatingDay() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'food_recommendation.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> list = await db.rawQuery(
      '''
          SELECT name 
          FROM _Day
          JOIN (
            SELECT * 
            FROM Meal
          )
          ON id = id_day
          GROUP BY name
          ORDER BY COUNT(name) DESC
      ''',
    );

    return list[0]["name"];
  }
}
