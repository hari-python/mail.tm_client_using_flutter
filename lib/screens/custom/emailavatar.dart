import 'package:flutter/material.dart';

class EmailAvatar extends StatelessWidget {
  const EmailAvatar({
    Key? key,
    required this.colour,
    required this.textString,
  }) : super(key: key);
  final Color colour;
  final String textString;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: colour,
      child: Center(
        child: Text(
          textString,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}