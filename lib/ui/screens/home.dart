import 'package:flutter/material.dart';
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
        child: HomeListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, '/take/picture')},
        child: const Icon(Icons.photo_camera),
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              "Welcome back user",
              style: TextStyle(
                  fontSize: 28,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'QanelasSoft'),
            ),
          ],
        ),
      ],
    );
  }
}
