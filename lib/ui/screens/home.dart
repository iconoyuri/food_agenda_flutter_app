// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:itadakimasu/src/database_logic.dart';
import 'package:itadakimasu/ui/views/nav_drawer.dart';
import 'package:itadakimasu/ui/views/charts.dart';

void main() => runApp(const MaterialApp(
      home: HomeScreen(),
    ));

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String nextFood = "";
  String maxBadPrescription = "";
  String maxGoodPrescription = "";
  List<Map<String, dynamic>> daysList = [];
  List<Map<String, dynamic>> eatenFoods = [];

  @override
  void initState() {
    super.initState();
    updateState();
  }

  Future<void> updateState() async {
    // await displayNextFoodPrediction();
    // await displayEatingDays();
    // await displayEatenFoods();
    // await maxBadProgram();
    // await maxGoodProgram();
  }

  Future<void> maxBadProgram() async {
    int maxQuantityFood = 5;
    int eatenQuantityFood = 0;
    String _maxBadPrescription = "You can eat ";
    List<Map<String, dynamic>> _mostEatenFoods =
        await DatabaseLogic.descOrderedRawFoods();
    for (Map<String, dynamic> a in _mostEatenFoods) {
      if (!(eatenQuantityFood < maxQuantityFood)) break;
      _maxBadPrescription = "$_maxBadPrescription ${a['name']},";
      eatenQuantityFood += 2; // 2kg of food for each dish
    }
    setState(() {
      maxBadPrescription = _maxBadPrescription;
    });
  }

  Future<void> maxGoodProgram() async {
    int maxQuantityFood = 5;
    int eatenQuantityFood = 0;
    String _maxGoodPrescription = "You must eat ";
    List<Map<String, dynamic>> _mostEatenFoods =
        await DatabaseLogic.descOrderedFoods();
    for (Map<String, dynamic> a in _mostEatenFoods) {
      if (!(eatenQuantityFood < maxQuantityFood)) break;
      _maxGoodPrescription = "$_maxGoodPrescription ${a['name']},";
      eatenQuantityFood += 2; // 2kg of food for each dish
    }
    setState(() {
      maxGoodPrescription = _maxGoodPrescription;
    });
  }

  Future<void> displayEatingDays() async {
    List<Map<String, dynamic>> _daysList = await DatabaseLogic.eatingDays();
    setState(() {
      daysList = _daysList;
    });
  }

  Future<void> displayEatenFoods() async {
    List<Map<String, dynamic>> _eatenFoods = await DatabaseLogic.eatenFoods();
    setState(() {
      eatenFoods = _eatenFoods;
    });
  }

  Future<void> displayNextFoodPrediction() async {
    String _nextFood = await DatabaseLogic.predictDayMeal();
    setState(() {
      nextFood = _nextFood;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text("Itadakimasu"),
      ),
      body: RefreshIndicator(
        onRefresh: updateState,
        child: Container(
          // foregroundDecoration:,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: HomeListView(
            nextFood: nextFood,
            daysList: daysList,
            eatenFoods: eatenFoods,
            maxBadPrescription: maxBadPrescription,
            maxGoodPrescription: maxGoodPrescription,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, '/take/picture')},
        child: const Icon(Icons.photo_camera),
      ),
    );
  }
}

class HomeListView extends StatefulWidget {
  const HomeListView(
      {Key? key,
      required this.nextFood,
      required this.maxBadPrescription,
      required this.maxGoodPrescription,
      required this.daysList,
      required this.eatenFoods})
      : super(key: key);

  final String nextFood;
  final String maxBadPrescription;
  final String maxGoodPrescription;
  final List<Map<String, dynamic>> daysList;
  final List<Map<String, dynamic>> eatenFoods;

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Welcome back user",
              style: TextStyle(
                  fontSize: 28,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'QanelasSoft'),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("What you will eat today is:",
                style: TextStyle(
                    fontSize: 18,
                    // fontStyle: FontStyle.italic,
                    fontFamily: 'QanelasSoft')),
            Text(widget.nextFood,
                style: const TextStyle(
                    fontSize: 68,
                    color: Colors.amber,
                    fontFamily: 'QanelasSoft')),
            EatingHabitsChart(
              daysList: widget.daysList,
              chartTitle: 'Meals per day',
            ),
            EatingHabitsChart(
              daysList: widget.eatenFoods,
              chartTitle: 'Most eaten foods',
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("The max bad food recommendation",
                style: TextStyle(
                    fontSize: 18,
                    // fontStyle: FontStyle.italic,
                    fontFamily: 'QanelasSoft')),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.maxBadPrescription,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("The max good food recommendation",
                style: TextStyle(
                    fontSize: 18,
                    // fontStyle: FontStyle.italic,
                    fontFamily: 'QanelasSoft')),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.maxGoodPrescription,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ],
    );
  }
}
