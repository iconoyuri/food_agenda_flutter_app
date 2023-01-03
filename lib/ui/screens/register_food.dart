import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:intl/intl.dart';
import 'package:itadakimasu/schemas/db_schemas.dart';
import 'package:sqflite/sqflite.dart';

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

  void getFormInfos() {
    // if (_formKey.currentState!.validate()) {
    if (true) {
      String currentDay = DateFormat('EEEE').format(DateTime.now());
      Map infos = {
        "day": currentDay,
        "food_eaten": food_eaten.text,
        "water_quantity": water_quantity.text,
        "towel_movement": towel_movement.text,
        "health_problem": health_problem.text,
        "eaten_fruits": eaten_fruits.value,
      };
      saveData();
    }
  }

  Future<void> saveData() async {
    Food food = Food(id: 2, name: "eru");
    Database db = await food.insertDatabase();
    print("insertion ok");
    final List<Map<String, dynamic>> maps = await db.query('Food');
    print(maps);
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
                    decoration: const InputDecoration(
                        filled: false, labelText: "Quantity of water"),
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
                    controller: towel_movement,
                    decoration: const InputDecoration(
                        filled: false, labelText: "Number towel movement"),
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
                    controller: health_problem,
                    decoration: const InputDecoration(
                        filled: false, labelText: "Health problem"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
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
                    onPressed: getFormInfos,
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
