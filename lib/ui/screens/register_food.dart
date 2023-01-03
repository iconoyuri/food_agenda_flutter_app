// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:intl/intl.dart';
import 'package:itadakimasu/schemas/db_schemas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:itadakimasu/src/database_logic.dart';

class RegisterFood extends StatefulWidget {
  const RegisterFood({super.key});

  @override
  State<RegisterFood> createState() => _RegisterFoodState();
}

class _RegisterFoodState extends State<RegisterFood> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController food_eaten = TextEditingController();
  TextEditingController water_quantity = TextEditingController();
  TextEditingController towel_movement = TextEditingController();
  TextEditingController health_problem = TextEditingController();
  RadioGroupController eaten_fruits = RadioGroupController();

  void saveFormInfos() async {
    if (_formKey.currentState!.validate()) {
      String currentDay = DateFormat('EEEE').format(DateTime.now());
      // Map infos = {
      //   "day": currentDay,
      //   "food_eaten": food_eaten.text,
      //   "water_quantity": int.parse(water_quantity.text),
      //   "towel_movement": int.parse(towel_movement.text),
      //   "health_problem": health_problem.text,
      //   "eaten_fruits": eaten_fruits.value == "yes" ? 1 : 0,
      // };
      print("test");
      DatabaseLogic.predictDayMeal();
      // await saveData(
      //     infos["day"],
      //     infos["food_eaten"],
      //     infos["water_quantity"],
      //     infos["towel_movement"],
      //     infos["health_problem"],
      //     infos["eaten_fruits"]);
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
    }
  }

  Future<void> saveData(String _day, String foodEaten, int waterQuantity,
      int towelMovement, String healthProblem, int eatingFruits) async {
    Food food = Food(name: foodEaten);
    int foodId = await food.insertDatabase();
    Day day = Day(name: _day);
    int dayId = await day.insertDatabase();
    HealthPB healthPB = HealthPB(name: healthProblem);
    int healthpbId = await healthPB.insertDatabase();

    Meal meal = Meal(
        fruits_eaten: eatingFruits,
        id_day: dayId,
        id_food: foodId,
        id_healthPB: healthpbId,
        water_quantity: waterQuantity,
        nb_towel_mvt: towelMovement);
    Database db = await meal.insertDatabase();
    // final List<Map<String, dynamic>> meals = await db.query('Meal');
    // print(meals);
  }

  String? validateIntForm(value) {
    return null;
    if (value == null || value.isEmpty) return "Please enter a number";
    try {
      int.parse(value);
    } on FormatException {
      return "Please enter a valid number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = 10;
    return Scaffold(
      appBar: AppBar(title: const Text('Save meal')),
      body: SafeArea(
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: food_eaten,
                    decoration: const InputDecoration(
                        filled: false, labelText: "Food eaten"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  TextFormField(
                      controller: water_quantity,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          filled: false, labelText: "Quantity of water"),
                      // The validator receives the text that the user has entered.
                      validator: validateIntForm),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  TextFormField(
                      controller: towel_movement,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          filled: false, labelText: "Number towel movement"),
                      // The validator receives the text that the user has entered.
                      validator: validateIntForm),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  TextField(
                    controller: health_problem,
                    decoration: const InputDecoration(
                        filled: false, labelText: "Health problem"),
                  ),
                  SizedBox(
                    height: sizedBoxHeight + 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Did you eat fruits ?"),
                      const SizedBox(
                        height: 10,
                      ),
                      RadioGroup(
                        controller: eaten_fruits,
                        values: const ["yes", "no"],
                        indexOfDefault: 0,
                        orientation: RadioGroupOrientation.Horizontal,
                        decoration: const RadioGroupDecoration(
                          spacing: 10.0,
                          labelStyle: TextStyle(
                            color: Colors.blue,
                          ),
                          activeColor: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: sizedBoxHeight + 30,
                  ),
                  ElevatedButton(
                    onPressed: saveFormInfos,
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.black,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    child: const Text(
                      'Save',
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
