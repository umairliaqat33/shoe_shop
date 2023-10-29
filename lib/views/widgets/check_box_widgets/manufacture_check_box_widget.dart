// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';

class ManufactureCheckBoxWidget extends StatefulWidget {
  ManufactureCheckBoxWidget({
    super.key,
    required this.type,
    required this.value,
    required this.boxName,
  });
  String type;
  bool value;
  final String boxName;
  @override
  State<ManufactureCheckBoxWidget> createState() =>
      _ManufactureCheckBoxWidgetState();
}

class _ManufactureCheckBoxWidgetState extends State<ManufactureCheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.boxName),
        Checkbox(
          value: widget.value,
          onChanged: (bool? value) {
            if (value == true) {
              setState(() {
                widget.value = true;
                widget.type = widget.boxName;
              });
            } else {
              setState(() {
                widget.value = false;
                widget.type = '';
              });
            }
            log(widget.type);
          },
        ),
      ],
    );
  }
}
