// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:itadakimasu/src/database_logic.dart';
import 'package:itadakimasu/ui/views/nav_drawer.dart';
import 'package:itadakimasu/ui/views/charts.dart';
import 'package:itadakimasu/ui/widgets/imc_drawer.dart';
import 'package:itadakimasu/ui/widgets/solo_info_card.dart';

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
  String preferedFood = "unknown";
  String eatingDay = "unknown";
  String userName = "User";
  List<Map<String, dynamic>> daysList = [];
  List<Map<String, dynamic>> eatenFoods = [];
  List<GDPData> means = [];
  double imc = 0;

  @override
  void initState() {
    super.initState();
    updateState();
  }

  Future<void> updateState() async {
    displayIMC();
    displayNextFoodPrediction();
    displayEatingDays();
    displayEatenFoods();
    maxBadProgram();
    maxGoodProgram();
    displayPreferedFood();
    displayEatingDay();
    displayUserName();
    displayMeans();
  }

  Future<void> displayIMC() async {
    double _imc = await DatabaseLogic.calculateIMC();
    setState(() {
      imc = _imc;
    });
  }

  Future<void> displayUserName() async {
    String username = await DatabaseLogic.getUserName();
    setState(() {
      userName = username;
    });
  }

  Future<void> displayPreferedFood() async {
    try {
      String _preferedFood = await DatabaseLogic.userFavoriteFood();
      setState(() {
        preferedFood = _preferedFood;
      });
    } on Exception {
    } on Error {}
  }

  Future<void> displayEatingDay() async {
    try {
      String _eatingDay = await DatabaseLogic.userEatingDay();
      setState(() {
        eatingDay = _eatingDay;
      });
    } on Exception {
    } on Error {}
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

  Future<void> displayMeans() async {
    List<GDPData> _means = await DatabaseLogic.getMeans();
    setState(() {
      means = _means;
    });
  }

  Future<void> displayNextFoodPrediction() async {
    try {
      String _nextFood = await DatabaseLogic.predictDayMeal();
      setState(() {
        nextFood = _nextFood;
      });
    } on Error {
      setState(() {
        nextFood = "[Unresolvable]";
      });
    } on Exception {
      setState(() {
        nextFood = "[Unresolvable]";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text("hamaï"),
      ),
      body: RefreshIndicator(
        onRefresh: updateState,
        child: Container(
          // foregroundDecoration:,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: HomeListView(
              nextFood: nextFood,
              daysList: daysList,
              eatenFoods: eatenFoods,
              maxBadPrescription: maxBadPrescription,
              maxGoodPrescription: maxGoodPrescription,
              imc: imc,
              preferedFood: preferedFood,
              eatingDay: eatingDay,
              userName: userName,
              means: means),
        ),
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
      required this.eatenFoods,
      required this.imc,
      required this.preferedFood,
      required this.eatingDay,
      required this.userName,
      required this.means})
      : super(key: key);

  final String nextFood;
  final String maxBadPrescription;
  final String maxGoodPrescription;
  final List<Map<String, dynamic>> daysList;
  final List<Map<String, dynamic>> eatenFoods;
  final List<GDPData> means;
  final double imc;
  final String preferedFood;
  final String eatingDay;
  final String userName;

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
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: <Widget>[
                const Expanded(
                    flex: 2,
                    child: Text(
                      "Welcome back",
                      style: TextStyle(fontSize: 20),
                    )),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        widget.userName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            fontFamily: 'QanelasSoft'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.person)
                    ],
                  ),
                )
              ]),
            ),
            const Divider(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(children: <Widget>[
                SoloInfoCard(
                    label: "Favorite food",
                    value: widget.preferedFood,
                    bgColor: const Color.fromARGB(255, 55, 221, 233)),
                SoloInfoCard(
                    label: "Eating day",
                    value: widget.eatingDay,
                    bgColor: const Color.fromARGB(255, 96, 76, 209))
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            ImcDrawer(imc: widget.imc),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: Column(children: <Widget>[
                const Text("What you will eat today is:",
                    style: TextStyle(
                        fontSize: 23,
                        // fontStyle: FontStyle.italic,
                        fontFamily: 'QanelasSoft')),
                Text(widget.nextFood,
                    style: const TextStyle(
                        fontSize: 68,
                        color: Colors.amber,
                        fontFamily: 'QanelasSoft')),
              ]),
            ),
            const Divider(
              height: 40,
            ),
            const Text("Diagrams",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'QanelasSoft')),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              child: Row(children: <Widget>[
                EatingHabitsChart(
                  daysList: widget.daysList,
                  chartTitle: 'Meals per day',
                ),
                EatingHabitsChart(
                  daysList: widget.eatenFoods,
                  chartTitle: 'Most eaten foods',
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            // Text(data)
            RadialMeansChart(means: widget.means, chartTitle: "Means"),
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
