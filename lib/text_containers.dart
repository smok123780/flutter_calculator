import 'package:flutter/material.dart';

class TextContainers extends StatelessWidget {
  final String value;
  final int maxLines;

  TextContainers(this.value, this.maxLines);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      child: RichText(
        text: TextSpan(
          text: value,
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        textAlign: TextAlign.end,
        maxLines: maxLines,
      ),
    );
  }
}
