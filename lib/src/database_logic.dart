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
}
