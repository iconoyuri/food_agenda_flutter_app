import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itadakimasu/schemas/db_schemas.dart';

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
  bool existsUser = true;

  Future<void> loadAssets(BuildContext context) async {
    determineUserExistence();
    await Future.delayed(const Duration(seconds: 3), (() {
      if (existsUser) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        print("No user registered yet");
        Navigator.pushReplacementNamed(context, '/registration');
      }
    }));
  }

  Future<void> determineUserExistence() async {
    bool _existsUser = await User.existsUser();
    setState(() {
      existsUser = _existsUser;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAssets(context);
  }

  @override
  Widget build(BuildContext context) {
    Color? secondaryColor = const Color.fromARGB(255, 0, 0, 0);

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
              color: Color.fromARGB(255, 124, 124, 124),
              size: 30.0,
            )
          ],
        ),
      )),
    );
  }
}
