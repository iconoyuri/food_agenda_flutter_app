import 'package:flutter/material.dart';

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
      // appBar: AppBar(
      //   title: const Text("Itadakimasu"),
      // ),
      body: Container(
        // foregroundDecoration:,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Itadakimasu",
                  style: TextStyle(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Roboto'),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    "an app to help you have healthier eating habits",
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ),
                const Divider(
                  height: 40,
                  color: Color.fromARGB(255, 238, 209, 207),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: const Text("What do you intend to do today ?")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () =>
                        {Navigator.pushNamed(context, '/annotation')},
                    child: Text("Annotate")),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () =>
                        {Navigator.pushNamed(context, '/take/picture')},
                    child: Text("Recognize"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => {
                        {Navigator.pushNamed(context, '/save/meal')},},
                  child: Text("Save meal"),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, '/take/picture')},
        child: const Icon(Icons.photo_camera),
      ),
    );
  }
}
