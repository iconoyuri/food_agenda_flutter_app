import 'package:flutter/material.dart';

class SoloInfoCard extends StatefulWidget {
  const SoloInfoCard(
      {super.key,
      required this.label,
      required this.value,
      required this.bgColor});

  final String label;
  final String value;
  final Color bgColor;

  @override
  State<SoloInfoCard> createState() => _SoloInfoCardState();
}

class _SoloInfoCardState extends State<SoloInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        color: widget.bgColor,
        child: Container(
          // height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.label,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.value,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'QanelasSoft',
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
