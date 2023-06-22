import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color clr;
  final double txtSize;

  const RoundButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.clr,
      required this.txtSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            minimumSize: const Size(90, 80),
            backgroundColor: clr),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: txtSize),
        ));
  }
}
