import 'package:flutter/material.dart';
import 'package:itadakimasu/schemas/db_schemas.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/boy.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const UserRegistrationForm()
            ],
          ),
        ),
      )),
    );
  }
}

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({super.key});

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = 10;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: name,
              style: const TextStyle(fontSize: 15),
              decoration: const InputDecoration(
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  labelText: "Username",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0, color: Color.fromARGB(0, 255, 255, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)))),
              // style: TextStyle(fontSize: ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            TextFormField(
                controller: age,
                style: const TextStyle(fontSize: 15),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    filled: true,
                    labelText: "age",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0, color: Color.fromARGB(0, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)))),
                validator: validateIntForm),
            SizedBox(
              height: sizedBoxHeight,
            ),
            TextFormField(
                controller: height,
                style: const TextStyle(fontSize: 15),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    filled: true,
                    labelText: "Height (cm)",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0, color: Color.fromARGB(0, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)))),
                validator: validateIntForm),
            SizedBox(
              height: sizedBoxHeight,
            ),
            TextFormField(
                controller: weight,
                style: const TextStyle(fontSize: 15),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    labelText: "Weight (kg)",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0, color: Color.fromARGB(0, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)))),
                validator: validateIntForm),
            SizedBox(
              height: sizedBoxHeight + 30,
            ),
            ElevatedButton(
              onPressed: saveFormInfos,
              style: ElevatedButton.styleFrom(
                // primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              child: const Text(
                'Register',
              ),
            )
          ],
        ),
      ),
    );
  }

  String? validateIntForm(value) {
    if (value == null || value.isEmpty) return "Please enter a number";
    try {
      int.parse(value);
    } on FormatException {
      return "Please enter a valid number";
    }
    return null;
  }

  void saveFormInfos() async {
    if (_formKey.currentState!.validate()) {
      Map data = {
        "name": name.text,
        "age": int.parse(age.text),
        "height": int.parse(height.text),
        "weight": int.parse(weight.text),
      };

      User user = User(
          name: data["name"],
          age: data["age"],
          height: data["height"],
          weight: data["weight"]);
      user.insertDatabase();

      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
