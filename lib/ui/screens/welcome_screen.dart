import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/welcome.png",
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Hello new user",
                style: TextStyle(
                  fontFamily: 'QanelasSoft',
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Column(
                children: <Widget>[
                  const Text(
                    "Let's register",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            Navigator.pushReplacementNamed(
                                context, '/registration')
                          },
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.black,

                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      child: const Icon(Icons.arrow_forward_ios_sharp))
                ],
              )
            ]),
      )),
    );
  }
}
