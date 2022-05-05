import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    @required this.name,
    @required this.onPressed,
    @required this.color,
  });

  final String name;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          elevation: 5.0,
          color: color,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: onPressed,
            minWidth: 200.0,
            height: 42.0,
            child: Text(
              name,
            ),
          ),
        ),
      ),
    );
  }
}
