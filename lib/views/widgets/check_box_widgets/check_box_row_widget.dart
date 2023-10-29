// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CheckBoxRowWidget extends StatefulWidget {
  CheckBoxRowWidget({
    super.key,
    required this.list,
    required this.value,
    required this.activeColor,
    required this.checkColor,
    required this.boxName,
  });
  final List list;
  bool value;
  final Color activeColor;
  final Color checkColor;
  final String boxName;
  @override
  State<CheckBoxRowWidget> createState() => _CheckBoxRowWidgetState();
}

class _CheckBoxRowWidgetState extends State<CheckBoxRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.boxName),
        Checkbox(
          value: widget.value,
          activeColor: widget.activeColor,
          checkColor: widget.checkColor,
          onChanged: (bool? value) {
            if (value == true) {
              setState(() {
                widget.value = true;
              });
              widget.list.add(
                widget.activeColor,
              );
            } else {
              setState(() {
                widget.value = false;
              });
              widget.list.removeWhere(
                (element) => element == widget.activeColor,
              );
            }
          },
        ),
      ],
    );
  }
}
