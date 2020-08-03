import 'package:flutter/material.dart';
import 'package:flutter_calculator/keyboard_on_pressed.dart';
import 'package:flutter_calculator/main.dart';

class Keyboard extends MyApp {
  final KeyboardOnPressed keyboardOnPressed;

  Keyboard(this.keyboardOnPressed);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Table(
            children: [
              TableRow(
                children: [
                  button(context, "AC", Colors.grey[800]),
                  button(context, "÷", Colors.grey[800]),
                  button(context, "×", Colors.grey[800]),
                ],
              ),
              TableRow(
                children: [
                  button(context, "7", Colors.grey[600]),
                  button(context, "8", Colors.grey[600]),
                  button(context, "9", Colors.grey[600]),
                ],
              ),
              TableRow(
                children: [
                  button(context, "4", Colors.grey[600]),
                  button(context, "5", Colors.grey[600]),
                  button(context, "6", Colors.grey[600]),
                ],
              ),
              TableRow(
                children: [
                  button(context, "1", Colors.grey[600]),
                  button(context, "2", Colors.grey[600]),
                  button(context, "3", Colors.grey[600]),
                ],
              ),
              TableRow(
                children: [
                  button(context, "0", Colors.grey[600]),
                  button(context, "00", Colors.grey[600]),
                  button(context, ".", Colors.grey[600]),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Table(
            children: [
              TableRow(
                children: [
                  button(context, "⌫", Colors.orange),
                ],
              ),
              TableRow(
                children: [
                  button(context, "-", Colors.orange),
                ],
              ),
              TableRow(
                children: [
                  button(context, "+", Colors.orange),
                ],
              ),
              TableRow(
                children: [
                  button(context, "=", Colors.orange, buttonHeight: 2),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget button(BuildContext context, String buttonText, Color color,
      {double buttonHeight = 1}) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: MaterialButton(
          height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onPressed: () => keyboardOnPressed.onButtonPressed(buttonText)),
    );
  }
}
