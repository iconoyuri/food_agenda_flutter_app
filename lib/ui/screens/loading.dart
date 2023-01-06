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
    // await Future.delayed(const Duration(seconds: 3), (() {
    //   Navigator.pushReplacementNamed(context, '/home');
    // }));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color? secondaryColor = const Color.fromARGB(255, 0, 0, 0);
    loadAssets(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/diet.png",
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "hamaï",
              style: TextStyle(
                  color: secondaryColor,
                  fontFamily: 'QanelasSoft',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
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
