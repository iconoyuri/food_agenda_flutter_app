import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  runApp(const MaterialApp(
    home: LoadingScreen(),
  ));
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> loadAssets(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), (() {
      Navigator.pushReplacementNamed(context, '/home');
    }));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color? secondaryColor = const Color.fromARGB(255, 255, 238, 0);
    loadAssets(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 87, 86, 80),
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.fastfood,
              size: 140,
              color: secondaryColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Itadakimasu",
              style: TextStyle(color: secondaryColor, fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            const SpinKitPulse(
              color: Colors.white,
              size: 30.0,
            )
          ],
        ),
      )),
    );
  }
}
