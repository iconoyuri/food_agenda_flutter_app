import 'package:flutter/material.dart';

class RegisterFood extends StatefulWidget {
  const RegisterFood({super.key});

  @override
  State<RegisterFood> createState() => _RegisterFoodState();
}

class _RegisterFoodState extends State<RegisterFood> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _label = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = 10;
    String radioGroup = 'yes';
    return Scaffold(
      appBar: AppBar(title: Text('Save meal')),
      body: SafeArea(
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _label,
                    decoration:
                        InputDecoration(filled: false, labelText: "Food eaten"),
                    // The validator receives the text that the user has entered.
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
                    controller: _label,
                    decoration: InputDecoration(
                        filled: false, labelText: "Quantity of water"),
                    // The validator receives the text that the user has entered.
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
                    controller: _label,
                    decoration: InputDecoration(
                        filled: false, labelText: "Number towel movement"),
                    // The validator receives the text that the user has entered.
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
                    controller: _label,
                    decoration: InputDecoration(
                        filled: false, labelText: "Health problem"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: sizedBoxHeight + 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Did you eat Fruits ?"),
                      RadioListTile(
                        title: Text("Yes"),
                        value: "yes",
                        groupValue: radioGroup,
                        onChanged: (value) {
                          setState(() {
                            radioGroup = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("No"),
                        value: "no",
                        groupValue: radioGroup,
                        onChanged: (value) {
                          setState(() {
                            radioGroup = value.toString();
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
