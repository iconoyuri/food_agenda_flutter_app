// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:itadakimasu/src/database_logic.dart';
import 'package:itadakimasu/ui/screens/nav_drawer.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text("Itadakimasu"),
      ),
      body: Container(
        // foregroundDecoration:,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: const HomeListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, '/take/picture')},
        child: const Icon(Icons.photo_camera),
      ),
    );
  }
}

class HomeListView extends StatefulWidget {
  const HomeListView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  String nextFood = "";

  void displayNextFoodPrediction() async {
    String _nextFood = await DatabaseLogic.predictDayMeal();
    setState(() {
      nextFood = _nextFood;
    });
  }

  @override
  Widget build(BuildContext context) {
    displayNextFoodPrediction();
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
            Text(nextFood,
                style: const TextStyle(
                    fontSize: 68,
                    color: Colors.amber,
                    // fontStyle: FontStyle.italic,
                    fontFamily: 'QanelasSoft')),
            // Text(DatabaseLogic.predictDayMeal())
          ],
        ),
      ],
    );
  }
}
