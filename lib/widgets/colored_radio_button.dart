import 'package:flutter/material.dart';

class ColoredRadioButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color defaultColor;
  final bool isSelected;

  ColoredRadioButton({
    this.onPressed,
    this.defaultColor,
    this.isSelected,
  });

  @override
  State<StatefulWidget> createState() => _ColoredRadioButton();
}

class _ColoredRadioButton extends State<ColoredRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: CircleAvatar(
          radius: 9,
          backgroundColor:
          widget.isSelected ? Colors.black : widget.defaultColor,
          child: CircleAvatar(
              radius: 7,
              backgroundColor: widget.defaultColor,
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.adjust, color: widget.defaultColor, size: 1),
                onPressed: () {
                  widget.onPressed();
                },
              )
          ),
        ));
  }
}