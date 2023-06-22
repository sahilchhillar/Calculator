import 'package:flutter/material.dart';

class ButtonZero extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color clr;
  final double txtSize;

  const ButtonZero(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.clr,
      required this.txtSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: clr,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        minimumSize: const Size(200, 70),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: txtSize),
      ),
    );
  }
}
