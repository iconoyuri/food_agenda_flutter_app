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
  List<Map<String, dynamic>> daysList = [];
  @override
  void initState() {
    super.initState();
    updateState();
    print("initializing state");
  }

  Future<void> updateState() async {
    print("updating state");
    await displayNextFoodPrediction();
    await displayEatingDays();
  }

  Future<void> displayEatingDays() async {
    List<Map<String, dynamic>> _daysList = await DatabaseLogic.eatingDays();
    setState(() {
      daysList = _daysList;
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
  const HomeListView({Key? key, required this.nextFood, required this.daysList})
      : super(key: key);

  final String nextFood;
  final List<Map<String, dynamic>> daysList;

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
            ),

            // const EatingHabitsChart(),
          ],
        ),
      ],
    );
  }
}
